Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSFZCIv>; Tue, 25 Jun 2002 22:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSFZCIu>; Tue, 25 Jun 2002 22:08:50 -0400
Received: from [202.145.83.35] ([202.145.83.35]:45581 "EHLO ite.techarea.org")
	by vger.kernel.org with ESMTP id <S316258AbSFZCIt>;
	Tue, 25 Jun 2002 22:08:49 -0400
Date: Wed, 26 Jun 2002 10:08:12 +0800
From: Richard Liu <richliu@ite.techarea.org>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: ATAPI CDROM at  DMA mode problem
Message-Id: <20020626095000.0B09.RICHLIU@ite.techarea.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
  I have some problem about use DMA mode transfer data .
when I use "hdparm -d1 /dev/hdd" to setting cdrom to DMA mode

my built-in VIA chipset VT82C868B IDE work fine.
but
PROMISE Ultra66(PDC20262) and CMD649 also have problem.
system will hang on. 
and if I use PIO mode to transfer data, the system is fine, no problem.
beside some kernel message will log in file "message"

does anyone can give me a suggestion? 
maybe I want to patch kernel or other?
or linux kernel's IDE CDROM DMA mode have problem, still developing ?


kernel version ,
=======================
# uname -a
Linux mdk82 2.4.18-6mdk #1 Fri Mar 15 02:59:08 CET 2002 i686 unknown
=======================

kernel message about IDE
=======================
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
CMD649: IDE controller on PCI bus 00 dev 40
PCI: Found IRQ 11 for device 00:08.0
PCI: Sharing IRQ 11 with 01:00.0
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdf: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xb400-0xb407,0xb002 on irq 11
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(33)
hdf: ATAPI 40X DVD-ROM drive, 128kB Cache
=============================
P.S My CDROM is ASUS 8x DVD-ROM


strange message
=============================
hdf: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdf: packet command error: error=0x04
hdf: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdf: request sense failure: error=0x04
hdf: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdf: packet command error: error=0x04
hdf: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdf: request sense failure: error=0x04
hdf: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdf: packet command error: error=0x04
hdf: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdf: request sense failure: error=0x04
hdf: task_in_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: task_in_intr: error=0x04
hdf: task_in_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: task_in_intr: error=0x04
hdf: task_in_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: task_in_intr: error=0x04
hdf: task_in_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: task_in_intr: error=0x04
hdf: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdf: packet command error: error=0x04
hdf: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdf: request sense failure: error=0x04
hdf: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdf: packet command error: error=0x04
hdf: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdf: request sense failure: error=0x04
=============================

--
Richard Liu
