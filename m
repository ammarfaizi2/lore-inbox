Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319091AbSH2FWi>; Thu, 29 Aug 2002 01:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319092AbSH2FWi>; Thu, 29 Aug 2002 01:22:38 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:26692 "HELO
	laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S319091AbSH2FWi>; Thu, 29 Aug 2002 01:22:38 -0400
From: brian@worldcontrol.com
Date: Wed, 28 Aug 2002 22:26:37 -0700
To: linux-kernel@vger.kernel.org
Subject: My /dev/hda became /dev/hde after upgrading
Message-ID: <20020829052637.GA2520@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running 2.4.19-pre7-ac2 my system was happily buzzing away.

I upgraded to 2.4.19 and my /dev/hda became /dev/hde which caused
various boot problems, which I worked around.

It seems clear that upon booting 2.4.19, the newer kernel recognized
the "other" IDE controller on the MB, which 2.4.19-pre7-ac2 had not.

The manual that came with the MB said to use the IDE slots marked
IDE0 / IDE1 if I wasn't going to use RAID.

If I wanted to use RAID use the slots marked RAID0/RAID1.

I was just wondering how linux decides which controller is first
(hda-hdd) and which is second (hde-hdh).

Here is what I see from dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 70
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=bi
osirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:DMA, hdh:pio
hde: ST380021A, ATA DISK drive
hdg: RW-241040, ATAPI CD/DVD-ROM drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0x170-0x177,0x376 on irq 15
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
Partition check:
 hde: hde1 hde2 < hde5 hde6 >

-- 
Brian Litzinger
