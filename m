Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbTIGTwC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTIGTwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:52:02 -0400
Received: from [62.73.196.111] ([62.73.196.111]:23818 "EHLO
	ogonek.server.freewave.no") by vger.kernel.org with ESMTP
	id S261333AbTIGTvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:51:53 -0400
Message-ID: <10539.80.202.106.246.1062964311.squirrel@to.server.sensewave.com>
Date: Sun, 7 Sep 2003 21:51:51 +0200 (CEST)
Subject: hi-res fb console with 2.6.0-testX ? 
From: <cheapisp@sensewave.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.1.0 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel command lines which work with vesafb and matroxfb in 2.4 do not 
                                   
work for me in 2.6.0-testX.                                                
                                   
                                                                           
                                   
kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 video=matrox:vesa:0x11A       
                                   
kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 vga=794                       
                                   
                                                                           
                                   
both result in something resembling a Vesa 101 mode under 2.6.0-test4-mm3. 
                                   
(640x480, 60 Hz)                                                           
                                   
                                                                           
                                   
I'd expect 1280x1024 in 60 Hz, which is what I get with a 2.4 kernel.      
                                   
Doing fbset "vesa11A" causes the monitor to lose the sync.                 
                                   
Current vc then reports :                                                  
                                   
                                                                           
                                   
mode "1280x1024-61"                                                        
                                   
    # D: 109.890 MHz, H: 63.594 kHz, V: 61.089 Hz                          
                                   
    geometry 1280 1024 1280 1024 16                                        
                                   
    timings 9100 288 32 14 1 128 2                                         
                                   
    accel true                                                             
                                   
    rgba 5/11,6/5,5/0,0/0                                                  
                                   
endmode                                                                    
                                   
                                                                           
                                   
which looks about right, but the neighbor vc reports:                      
                                   
                                                                           
                                   
mode "640x480-203"                                                         
                                   
    # D: 109.890 MHz, H: 101.002 kHz, V: 203.223 Hz                        
                                   
    geometry 640 480 1280 1024 16                                          
                                   
    timings 9100 288 32 14 1 128 2                                         
                                   
    accel true                                                             
                                   
    rgba 5/11,6/5,5/0,0/0                                                  
                                   
endmode                                                                    
                                   
                                                                           
                                   
which appears to be a little off the mark....                              
                                   
(Got this by typing 'fbset', 'alt-F2, 'fbset' while the monitor was blanked.
                                  
I got my /etc/fb.modes from here:                                          
                                        
http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/fb.modes.vesa60.gz    
                                   
                                                                           
                                   
                                                                           
                                   
Hardware:                                                                  
                                   
Matrox G450DH + Hansol 19" LCD panel. Analog connection.                   
                                   
                                                                           
                                   
                                                                           
                                   
X works perfectly:                                                         
                                   
(II) MGA(0): I2C Monitor info: 0x867c2a8                                   
                                   
(II) MGA(0): Manufacturer: HSL  Model: 603b  Serial#: 0                    
                                   
(II) MGA(0): Year: 2003  Week: 18                                          
                                   
(II) MGA(0): EDID Version: 1.3                                             
                                   
(II) MGA(0): Analog Display Input,  Input Voltage Level: 0.714/0.286 V     
                                   
(II) MGA(0): Sync:  Separate                                               
                                   
(II) MGA(0): Max H-Image Size [cm]: horiz.: 34  vert.: 27                  
                                   
(II) MGA(0): Gamma: 1.00                                                   
                                   
(II) MGA(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display     
                                   
(II) MGA(0): redX: 0.608 redY: 0.342   greenX: 0.286 greenY: 0.565         
                                   
(II) MGA(0): blueX: 0.141 blueY: 0.089   whiteX: 0.291 whiteY: 0.314       
                                   
(II) MGA(0): Supported VESA Video Modes:                                   
                                   
(II) MGA(0): 720x400@70Hz                                                  
                                   
(II) MGA(0): 640x480@60Hz                                                  
                                   
(II) MGA(0): 640x480@67Hz                                                  
                                   
(II) MGA(0): 640x480@72Hz                                                  
                                   
(II) MGA(0): 640x480@75Hz                                                  
                                   
(II) MGA(0): 800x600@56Hz                                                  
                                   
(II) MGA(0): 800x600@60Hz                                                  
                                   
(II) MGA(0): 800x600@72Hz                                                  
                                   
(II) MGA(0): 800x600@75Hz                                                  
                                   
(II) MGA(0): 832x624@75Hz                                                  
                                   
(II) MGA(0): 1024x768@60Hz                                                 
                                   
(II) MGA(0): 1024x768@70Hz                                                 
                                   
(II) MGA(0): 1024x768@75Hz                                                 
                                   
(II) MGA(0): 1280x1024@75Hz                                                
                                   
(II) MGA(0): 1152x870@75Hz                                                 
                                   
(II) MGA(0): Manufacturer's mask: 0                                        
                                   
(II) MGA(0): Supported Future Video Modes:                                 
                                   
(II) MGA(0): #0: hsize: 640  vsize 480  refresh: 60  vid: 16433            
                                   
(II) MGA(0): #1: hsize: 800  vsize 600  refresh: 60  vid: 16453            
                                   
(II) MGA(0): #2: hsize: 1024  vsize 768  refresh: 60  vid: 16481           
                                   
(II) MGA(0): #3: hsize: 1280  vsize 1024  refresh: 60  vid: 32897          
                                   
(II) MGA(0): Supported additional Video Mode:                              
                                   
(II) MGA(0): clock: 108.0 MHz   Image Size:  338 x 270 mm                  
                                   
(II) MGA(0): h_active: 1280  h_sync: 1328  h_sync_end 1440 h_blank_end 1688
h_border: 0                        
(II) MGA(0): v_active: 1024  v_sync: 1025  v_sync_end 1028 v_blanking: 1066
v_border: 0                        
(II) MGA(0): Ranges: V min: 56  V max: 77 Hz, H min: 30  H max: 81 kHz,
PixClock max 140 MHz                   
(II) MGA(0): Monitor name: H950                                            
                                   
(II) MGA(0): end of I2C Monitor info                                       
                                   
                                                                           
                                   
                                                                           
                                                                           
                                                                           
                                                                           
                      
                                                                           
                                   
../get-edid: get-edid version 1.4.1                                         
                                   
                                                                           
                                   
        Performing real mode VBE call                                      
                                   
        Interrupt 0x10 ax=0x4f00 bx=0x0 cx=0x0                             
                                   
        Function supported                                                 
                                   
        Call successful                                                    
                                   
                                                                           
                                   
        VBE version 300                                                    
                                   
        VBE string at 0xc5597 "Matrox Graphics Inc."                       
                                   
                                                                           
                                   
        VBE/DDC service about to be called                                 
                                   
        Report DDC capabilities                                            
                                   
                                                                           
                                   
        Performing real mode VBE call                                      
                                   
        Interrupt 0x10 ax=0x4f15 bx=0x0 cx=0x0                             
                                   
        Function supported                                                 
                                   
        Call successful                                                    
                                   
                                                                           
                                   
        Monitor and video card combination does not support DDC1 transfers 
                                   
        Monitor and video card combination supports DDC2 transfers         
                                   
        0 seconds per 128 byte EDID block transfer                         
                                   
        Screen is not blanked during DDC transfer                          
                                   
                                                                           
                                   
Reading next EDID block                                                    
                                   
                                                                           
                                   
VBE/DDC service about to be called                                         
                                   
        Read EDID                                                          
                                   
                                                                           
                                   
        Performing real mode VBE call                                      
                                   
        Interrupt 0x10 ax=0x4f15 bx=0x1 cx=0x0                             
                                   
        Function supported                                                 
                                   
        Call successful                                                    
                                                                           
                                                                      

[+ a little binary crap here.....]                                            
Is the fbconsole support in 2.6 somewhat broken, or am I missing something
obvious?                                                             
                                                                           
                                   
                                                                           
                                   
Dag                                                                        
                                   
                                                                           
                                   

