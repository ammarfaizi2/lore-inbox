Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135346AbRDRVGX>; Wed, 18 Apr 2001 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135345AbRDRVGF>; Wed, 18 Apr 2001 17:06:05 -0400
Received: from dns.bankinter.es ([195.235.30.34]:5620 "EHLO smtp.bankinter.es")
	by vger.kernel.org with ESMTP id <S135344AbRDRVF6> convert rfc822-to-8bit;
	Wed, 18 Apr 2001 17:05:58 -0400
Date: Wed, 18 Apr 2001 22:08:07 +0200 (CEST)
From: Simon Neira <sneira@inorbit.com>
To: linux-kernel@vger.kernel.org
Subject: System hangs reading CDROM/IDE in 2.4.x with VIA MVP3 chipset.
Message-ID: <Pine.LNX.4.10.10104182203590.472-100000@ijssel.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since I intalled 2.4.x kernel my system hangs randomly when reading my
IDE-ATAPI 40x Pioner CDROM drive. (I tryed with 2.4.1 and 2.4.3 kernels)

	Just making a 
		cat /dev/hdc > /dev/null 
	or making a ls -lR will hang totally my computer in a random time
	(sometimes a few seconds, sometimes a few minutes)

 It doesn't hangs with a 2.2.x kernel or with a windows OS installed in the
 same computer.

 In /dev/hdd I have Mitshubishi CD-rewriter (4x4x20) using SCSI emulation
 that doesn't hangs when doing the same things.

-2.4.3 Kernel (using Debian woody)
-I use an Aopen AX59Pro motherboard with a VIA MVP3 AGP chipset.
-Enabled in Kernel:
     *VIA82CXXX chipset support
     *Generic PCI IDE chipset support
     *Sharing PCI IDE interrupts support
     *Use PCI DMA by default when available
     *SCSI emulation support
-K6-II 350 Mhz processor with 128Mb RAM.
-Vesa framebuffer installed with a RivaTNT graphcard
-52MB disk swap space.

 
That's the booting log
==========
block: queued sectors max/low 83936kB/27978kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x6400-0x6407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x6408-0x640f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SV0432A, ATA DISK drive
hdb: ST32531A, ATA DISK drive
hdc: Pioneer CD-ROM ATAPI Model DR-944 0107, ATAPI CD/DVD-ROM drive
hdd: MITSBICDRW4420a, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8421840 sectors (4312 MB) w/482KiB Cache, CHS=524/255/63, UDMA(33)
hdb: 4996476 sectors (2558 MB), CHS=619/128/63, DMA
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-cd: passing drive hdd to ide-scsi emulation.
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
 hdb: hdb1 hdb2 hdb3 < hdb5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
============

  Please Cc me.
  Thanks!


Greets.
------------------------------------------------------------------------
Simón Neira Dueñas    | A Coruña University Linux User Group (CLUG/GPUL)
 sneira@inorbit.com   | Room 0.05 - Fac. Informática - A Coruña - Spain
 sneira@ceu.fi.udc.es |                 www.gpul.org
------------------------------------------------------------------------

