Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263057AbTCWNdY>; Sun, 23 Mar 2003 08:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbTCWNdY>; Sun, 23 Mar 2003 08:33:24 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.27]:52696 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263057AbTCWNdW>; Sun, 23 Mar 2003 08:33:22 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: alan@redhat.com
Subject: 2.5 BK boot hang after ide
Date: Sun, 23 Mar 2003 14:44:21 +0100
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303231444.22191.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copied down by hand:

...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
ACPI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
VP_IDE: Chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt 8235 (rev 00) IDE UDMA 133 controller on pci00:11.1
	ide0: BM_DMA at 0xfc00-0xfc07, BIOS settings: hda: DMA, hdb: DMA
	ide1: BM_DMA at 0xfc08-0xfc0f, BIOS settings: hdc: DMA, hdd: DMA
hda: ST320423A, ATA DISK drive
hdb: Maxtor 6E030L0, ATA DISK drive
id0 at 0x1f0-0x1f7, 0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-MI402, ATAPI CD/DVD-ROM drive
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177, 0x376 on irq 15
hda: host protected area => 1
hda : 40011300 sectors (20486 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(66)
	hda: hda1 hda2 hda3
hdb: host protected area => 1
hdb : 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=59582/16/63, UDMA(133)
	hdb: hdb1
(hangs)

At this point in 2.4 the USB subsystem starts up, so it could be a problem there
of course.

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:07.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:0a.0 USB Controller: VIA Technologies, Inc. USB (rev 04)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]

All the best,

Duncan.
