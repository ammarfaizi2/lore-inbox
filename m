Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFBJP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFBJP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVFBJP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:15:27 -0400
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:17030 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S261282AbVFBJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:15:16 -0400
Message-ID: <429ECE20.1030403@ribosome.natur.cuni.cz>
Date: Thu, 02 Jun 2005 11:15:12 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en, en-us, cs
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc5-git6 mis-counted ide interfaces
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I get the following when I boot my PIIX computer (Asus P4C800E-Deluxe):


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
----------------------^^^^ ide0 I believe
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: ATAPI 16X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.11 loaded.
ata_piix version 1.03

I believe these two lines from .config are related:
CONFIG_BLK_DEV_PIIX=y
CONFIG_SCSI_ATA_PIIX=y


# lspci
0000:00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corporation 82875P/E7210 Processor to PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
0000:02:01.0 Ethernet controller: Intel Corporation 82547EI Gigabit Ethernet Controller (LOM)
0000:03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
#

Please let me know if you need more information. and cc: me in replies. ;)
Thanks!
Martin
