//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Stefan Olarescu on 20.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false
    
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.red)
        
//        Button("Hello, world!") {
//            print(type(of: self.body))
//        }
//        .frame(width: 200, height: 200)
//        .background(.yellow)
        
        Text("Hello, world!")
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
        
        body2
        
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .red : .blue)
        
        // Using a regular if condition is slower than using the ternary operator
        if useRedText {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundStyle(.red)
        } else {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundStyle(.blue)
        }
        
//        VStack {
//            Text("Gryffindor")
//                .font(.largeTitle)
//            Text("Hufflepuff")
//            Text("Ravenclaw")
//            Text("Slytherin")
//        }
//        .font(.title)
        
//        VStack {
//            Text("Gryffindor")
//                .blur(radius: 0)
//            Text("Hufflepuff")
//            Text("Ravenclaw")
//            Text("Slytherin")
//        }
//        .blur(radius: 5)
        
//        VStack {
//            motto1
//                .foregroundStyle(.red)
//            motto2
//                .foregroundStyle(.blue)
//            motto3
//        }
        
//        VStack {
//            spells
//            spells2
//            spells3
//        }
        
//        VStack(spacing: 10) {
//            CapsuleText(text: "First")
//            CapsuleText(text: "Second")
//        }
//        
//        Text("Hello World")
//            .titleStyle()
        
        Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with Swift")
        
        GridStack(rows: 4, columns: 4) { row, column in
            Text("R\(row)C\(column)")
        }
        
        GridStack(rows: 4, columns: 4) { row, column in
            // we defined the content with @ViewBuilder, so SwiftUI
            // knows to arrange these two views in some kind of stack
            Image(systemName: "\(row * 4 + column).circle")
            Text("R\(row)C\(column)")
        }
    }
    
    // This (the fact that the type of body2 is Text) is totally acceptable
    // It doesn't specifically need to be some View
    var body2: Text {
        Text("Hello, world!")
    }
    
    var motto3: some View {
        Text("Draco dormiens")
    }
    
    var spells: some View {
        VStack {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    var spells2: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    @ViewBuilder var spells3: some View {
        Text("Lumos")
        Text("Obliviate")
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
