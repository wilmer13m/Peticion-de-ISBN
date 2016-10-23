//
//  ViewController.swift
//  Peticion al Servidor
//
//  Created by Wilmer Mendoza on 23/10/16.
//  Copyright © 2016 Wilmer Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var isbnTextField: UITextField!
    
    @IBOutlet weak var peticionTextView: UITextView!
    
    var isbn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isbnTextField.delegate = self
        
        
        
    }
    
    
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("entro aqui")
        
        if isbnTextField.text != nil || isbnTextField.text != ""{
            
            
            isbn = isbnTextField.text!
            
            print(isbn)
            
            buscarProductos(isbn)
            
            if isbnTextField.isFirstResponder() == true{
                
                isbnTextField.resignFirstResponder()
                
            }
         }
        
         return true
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isbnTextField.resignFirstResponder()
    }
    
    func buscarProductos(id : String)  {
        
        
        let url = NSURL(string: "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)")
        
        
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            //verificando si ha ocurrido un error
            
            guard data != nil else {
                print(error)
                return
            }
            
            do{
                
                //parseando la data del json
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? [String: AnyObject] {
                    
                   print(json)
                    
                    
                
                    //recargo la data del collectionView de manera asincrona
                    dispatch_async(dispatch_get_main_queue(), {
                        self.peticionTextView.text = String(json)
                    })
                
                
                }
                
                
                
            }catch let error as NSError {
                print("error serializing JSON: \(error)")
                print("rntro aqui")
            }
            
        }.resume()
        
    }
    


}

