Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQKESfx>; Sun, 5 Nov 2000 13:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQKESfo>; Sun, 5 Nov 2000 13:35:44 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:64774 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129931AbQKESfY>; Sun, 5 Nov 2000 13:35:24 -0500
Date: Sun, 5 Nov 2000 20:35:18 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 440FX and DMA on 2.2.18pre18
Message-ID: <20001105203518.K1248@niksula.cs.hut.fi>
In-Reply-To: <20001105184736.J1248@niksula.cs.hut.fi> <Pine.LNX.4.10.10011050912140.12463-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <Pine.LNX.4.10.10011050912140.12463-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 09:27:36AM -0800, you [Andre Hedrick] said:          
>                                                                               
> On Sun, 5 Nov 2000, Ville Herva wrote:                                        
>                                                                               
> > You mean that if I apply the IDE-patch, I can get some DMA mode working?    
>                                                                               
> YES!!! in a word ;-)                                                          
                                                                                
Okay, I can confirm that:                                                       
                                                                                
hdparm -c1 -d1 /dev/hda                                                         
                                                                                
/dev/hda:                                                                       
 setting 32-bit I/O support flag to 1                                           
 setting using_dma to 1 (on)                                                    
 I/O support  =  1 (32-bit)                                                     
 using_dma    =  1 (on)                                                         
                                                                                
                                                                                
hdparm  /dev/hda                                                                
                                                                                
/dev/hda:                                                                       
 multcount    =  0 (off)                                                        
 I/O support  =  1 (32-bit)                                                     
 unmaskirq    =  0 (off)                                                        
 using_dma    =  1 (on)                                                         
 keepsettings =  1 (on)                                                         
 nowerr       =  0 (off)                                                        
 readonly     =  0 (off)                                                        
 readahead    =  8 (on)                                                         
 geometry     = 3737/255/63, sectors = 60036480, start = 0                      
                                                                                
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5              
                                                                                
hdparm -tT /dev/hda                                                             
                                                                                
/dev/hda:                                                                       
 Timing buffer-cache reads:   128 MB in  2.55 seconds = 50.20 MB/sec            
 Timing buffered disk reads:  64 MB in  5.73 seconds = 11.17 MB/sec             
                                                                                
                                                                                
Not a top-notch result, but I guess 440FX just isn't capable of better. In      
any case, that's heck of a lot better that the <3MB/s I was getting in          
PIO mode without the IDE-patch.                                                 
                                                                                
                                                                                
-- v --                                                                         
                                                                                
v@iki.fi                                                                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
