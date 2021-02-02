import UIKit

class NetworkService {

  
  func downloadURLSFromServer(completion: @escaping (Result<[ImageObject], NetworkError>) -> Void) {
    let url = URL(string: "https://eulerity-hackathon.appspot.com/image")!
    let urlRequest = URLRequest(url: url)
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      guard let data = data else {
        completion(.failure(.badURL))
        return
      }
      print(response!)
      if let error = error {
        print(error.localizedDescription)
      }

      do {
        let jsonDecoder = JSONDecoder()
        let urlArray = try jsonDecoder.decode([ImageObject].self, from: data)
        DispatchQueue.main.async {
          completion(.success(urlArray))
        }

      } catch {
        print(error)
      }

    }.resume()
  }
}
