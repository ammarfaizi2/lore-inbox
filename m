Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUFWWPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUFWWPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUFWWI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:08:26 -0400
Received: from palrel10.hp.com ([156.153.255.245]:14740 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261752AbUFWWGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:06:01 -0400
Date: Wed, 23 Jun 2004 15:05:57 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [BUG 2.6.7] : Partition table display bogus...
Message-ID: <20040623220557.GA26199@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Would one of you guys would be kind enough to redirect this
e-mail to the right person ;-)

	Playing with 2.6.7 on my laptop. I realised Lilo did not work
anymore. Look further, and the partition table was all screwed
up. Looked further, and I realised the kernel doesn't recognise the
geometry of my hard drive.
	I did not try other 2.6.X kernel, on the other hand various
2.4.X kernel works on the box. Kernel are direct from kernel.org.

	Below is the after/before. First is 2.6.7 (bogus), second is
2.4.23 (correct).

	Thanks in advance...

	Jean

-----------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1820-0x1827, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1828-0x182f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DARA-206000, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 9767520 sectors (5000 MB) w/418KiB Cache, CHS=10336/15/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
-----------------------------------------------------------------
Disk /dev/hda: 15 heads, 63 sectors, 10336 cylinders
Units = cylinders of 945 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1      1168    551848+  a0  IBM Thinkpad hibernation
Partition 1 does not end on cylinder boundary:
     phys=(72, 239, 63) should be (72, 14, 63)
/dev/hda2          1169      6176   2366280    b  Win95 FAT32
Partition 2 does not end on cylinder boundary:
     phys=(385, 239, 63) should be (385, 14, 63)
/dev/hda3   *      6177      8352   1028160   83  Linux
Partition 3 does not end on cylinder boundary:
     phys=(521, 239, 63) should be (521, 14, 63)
/dev/hda4          8353     10336    937440    5  Extended
Partition 4 does not end on cylinder boundary:
     phys=(645, 239, 63) should be (645, 14, 63)
/dev/hda5          8353      8624    128488+  82  Linux swap
/dev/hda6          8625     10336    808888+  83  Linux
-----------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1820-0x1827, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1828-0x182f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DARA-206000, ATA DISK drive
blk: queue c0278820, I/O limit 4095Mb (mask 0xffffffff)
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 9767520 sectors (5001 MB) w/418KiB Cache, CHS=646/240/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
-----------------------------------------------------------------
Disk /dev/hda: 240 heads, 63 sectors, 646 cylinders
Units = cylinders of 15120 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1        73    551848+  a0  IBM Thinkpad hibernation
/dev/hda2            74       386   2366280    b  Win95 FAT32
/dev/hda3   *       387       522   1028160   83  Linux
/dev/hda4           523       646    937440    5  Extended
/dev/hda5           523       539    128488+  82  Linux swap
/dev/hda6           540       646    808888+  83  Linux
-----------------------------------------------------------------
