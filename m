Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129256AbQKTWlW>; Mon, 20 Nov 2000 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKTWlM>; Mon, 20 Nov 2000 17:41:12 -0500
Received: from brooks.civeng.adelaide.edu.au ([129.127.78.254]:45497 "EHLO
	brooks.civeng.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S129256AbQKTWlJ>; Mon, 20 Nov 2000 17:41:09 -0500
From: "Stephen Carr" <sgcarr@civeng.adelaide.edu.au>
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Nov 2000 08:41:49 +1030
Subject: Dma problems - Aopen Ax34pro VIA chipset seagate drive
Reply-to: sgcarr@civeng.adelaide.edu.au
Message-ID: <3A1A354D.3927.5A09E7EB@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just subscribed to this list - so possibly email me directly 
sgcarr@civeng.adelaide.edu.au

Status: kernel 2.4.0-test10 (no patches added)
Problem: getting dma problems - having to run system with no dma 
for disc access - seems to be a bus mastering problem.
Hardware: Aopen AX34Pro mother board, Via chipset with via686a, 
Seagate Baracuda ATA66 20GB disc - Latest Bios for motherboard
Sony CDU4811 cdrom

I am willing to test patches.

Snips of logs etc follow

Config
-
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#

Dmesg - warning due to ide0=ata66 in append line of lilo

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0x6400-0x6407, BIOS settings: hda:DMA, 
hdb:pio
    ide1: BM-DMA at 0x6408-0x640f, BIOS settings: hdc:DMA, 
hdd:pio
hda: ST320420A, ATA DISK drive
hdc: SONY CDU4811, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 15
ide1 at 0x170-0x177,0x376 on irq 14
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, 
CHS=2480/255/63, UDMA(66)
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.11
Partition check:
 hda:hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success
 hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >

------
VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete 
DataRequest }
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x51 { DriveReady SeekComplete Error }
hdc: irq timeout: error=0x04
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete 
DataRequest }
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt
ATAPI device hdc:
  Error: No sense data -- (Sense key=0x00)
  No additional sense information -- (asc=0x00, ascq=0x00)
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt
ISOFS: changing to secondary root
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete 
DataRequest }
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x51 { DriveReady SeekComplete Error }
hdc: irq timeout: error=0x04
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete 
DataRequest }
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt
ATAPI device hdc:
  Error: No sense data -- (Sense key=0x00)
  No additional sense information -- (asc=0x00, ascq=0x00)

Performance

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.69 seconds =185.51 
MB/sec
 Timing buffered disk reads:  64 MB in 12.01 seconds =  5.33 
MB/sec

Thanks in advance
Stephen Carr


Stephen Carr
Computing Officer
Department of Civil and Environmental Engineering
University of Adelaide
Adelaide, South Australia,
Australia 5005
Phone +618 8303-4313
Fax   +618 8303-4359
Email sgcarr@civeng.adelaide.edu.au
-----------------------------------------------------------
This email message is intended only for the addressee(s)
and contains information which may be confidential and/or
copyright.  If you are not the intended recipient please
do not read, save, forward, disclose, or copy the contents
of this email. If this email has been sent to you in error,
please notify the sender by reply email and delete this
email and any copies or links to this email completely and
immediately from your system.  No representation is made
that this email is free of viruses.  Virus scanning is
recommended and is the responsibility of the recipient.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
