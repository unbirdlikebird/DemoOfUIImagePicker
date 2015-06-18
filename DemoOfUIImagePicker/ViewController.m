//
//  ViewController.m
//  DemoOfUIImagePicker
//
//  Created by Dianyi Jiang on 18/06/15.
//  Copyright (c) 2015 Dianyi Jiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UITextViewDelegate,UIAlertViewDelegate , UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic)  NSMutableArray *arrayOfImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"repair report";
    self.navigationController.
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    [self layoutUI];
}

- (void)layoutUI{
    [self layoutBasicInfo];
    [self layoutOfTextView];
    [self loadImageArea];
    [self layoutOfButton];
}


- (void)layoutBasicInfo{
    UIView *viewOfBasicInfo = [[UIView alloc]init];
    viewOfBasicInfo.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblOfUserName = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 55)];
    lblOfUserName.textAlignment = NSTextAlignmentLeft;
    [lblOfUserName setText:@"name"];
    
    UILabel *lblOfUserNameDes = [[UILabel alloc]initWithFrame:CGRectMake(lblOfUserName.frame.size.width + 20, 0, SCREEN_WIDTH - lblOfUserName.frame.size.width - 40, 55)];
    lblOfUserNameDes.textAlignment = NSTextAlignmentRight;
    [lblOfUserNameDes setText:@"jack chen"];
    lblOfUserNameDes.textColor = [UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1.0];
    
    UIView *viewOfLine =[[UIView alloc]initWithFrame:CGRectMake(0, lblOfUserName.frame.size.height, SCREEN_WIDTH, 1)];
    viewOfLine.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *lblOfUserPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(20, lblOfUserName.frame.size.height + 1, 100, 55)];
    lblOfUserPhoneNumber.textAlignment = NSTextAlignmentLeft;
    [lblOfUserPhoneNumber setText:@"phone number"];
    
    UILabel *lblOfUserPhoneNumberDes = [[UILabel alloc]initWithFrame:CGRectMake(lblOfUserPhoneNumber.frame.size.width + 20, lblOfUserName.frame.size.height + 1, SCREEN_WIDTH - lblOfUserPhoneNumber.frame.size.width - 40, 55)];
    lblOfUserPhoneNumberDes.textAlignment = NSTextAlignmentRight;
    [lblOfUserPhoneNumberDes setText:@"13904110001"];
    lblOfUserPhoneNumberDes.textColor = [UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1.0];
    
    
    CGRect rect = CGRectMake(0, 70, SCREEN_WIDTH, lblOfUserName.frame.size.height + 1 + lblOfUserPhoneNumber.frame.size.height);
    viewOfBasicInfo.frame = rect;
    
    [viewOfBasicInfo addSubview:lblOfUserName];
    [viewOfBasicInfo addSubview:lblOfUserNameDes];
    [viewOfBasicInfo addSubview:viewOfLine];
    [viewOfBasicInfo addSubview:lblOfUserPhoneNumber];
    [viewOfBasicInfo addSubview:lblOfUserPhoneNumberDes];
    
    [self.view addSubview:viewOfBasicInfo];
}

- (void)layoutOfTextView{
    UITextView *txtViewOfContent = [[UITextView alloc]initWithFrame:CGRectMake(20, 200, SCREEN_WIDTH - 40, 200)];
    txtViewOfContent.textColor = [UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1.0];
    
    [txtViewOfContent.layer setCornerRadius:10];
    [txtViewOfContent.layer setMasksToBounds:YES];
    txtViewOfContent.text = @"please input your message...";
    [self.view addSubview:txtViewOfContent];
}

- (void)loadImageArea{
    int offsetX = 0;
    
    if ([self.arrayOfImage count] == 0) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20 + offsetX, 420, 50, 50)];
        [button addTarget:self action:@selector(didTappedPictureArea:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        
        button.tag = 0;
        button.selected = YES;
        [self.view addSubview:button];
    }
    
    for (int index = 0; index < self.arrayOfImage.count; index ++) {
        if (index == 0) {
            offsetX = 0;
        }
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20 + offsetX, 420, 50, 50)];
        [button addTarget:self action:@selector(didTappedPictureArea:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageWithData:[self.arrayOfImage objectAtIndex:index]] forState:UIControlStateNormal];
        
        button.tag = index;
        button.selected = YES;
        
        [self.view addSubview:button];
        
        offsetX += 60;
    }
    
    if ([self.arrayOfImage count] != 5) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20 + offsetX, 420, 50, 50)];
        [button addTarget:self action:@selector(didTappedPictureArea:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
    }
}

- (void)deleteImageArea{
    for (UIButton *tmpButton in self.view.subviews) {
        if ([tmpButton isKindOfClass:[UIButton class]] && tmpButton.tag != 1000) {
            [tmpButton removeFromSuperview];
            tmpButton.selected = NO;
        }
    }
}

- (void)didTappedPictureArea:(UIButton *)sender{
    NSLog(@"%ld", (long)sender.tag);
    
    if (sender.selected == YES) {
        UIAlertView *alertiewOfPictureSeted = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请选择对照片%ld的操作", (long)sender.tag]delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        alertiewOfPictureSeted.tag = 1101;
        [alertiewOfPictureSeted show];
    }else{
        UIAlertView *alertiewOfPictureNotSet = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择照片来源"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册", @"相机", nil];
        alertiewOfPictureNotSet.tag = 1102;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] || [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
            [alertiewOfPictureNotSet show];
        }else{
            UIAlertView *tmpAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不支持该操作"delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [tmpAlert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1101){
        if (buttonIndex == 1) {
            //            删除 需要判断点击的是第几个照片 并进行相应的移位操作
            int index = [[alertView.message substringWithRange:NSMakeRange(6, 1)]intValue];
            [self.arrayOfImage removeObjectAtIndex:index];
            [self deleteImageArea];
            [self loadImageArea];
        }
    }else{
        switch (buttonIndex) {
                
            case 1:
                //相册
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    imagePickerController.delegate = self;
                    imagePickerController.allowsEditing = YES;
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:imagePickerController animated:YES completion:nil];
                }
                break;
                
            case 2:
                //相机
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    imagePickerController.delegate = self;
                    imagePickerController.allowsEditing = YES;
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePickerController animated:YES completion:nil];
                }
                break;
                
            default:
                break;
        }
    }
    
}
#pragma mark - image Picker controller

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:[NSString stringWithFormat:@"%d", arc4random()]];
}

- (void)deleteImage:(UIImage *)currentImage withName:(NSString *)imageName{
    
}

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    
    NSString *imageFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/tmpImage"] ;
    if(![[NSFileManager defaultManager] fileExistsAtPath:imageFolderPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:imageFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *imagePath = [imageFolderPath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:imagePath atomically:NO];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        [self.arrayOfImage addObject:imageData];
        [self deleteImageArea];
        [self loadImageArea];
    }
}

- (NSMutableArray *)arrayOfImage{
    if (!_arrayOfImage) {
        _arrayOfImage = [[NSMutableArray alloc]initWithCapacity:5];
    }
    return _arrayOfImage;
}

- (void)layoutOfButton{
    UIButton *btnOfComfirm = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 80, SCREEN_WIDTH - 40, 40)];
    btnOfComfirm.backgroundColor = [UIColor colorWithRed:7.0/255.0 green:65.0/255.0 blue:58.0/255.0 alpha:1.0];
    btnOfComfirm.tag = 1000;
    [btnOfComfirm.layer setCornerRadius:10];
    [btnOfComfirm.layer setMasksToBounds:YES];
    [btnOfComfirm setTitle:@"confirm" forState:UIControlStateNormal];
    
    [self.view addSubview:btnOfComfirm];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TextField delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (id tmp in self.view.subviews) {
        [tmp resignFirstResponder];
    }
}


@end
