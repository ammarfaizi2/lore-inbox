Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315443AbSE2TwF>; Wed, 29 May 2002 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSE2TwE>; Wed, 29 May 2002 15:52:04 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:15569 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S315443AbSE2TwC>; Wed, 29 May 2002 15:52:02 -0400
Message-ID: <3CF53160.B97CE3E2@delusion.de>
Date: Wed, 29 May 2002 21:52:00 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.19 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: IDE breakage with cdrom in 2.5.18+
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Some code introduced in 2.5.18 seems to have broken something in the
cdrom code. 2.5.19 still has the problem, whereas 2.5.17 seemed ok.

/dev/hde shows packet command errors upon bootup. Any ideas?

Regards,
-Udo.

ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Promise Technology, Inc. 20265, PCI slot 00:11.0
PCI: Found IRQ 10 for device 00:11.0
ATA: chipset rev.: 2
ATA: non-legacy mode: IRQ probe delayed
Promise Technology, Inc. 20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x8000-0x8007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x8008-0x800f, BIOS settings: hdc:pio, hdd:pio
ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:04.1
ATA: chipset rev.: 16
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686a (rev 22) ATA UDMA66 controller on PCI 00:04.1
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hde: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide0 at 0x9400-0x9407,0x9002 on irq 10
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 60036480 sectors w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
 hda: hda1
 hdb: 60036480 sectors w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
hde: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hde: packet command error: status=0x51 { DriveReady SeekComplete Error } 
hde: packet command error: error=0x54
ATAPI device hde:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Request Sense" packet command was: 
  "03 00 00 00 12 00 00 00 00 00 00 00 "
