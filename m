Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293167AbSBWSOe>; Sat, 23 Feb 2002 13:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293168AbSBWSOX>; Sat, 23 Feb 2002 13:14:23 -0500
Received: from pD957B347.dip.t-dialin.net ([217.87.179.71]:2060 "EHLO
	enigma.deepspace.net") by vger.kernel.org with ESMTP
	id <S293167AbSBWSOL>; Sat, 23 Feb 2002 13:14:11 -0500
Message-Id: <200202231812.TAA04425@enigma.deepspace.net>
Content-Type: text/plain; charset=US-ASCII
From: Wolly <wwolly@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA hard lock at boot time (KT266A chpiset)
Date: Sat, 23 Feb 2002 19:12:18 +0100
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

I'm using an elitegroup mobo (K7VTA3 / KT266A chipset; Athlon XP) 
and I'm experiencing a hard lock at boot time when configuring the 
kernel using `via82cxx support'. (No ctrl-alt-del, no sysrq, only hw reset)

[Without that I can boot without problems but I don't have DMA and thus 
disk throughput is at less than 3 Mb/sec.]

The hard lock seems to happen during the first hd access and the hd light 
stays on when the system is crashing. 

Is that 
- a known issue (hopefully not), 
- a Linux kernel problem or
- do I have to blame the board (this is not completely unlikely as 
  I also have problems with two network cards which work without 
  problems in other boards and same kernel)

Is the KT266A chipset's DMA supported at all? (The vt82cxx driver 
source code lists several chipsets including KT266 but not KT266A.)

--------<Boot screen>--------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 0:11.1. Please try using 
pci=biosirq
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdb:pio
hda: IBM-DTLA-xyz, ATA DISK drive
hdc: CD-xyz, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: xx sectors (30000 MB) [...], UDMA(100)
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda:_
---------------------
(hardlock occurs; cursor at `_')

Regards, 
Wolly
