Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751917AbWAOMfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbWAOMfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWAOMfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:35:43 -0500
Received: from pb142.tychy.sdi.tpnet.pl ([217.96.251.142]:1682 "EHLO daper.net")
	by vger.kernel.org with ESMTP id S1751917AbWAOMfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:35:43 -0500
Date: Sun, 15 Jan 2006 13:35:46 +0100
From: Damian Pietras <daper@daper.net>
To: linux-kernel@vger.kernel.org
Subject: Problems with eject and pktcdvd
Message-ID: <20060115123546.GA21609@daper.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I bought a NEC ND-4551A CD/DVD writer. It works OK with one
exception. When I have a packet device associated with the drive, there
are problems with ejecting discs.

Here is an example:

1. Insert a CD-R/DVD/CD-RW (whatever)
2. mount /media/cdrom0
3. umount /media/cdrom0

Now the eject button doesn't work, when I issue the eject command I get:

hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: DMA disabled
hda: ATAPI reset complete

After few seconds eject ends with no result. Second eject command works.

There are no problems without the packet device association (turned
off/on with pktsetup using /etc/init.d/udftools).

My system if Ubuntu 5.10
The kernel is:
Linux amd 2.6.15-mm3 #1 PREEMPT Sun Jan 15 12:31:14 CET 2006 i686
GNU/Linux
But it works the same way with 2.6.15.

Part of my dmesg related to IDE:

VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 10 (level, low)
 -> IRQ 10
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 10
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-4551A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Probing IDE interface ide1...
Probing IDE interface ide1...

-- 
Damian Pietras
