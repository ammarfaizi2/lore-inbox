Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbUCGW3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 17:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbUCGW3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 17:29:44 -0500
Received: from host179-214.pool80181.interbusiness.it ([80.181.214.179]:2432
	"EHLO numb.darktech.org") by vger.kernel.org with ESMTP
	id S262342AbUCGW3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 17:29:38 -0500
Date: Sun, 7 Mar 2004 23:31:53 +0100 (CET)
From: Carlo Orecchia <carlo@numb.darktech.org>
To: linux-kernel@vger.kernel.org
Subject: KERNEL 2.6.3 and MAXTOR 160 GB
Message-ID: <Pine.LNX.4.44.0403072328560.2768-100000@numb.darktech.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

I'm running redhat 9 on an XP 1800 and a ASUS A7A266. I recently buy a new 
HD a maxtor Diamond Plus 160 with 8 mega cache. The fact is that the 
kernel that comes 
with REDHAT (2.4.20-8) shows the entire size of the disk (163.7 gb) but 
the kernel 2.6.1 or 2.6.3 does not. It only shows 137 gb. I'm getting 
crazy trying to understand why this is happening! Please let 
me know if theres a patch to fix this. I really  found amazing the 2.6 
kernel and i don't want to come back to use the 2.4!
What can i do? 


Regards

Carlo Orecchia


this is the message from boot:
Thanks for any reply!

ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:04.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:04.0 - using IRQ 
255
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: no response (status = 0xa1), resetting drive
hdc: no response (status = 0xa1)
hdd: no response (status = 0xa1), resetting drive
hdd: no response (status = 0xa1)
hdc: no response (status = 0xa1), resetting drive
hdc: no response (status = 0xa1)
hdd: no response (status = 0xa1), resetting drive
hdd: no response (status = 0xa1)
hda: max request size: 128KiB
hda: cannot use LBA48 - full capacity 320173056 sectors (163928 MB)
hda: 268435456 sectors (137438 MB) w/7936KiB Cache, CHS=16709/255/63, 
UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
ide-floppy driver 0.99.newide
Console: switching to colour frame buffer device 100x37
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1


Here is the .config of kernel (ATA section)

# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
# CONFIG_BLK_DEV_CS5520 is not set
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_SC1200=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set


