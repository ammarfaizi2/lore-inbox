Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277093AbRJDC7X>; Wed, 3 Oct 2001 22:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRJDC7O>; Wed, 3 Oct 2001 22:59:14 -0400
Received: from chia.umiacs.umd.edu ([128.8.120.111]:36481 "EHLO
	chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
	id <S277093AbRJDC7J>; Wed, 3 Oct 2001 22:59:09 -0400
Date: Wed, 3 Oct 2001 22:59:35 -0400 (EDT)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <adam@chia.umiacs.umd.edu>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Re: Lost interrupt with HPT370
Message-ID: <Pine.GSO.4.33.0110032232000.6592-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
Content-Type-X: multipart/mixed; boundary="------------3897B7E0F65FF08A89ED6C92"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
	just wanted to let you know that your blacklist of
	ata-100 drives for HPT3 is most likely overzealous.

	as you state you tested it only with 41gb.

	I own
		IBM's 61gb IC35L060AVER07-0 drive.
		ABIT KG7-RAID with HPT370

	First I have been running "Linux version 2.4.2-2" RH7.1
	and this sets the above setup to ATA-100 and I had not
	experienced any problems.

	Once I "upgraded" to 2.4.10 my drive got blacklisted and
	runs as ata-44.

	to double check, I removed the driver from blacklist for
	100 and 66 and recompiled kernel, and it seems to be
	running fine so far.

now there's weird part, for both drive running at ATA-44 and ATA-100
I get pretty much same numbers from hdparam. Perhaps it just an change to
printf alone, and drive runs at ata-100 even it if says that it is ata-44
? what kind of numbers should I expect from ATA-100 drive anyway?

hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(44)
dev/hde:
 Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
 Timing buffered disk reads:  64 MB in  1.68 seconds = 38.10 MB/sec

hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.68 seconds =188.24 MB/sec
 Timing buffered disk reads:  64 MB in  1.69 seconds = 37.87 MB/sec

---------------------------------------

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc400-0xc407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: hdc:DMA, hdd:DMA
HPT370A: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:09.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hda: WDC WD272AA, ATA DISK drive
hdc: QPS CD-R PX-W8432T, ATAPI CD/DVD-ROM drive
hdd: LG DVD-ROM DRD-8120B, ATAPI CD/DVD-ROM drive
hde: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
hda: 53128656 sectors (27202 MB) w/2048KiB Cache, CHS=3307/255/63,  UDMA(66)
hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63,  UDMA(100)

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers



