Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTESCu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 22:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTESCu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 22:50:57 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:57104 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262318AbTESCux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 22:50:53 -0400
Message-ID: <3EC84974.4020507@yahoo.com>
Date: Sun, 18 May 2003 20:03:16 -0700
From: Lars <lhofhansl@yahoo.com>
Organization: What? Organized??
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: Jeffrey Baker <jwbaker@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
References: <20030517035612.GA543@noodles> <20030518075910.GX3478@louise.pinerecords.com>
In-Reply-To: <20030518075910.GX3478@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:
>>[jwbaker@acm.org]
>>
>>I have the same problem on VIA chipset.  IDE DMA is disabled in
>>2.4.21-rc2 but works fine otherwise:
> 
> 
> Please post the relevant extract of your .config and dmesg output.
> 

Here's all the information:

dmesg:
------
...
PCI: PCI BIOS revision 2.10 entry at 0xfc06e, last bus=8
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
...
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: HITACHI_DK23CA-30, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
hdc: TOSHIBA CD-RW/DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63
Partition check:
hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >

.config:
--------
...
#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y
...
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set
...

lspci:
------
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801BA PCI (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (ICH2) (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 03)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 
0112 (revb2)
02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i 
PCI Audio Accelerator (rev 10)
02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11)
02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027
08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)08:08.0 Communication controller: Lucent Microelectronics 
WinModem 56k (rev 01)

