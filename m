Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288655AbSAXRbp>; Thu, 24 Jan 2002 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288660AbSAXRbf>; Thu, 24 Jan 2002 12:31:35 -0500
Received: from OL10K-24.207.148.94.charter-stl.com ([24.207.148.94]:2688 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S288655AbSAXRbb>;
	Thu, 24 Jan 2002 12:31:31 -0500
Message-Id: <200201241721.g0OHLvc00955@linux.local>
Content-Type: text/plain; charset=US-ASCII
From: Its Squash <squash2@dropnet.net>
Reply-To: squash2@dropnet.net
To: linux-kernel@vger.kernel.org
Subject: 2.5.3-pre4 ide problems
Date: Thu, 24 Jan 2002 11:21:56 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a Compaq Evo n600c laptop, which has Intel ICH3 IDE onboard as well as 
CMD646 IDE on my docking station.  I have been runing 2.5.1 just fine for a 
while. Today I tried 2.5.3-pre4 and I bomb on boot.

The IDE part of dmesg from 2.5.1 says:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller on PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: chipset revision 1
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x5060-0x5067, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x5068-0x506f, BIOS settings: hdc:DMA, hdd:pio
CMD646: IDE controller on PCI slot 05:07.0
CMD646: chipset revision 7
CMD646: 100% native mode on irq 11
    ide2: BM-DMA at 0x2040-0x2047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x2048-0x204f, BIOS settings: hdg:pio, hdh:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
hdc: Compaq DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

on 2.5.3-pre4, undocked, it says:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller on PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: (ide_setup_pci_device:) Could not enable device.
hda: TOSHIBA MK2018GAP, ATA DISK drive
hdc: Compaq DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB), CHS=2584/240/63
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache

on 2.5.3-pre4, docked, it says:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller on PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: (ide_setup_pci_device:) Could not enable device.
CMD646: IDE controller on PCI slot 05:07.0
CMD646: chipset revision 7
CMD646: 100% native mode on irq 11
    ide0: BM-DMA at 0x2040-0x2047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2048-0x204f, BIOS settings: hdc:pio, hdd:pio




Josh
