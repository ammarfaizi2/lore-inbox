Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRDGS4W>; Sat, 7 Apr 2001 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbRDGS4N>; Sat, 7 Apr 2001 14:56:13 -0400
Received: from light.kappa.ro ([194.102.249.27]:45185 "EHLO light.kappa.ro")
	by vger.kernel.org with ESMTP id <S129624AbRDGSz6>;
	Sat, 7 Apr 2001 14:55:58 -0400
Message-ID: <004a01c0bfe8$30b637e0$e8c6e7c1@scream>
From: "Alexandru Barloiu Nicolae" <axl@light.kappa.ro>
To: <linux-kernel@vger.kernel.org>
Subject: Compaq proliant ML-350 - IDE & SCSI
Date: Sat, 7 Apr 2001 21:55:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to use the DMA on the ide drives. After the reboot Dma is
enabled but if I don't disable it with hdparm the system freezes at heavy
work (copy something from a drive to the other). The SCSI works ok. Without
the DMA the system barely moves

root@light:~# hdparm  -t -T /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  4.83 seconds = 26.50 MB/sec
 Timing buffered disk reads:  64 MB in 81.21 seconds =806.99 kB/sec

Any ideas what's wrong?

dmesg:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD200EB-00BHF0, ATA DISK drive
hdb: Compaq CRD-8402B, ATAPI CD/DVD-ROM drive
hdc: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdd: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2586/240/63, UDMA(33)
hdc: 80315072 sectors (41121 MB) w/1902KiB Cache, CHS=79677/16/63, UDMA(33)
hdd: 80315072 sectors (41121 MB) w/1902KiB Cache, CHS=79677/16/63, UDMA(33)
hdb: ATAPI 40X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 1, device 4, function 0
sym53c8xx: 53c896 detected
PCI: Enabling device 01:04.1 (0154 -> 0157)
sym53c8xx: at PCI bus 1, device 4, function 1
sym53c8xx: 53c896 detected
sym53c896-0: rev 0x7 on pci bus 1 device 4 function 0 irq 16
sym53c896-0: ID 7, Fast-40, Parity Checking
sym53c896-0: handling phase mismatch from SCRIPTS.
sym53c896-1: rev 0x7 on pci bus 1 device 4 function 1 irq 16
sym53c896-1: ID 7, Fast-40, Parity Checking
sym53c896-1: handling phase mismatch from SCRIPTS.
scsi0 : sym53c8xx-1.7.3a-20010304
scsi1 : sym53c8xx-1.7.3a-20010304
  Vendor: COMPAQ    Model: BD0186349B        Rev: 3B12
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: BD0186349B        Rev: 3B12
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: BD0186349B        Rev: 3B12
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: BD0186349B        Rev: 3B12
  Type:   Direct-Access                      ANSI SCSI revision: 02
ncr53c8xx: at PCI bus 1, device 4, function 0
ncr53c8xx: IO region 0x2000[0..127] is in use
ncr53c8xx: at PCI bus 1, device 4, function 1
ncr53c8xx: IO region 0x2400[0..127] is in use
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
Detected scsi disk sdd at scsi0, channel 0, id 3, lun 0

.config:
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
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_AEC62XX_TUNING=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_WDC_ALI15X3=y
CONFIG_BLK_DEV_AMD7409=y
CONFIG_AMD7409_OVERRIDE=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_HPT34X_AUTODMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_OSB4=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDE_CHIPSETS=y
CONFIG_BLK_DEV_4DRIVES=y
CONFIG_BLK_DEV_ALI14XX=y
CONFIG_BLK_DEV_DTC2278=y
CONFIG_BLK_DEV_HT6560B=y
CONFIG_BLK_DEV_PDC4030=y
CONFIG_BLK_DEV_QD6580=y
CONFIG_BLK_DEV_UMC8672=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set


Thanks,
axl

