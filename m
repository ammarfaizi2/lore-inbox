Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSICIHG>; Tue, 3 Sep 2002 04:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSICIHG>; Tue, 3 Sep 2002 04:07:06 -0400
Received: from h-64-105-35-215.SNVACAID.covad.net ([64.105.35.215]:20900 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318730AbSICIHF>; Tue, 3 Sep 2002 04:07:05 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 3 Sep 2002 01:11:18 -0700
Message-Id: <200209030811.BAA03979@adam.yggdrasil.com>
To: aia21@cantab.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.31 doesn't boot - looks IDE related
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It turns out that the stock 2.5.33 drivers/ide (Jens's port of
the 2.4 IDE drivers to 2.5) also exhibits this problem, so it appears
not to be a bug due to Marcin's drivers/ide changes.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


I wrote:
>On 2002-08-13, Anton Altaparmakov wrote:
>
>>2.5.31 dies with the last messages being:
>>[snip]
>>ATA/ATAPI device driver v7.0.0
>>ATA: PCI bus speed 33.3MHz
>>ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
>>ATA: chipset rev.: 6
>>ATA: non-legacy mode: IRQ probe delayed
>>VP_IDE: VIA vt82c686b (rev 40) ATA UDMA100 controller on PCI 00:07.1
>>    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>>    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
>>hda: IC35L040AVER07-0, DISK drive
>>hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive 
>>hdd: Maxtor 90288D2, DISK drive 
>>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>ide1 at 0x170-0x177,0x376 on irq 15
>><it is dead>
>
>        I tried to reproduce your problem on two Via motherboard,
>which I set up with the following configuration:
>
>                Primary IDE:    Master: A Maxtor IDE hard disk as master.
>
>                Secondary IDE:  Master: An ATAPI CDROM or DVD-ROM drive.
>                                Slave:  Another Maxtor IDE hard disk (17.2GB)
>
>        One of the motherboards had an 866MHz CPU and did not experience
>any problem.
>
>        The other one, with a 1GHz CPU, failed to recognize the ATAPI
>CDROM, but recognized both hard disks, and did not hang.  Rebooting with
>the slave hard disk removed resulted in the ATAPI drive to being
>recognized.  Patching from approxiamtely stock 2.5.31 to Martin's IDE 115
>on the misbehaving machine CDROM did not change these behaviors.
[...]
