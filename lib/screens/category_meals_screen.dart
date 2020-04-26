import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static String routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId;
  String categoryTitle;
  List<Meal> diplayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      diplayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    _loadedInitData = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    void _removeMeal(String id) {
      setState(() {
        diplayedMeals.removeWhere((meal) => meal.id == id);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: diplayedMeals[index].id,
            title: diplayedMeals[index].title,
            imageUrl: diplayedMeals[index].imageUrl,
            duration: diplayedMeals[index].duration,
            complexity: diplayedMeals[index].complexity,
            affordability: diplayedMeals[index].affordability,
          );
        },
        itemCount: diplayedMeals.length,
      ),
    );
  }
}
