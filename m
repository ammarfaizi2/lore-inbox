Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267314AbRGMMfz>; Fri, 13 Jul 2001 08:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbRGMMfp>; Fri, 13 Jul 2001 08:35:45 -0400
Received: from [62.8.161.162] ([62.8.161.162]:3090 "EHLO mail.tevox.de")
	by vger.kernel.org with ESMTP id <S267314AbRGMMfd>;
	Fri, 13 Jul 2001 08:35:33 -0400
Date: Fri, 13 Jul 2001 14:35:27 +0200
From: Lars Weitze <cd@kalkatraz.de>
To: linux-kernel@vger.kernel.org
Subject: Corruption with ATA100 Maxtor 80 GB
Message-Id: <20010713143527.4f2f6884.cd@kalkatraz.de>
Organization: http://www.liquidsteel.net
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Server: VPOP3 V1.4.0b - Registered to: TEVOX GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have following problem: When coping large files from one 80 GB Harddisk
to it's counterpart (sync made with cpbk every night) the kernel just
crashes. This happend when connected to the on-bord (IDE82371AB PIIX4 IDE
(rev 01) )  the first time. Then I switched to an Promise Ultra100 TX2
Controller (20268 Chip) and installed hedricks ide-patch. I still had bugs
left. Now after using hdparm -X32 /dev/hdx the system seems stable. 
Also i had: 
Jul 10 21:30:23 bigmama kernel: EXT2-fs error (device ide0(3,2)):
ext2_free_blocks: Freeing blocks not in datazone - block = 134217728,
count = 1
Jul 10 21:30:23 bigmama last message repeated 8 times

Any idea if it's a hardware bug or bad drivers?
Lars
-----
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev
2).
       Master Capable.  Latency=64.  
       Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
2).
       Master Capable.  Latency=64.  Min Gnt=128.
   Bus  0, device   4, function  0:
     ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
   Bus  0, device   4, function  1:
     IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
       Master Capable.  Latency=32.  
       I/O at 0xd800 [0xd80f].
   Bus  0, device   4, function  2:
     USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
       IRQ 15.
       Master Capable.  Latency=32.  
       I/O at 0xd400 [0xd41f].
   Bus  0, device   4, function  3:
     Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
       IRQ 9.
   Bus  0, device   6, function  0:
     SCSI storage controller: Adaptec AHA-2940U2/W / 7890 (rev 0).
       IRQ 15.
       Master Capable.  Latency=32.  Min Gnt=39.Max Lat=25.
       I/O at 0xd000 [0xd0ff].
       Non-prefetchable 64 bit memory at 0xe2000000 [0xe2000fff].
   Bus  0, device  10, function  0:
     Unknown mass storage controller: Promise Technology, Inc. 20268 (rev
1).
       IRQ 12.
       Master Capable.  Latency=32.  Min Gnt=4.Max Lat=18.
       I/O at 0xb800 [0xb807].
       I/O at 0xb400 [0xb403].
       I/O at 0xb000 [0xb007].
       I/O at 0xa800 [0xa803].
       I/O at 0xa400 [0xa40f].
       Non-prefetchable 32 bit memory at 0xe1800000 [0xe1803fff].
   Bus  0, device  11, function  0:
     Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev
48).
       IRQ 10.
       Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
       I/O at 0xa000 [0xa07f].
       Non-prefetchable 32 bit memory at 0xe1000000 [0xe100007f].
   Bus  0, device  12, function  0:
     VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
[Millennium] (rev 1).
       IRQ 11.
       Non-prefetchable 32 bit memory at 0xe0800000 [0xe0803fff].
       Prefetchable 32 bit memory at 0xe3000000 [0xe37fffff].
