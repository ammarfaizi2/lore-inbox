Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNELv>; Tue, 13 Feb 2001 23:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBNELl>; Tue, 13 Feb 2001 23:11:41 -0500
Received: from mailserver2.ddsl.net ([202.9.145.19]:15373 "EHLO eth.net")
	by vger.kernel.org with ESMTP id <S129027AbRBNEL0>;
	Tue, 13 Feb 2001 23:11:26 -0500
X-KMail-Redirect-From: Ashwin D <ashwinds@yahoo.com>
From: Ashwin D <ashwinds@yahoo.com> (by way of Ashwin D
	<ashwinds@yahoo.com>)
Date: Wed, 14 Feb 2001 09:38:18 +0530
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.4.x?? 
Mime: Is mine not mime
MIME-Version: 1.0
Message-Id: <01021409381901.00688@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Well, it may not be a bug, but it sure is bugging me - i have been on this 
for more than a week. Well, here goes; 

Why is it that my DMA performance under the kernel 2.4.x is worse than the
one under 2.2? I have attached the stats below the mail- information and test
results under both kernels.

I use the following option under rc.local to set dma ;
         /sbin/hdparm -c1 -d1 -m16 -X66 /dev/hda

I use resierfs, Iam disappointed that 2.4 results are about 1/3rd and need to
know what to do.

I use a i810 mobo and seagate 8.4 gb hdd

I have tried recompiling the kernel - iam informed a broken .config could 
have caused this, but no change. 
I have tried random settings with hdparm to tune /dev/hda.

Thanks for your time.
Ashwin
(Iam not on the list yet, so please cc me personally) 

-------------------------
TEST RESULTS
___________________________

a) Kernel 2.2.17 (mandrake)

(i) hdpartm -i:
/dev/hda:

 Model=ST38420A, FwRev=3.07, SerialNo=7AZ0PTZT
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16841664
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2

(ii) hdpartm -t:
/dev/hda:
 Timing buffered disk reads:  64 MB in  4.38 seconds = 14.61 MB/sec


b) Kernel 2.4.1 (linux )

(i) hdparm -i
/dev/hda:

 Model=ST38420A, FwRev=3.07, SerialNo=7AZ0PTZT
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16841664
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2

(ii) hdparm -t

/dev/hda:
 Timing buffered disk reads:  64 MB in 11.61 seconds =  5.51 MB/sec
