Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRIAA5r>; Fri, 31 Aug 2001 20:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRIAA5h>; Fri, 31 Aug 2001 20:57:37 -0400
Received: from avery-161.caltech.edu ([131.215.103.161]:35278 "EHLO
	velius.chaos2.org") by vger.kernel.org with ESMTP
	id <S269967AbRIAA51>; Fri, 31 Aug 2001 20:57:27 -0400
Date: Fri, 31 Aug 2001 17:57:44 -0700 (PDT)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: <linux-kernel@vger.kernel.org>
Subject: PDC20262 seems to require edge-triggered interrupts
Message-ID: <Pine.LNX.4.32.0108311741540.393-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a box with a new PDC20262 ide controller in it and it locks up
during boot unless I set the pci irqs to be edge activated.  This is with
kernel versions 2.4.9 and 2.4.10-pre2.  Does anybody happen to know
whether this is a kernel issue or a hardware issue?  (Perhaps a hardware
issue with the ide and the older bios (Award v4.51PG) interacting?)  The
Promise controller has bios version 1.14 (Build 0728).

Thanks,
-Jacob

kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
kernel: VP_IDE: chipset revision 6
kernel: VP_IDE: not 100%% native mode: will probe irqs later
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
kernel: PDC20262: IDE controller on PCI bus 00 dev 58
kernel: PDC20262: chipset revision 1
kernel: PDC20262: not 100%% native mode: will probe irqs later
kernel: PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
kernel:     ide2: BM-DMA at 0x7c00-0x7c07, BIOS settings: hde:pio, hdf:pio
kernel:     ide3: BM-DMA at 0x7c08-0x7c0f, BIOS settings: hdg:pio, hdh:pio
kernel: hda: WDC AC31600H, ATA DISK drive
kernel: hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
kernel: hde: QUANTUM FIREBALLP LM30, ATA DISK drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: ide2 at 0x6c00-0x6c07,0x7002 on irq 10
kernel: hda: 3173184 sectors (1625 MB) w/128KiB Cache, CHS=787/64/63, DMA
  ** the box locks hard here if using level-activated irq for pci **
kernel: hde: 58633344 sectors (30020 MB) w/1900KiB Cache, CHS=58168/16/63, UDMA(66)
kernel: hdc: ATAPI 24X CD-ROM drive, 120kB Cache, DMA

-- 

No.  That's where you're wrong.  This is reality.  It is a self-
sustaining ecosociosystem powered by inter-universe warp generators.

 - Fred Fine, ``The Big U'' by Neal Stephenson

