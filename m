Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbREQWOE>; Thu, 17 May 2001 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbREQWNy>; Thu, 17 May 2001 18:13:54 -0400
Received: from radio.protv.ro ([193.230.227.51]:32526 "EHLO radio.protv.ro")
	by vger.kernel.org with ESMTP id <S261268AbREQWNn>;
	Thu, 17 May 2001 18:13:43 -0400
Message-ID: <3979.193.230.227.44.990137620.squirrel@radio.protv.ro>
Date: Fri, 18 May 2001 01:13:40 +0300 (EEST)
Subject: 2.4.4-ac10  IDE Floppy Still hangs 
From: "Mihai Moldovanu" <mihaim@profm.ro>
To: linux-kernel@vger.kernel.org
Reply-To: mihaim@profm.ro
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok . There still is a problem even in 2.4.4-ac10 with IDE FLoppy .
Here is what i did and errors i got .

[root@m /mnt]# mount /dev/hdd4 /mnt/zip
ide-floppy: hdd: I/O error, pc = 5a, key =  5, asc = 24, ascq =  0
ide-floppy: hdd: I/O error, pc = 5a, key =  5, asc = 24, ascq =  0
[root@m /mnt]# mkdir /mnt/zip/test
[root@m /mnt]# sync
( at this point system seems to freeze, but after aprox 1 minute it recovers )
hdd: lost interrupt
ide-floppy: CoD != 0 in idefloppy_pc_intr
hdd: ATAPI reset complete
[root@m /mnt]#

This is my system configuration:

[root@m /mnt]# uname -a
Linux m 2.4.4-ac10 #1 Fri May 18 00:40:46 EEST 2001 i686 unknown


May 18 00:53:41 m kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
May 18 00:53:41 m kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
May 18 00:53:41 m kernel: VP_IDE: chipset revision 6
May 18 00:53:41 m kernel: VP_IDE: not 100%% native mode: will probe irqs later
May 18 00:53:41 m kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
May 18 00:53:41 m kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100
controller on pci00:07.1
May 18 00:53:41 m kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings:
hda:DMA, hdb:pio
May 18 00:53:41 m kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings:
hdc:DMA, hdd:pio
May 18 00:53:41 m kernel: hda: IBM-DTLA-307030, ATA DISK drive
May 18 00:53:41 m kernel: hdc: Pioneer DVD-ROM ATAPIModel DVD-114 0124,
ATAPI CD/DVD-ROM drive
May 18 00:53:41 m kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
May 18 00:53:41 m kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 18 00:53:41 m kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 18 00:53:41 m kernel: hda: 60036480 sectors (30739 MB) w/1916KiB Cache,
CHS=29314/64/32, UDMA(100)
May 18 00:53:41 m kernel: hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
May 18 00:53:41 m kernel: Uniform CD-ROM driver Revision: 3.12
May 18 00:53:41 m kernel: hdd: 98304kB, 196608 blocks, 512 sector size,
May 18 00:53:41 m kernel: hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector
size, 2941 rpm
May 18 00:53:41 m kernel: ide-floppy: hdd: I/O error, pc = 5a, key =  5, asc
= 24, ascq =  0


Do you have any suggestions ?

-- 
TFM Group Romania , Linux division

Mihai Moldovanu


