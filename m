Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRKVTUy>; Thu, 22 Nov 2001 14:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281488AbRKVTUp>; Thu, 22 Nov 2001 14:20:45 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:9650 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S281458AbRKVTUe>; Thu, 22 Nov 2001 14:20:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: slowdown on Via ide chipsets with 2.4.15?
Date: Thu, 22 Nov 2001 14:20:31 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011122192037Z281458-17408+17489@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

something i just took notice while fixing my computers.  
hdparm -t to test the speed of drives, i have in the past had about 30MB/s 
across all my drives.  
Now, my primary disk, which is the only one on it's channel, gets 19MB/s 
(udma2 speeds).  It's an udma4 drive and i've seen it get 30+ on average in 
earlier kernels.  My primary master on the promise card gets 30+ still, but 
my slave on the same channel gets 19MB/s even though the master is not being 
used.  I know there is to be expected some performance drop, but that much is 
a little disconcerting.  I have my atapi devices on the secondary channel of 
my via controller (motherboard) and the second channel on the promise card 
will be used for my new drive.  
The harddrives are configured exactly the way they used to be and the kernel 
is compiled with the exact same options for ide/dma and such.   The 
changefile doesn't look like the via ide drivers were messed with.   The only 
other difference is that all my drives are now ext3.

Controller (motherboard)  VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 
controller on pci00:07.1
Controller (card)  PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode 
Secondary PCI Mode.

All drives are set to UDMA4 (ATA66)    hdparm isn't used,  simple check shows 
that everything is set the way it should be default.  

Also, the kernel displays UDMA(66)    wouldn't it be  ATA66.  UDMA comes in 
1,2,4, and 5.  that's like, ata16, ata33, ata66 and ata100.        
