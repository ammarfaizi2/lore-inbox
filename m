Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbTCWPUD>; Sun, 23 Mar 2003 10:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbTCWPUD>; Sun, 23 Mar 2003 10:20:03 -0500
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:36753 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263081AbTCWPUB>; Sun, 23 Mar 2003 10:20:01 -0500
Date: Sun, 23 Mar 2003 10:37:34 -0500
To: linux-kernel@vger.kernel.org
Subject: ide kernel panic: 2.5.64-ac3 2.5.65-ac1 2.5.65-mm4
Message-ID: <20030323153724.GA26178@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AMD K6/2 with VIA chipset has this panic at boot:

Kernel panic: ide: default attach failed

Panic on 2.5.64-ac3, 2.5.65-ac[13], 2.5.65-mm4, 2.5.65-bk4.

No panic on 2.5.61-ac1, 2.5.65-mm3, 2.5.65, 2.4.21-pre5, 2.4.21-pre5-ac3.

No modules.

egrep '^C.*IDE|^C.*VIA' /usr/src/linux-2.5.65-ac1/.config
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y


Boot message on 2.5.65-ac1:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 51536U3, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 52049U4, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=29777/16/63, UDMA(33)
 hda: [PTBL] [1868/255/63] hda1 hda2 hda3
hdc: host protected area => 1
hdc: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(33)
 hdc: hdc1 hdc2 hdc3
ide-disk: hdc: Failed to register the driver with ide.c
ide-default: hdc: Failed to register the driver with ide.c
Kernel panic: ide: default attach failed

lspci -vvv for IDE interface

IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 64
Region 4: I/O ports at e000 [size=16]

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev 15)

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

