CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(50)
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  Product VARCHAR(50),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Daisy');

INSERT INTO Orders (OrderID, CustomerID, Product) VALUES
(101, 1, 'Laptop'),
(102, 2, 'Phone'),
(103, 2, 'Tablet'),
(104, 4, 'Headphones');
SELECT CustomerName,
  (SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID) AS TotalOrders
FROM Customers;

SELECT CustomerName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE Product = 'Laptop');

SELECT CustomerName
FROM Customers C
WHERE EXISTS (SELECT 1 FROM Orders O WHERE O.CustomerID = C.CustomerID);

SELECT OrderID, Product, CustomerID
FROM Orders O1
WHERE OrderID = (
  SELECT MAX(OrderID) FROM Orders O2 WHERE O1.CustomerID = O2.CustomerID
);

SELECT AVG(OrderCount) AS AvgOrders
FROM (
  SELECT CustomerID, COUNT(*) AS OrderCount
  FROM Orders
  GROUP BY CustomerID
) AS OrderSummary;
