Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbTFLJX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTFLJX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:23:26 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:26889 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264424AbTFLJXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:23:24 -0400
Date: Thu, 12 Jun 2003 11:36:38 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Drives on Promise PDC20265 card not recognized (2.4.21-rc7, Compaq Deskpro 2000)
Message-ID: <20030612093638.GA23155@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange problem with my Promise PDC20265 udma-controller in a
Compaq Deskpro 2000 system.

Whatever drives I put on this card, linux doesn't see them.
Adding 'hde=59556,16,63' to lilo.conf only creates a message about a
non-ide drive in dmesg-output. The card itself is probed alright,
io-ports and interrupts seem to be OK.

I am convinced this stupid Compaq BIOS somehow works against me.
Unfortunately, I can't change that.

Has anybody seen something like this before, and found a solution?

Jun 12 11:09:01 blueberry kernel: Linux version 2.4.21-rc7 (root@blueberry) (gcc version 3.3 (Debian)) #5 Thu Jun 12 09:30:19 CEST 20
03
Jun 12 11:09:01 blueberry kernel: Kernel command line: auto BOOT_IMAGE=Linux-2.4.21rc7 ro root=301 video=matrox:vesa:0x11A,fv:85 hdg=
59556,16,63
Jun 12 11:09:01 blueberry kernel: ide_setup: hdg=59556,16,63
Jun 12 11:09:01 blueberry kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Jun 12 11:09:01 blueberry kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 12 11:09:01 blueberry kernel: PDC20265: IDE controller at PCI slot 00:0d.0
Jun 12 11:09:01 blueberry kernel: PCI: Found IRQ 11 for device 00:0d.0
Jun 12 11:09:01 blueberry kernel: PCI: Sharing IRQ 11 with 00:14.2
Jun 12 11:09:01 blueberry kernel: PDC20265: chipset revision 2
Jun 12 11:09:01 blueberry kernel: PDC20265: not 100%% native mode: will probe irqs later
Jun 12 11:09:01 blueberry kernel: PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
Jun 12 11:09:01 blueberry kernel: PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
Jun 12 11:09:01 blueberry kernel:     ide2: BM-DMA at 0x1040-0x1047, BIOS settings: hde:pio, hdf:pio
Jun 12 11:09:01 blueberry kernel:     ide3: BM-DMA at 0x1048-0x104f, BIOS settings: hdg:pio, hdh:pio
Jun 12 11:09:01 blueberry kernel: VP_IDE: IDE controller at PCI slot 00:14.1
Jun 12 11:09:01 blueberry kernel: VP_IDE: chipset revision 6
Jun 12 11:09:01 blueberry kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jun 12 11:09:01 blueberry kernel: VP_IDE: VIA vt82c586b (rev 31) IDE UDMA33 controller on pci00:14.1
Jun 12 11:09:01 blueberry kernel:     ide0: BM-DMA at 0x1030-0x1037, BIOS settings: hda:DMA, hdb:pio
Jun 12 11:09:01 blueberry kernel:     ide1: BM-DMA at 0x1038-0x103f, BIOS settings: hdc:pio, hdd:pio
Jun 12 11:09:01 blueberry kernel: hda: Maxtor 83240D4, ATA DISK drive
Jun 12 11:09:01 blueberry kernel: blk: queue c0339020, I/O limit 4095Mb (mask 0xffffffff)
Jun 12 11:09:01 blueberry kernel: hdg: non-IDE drive, CHS=59556/16/63
Jun 12 11:09:01 blueberry kernel: blk: queue c0339d1c, I/O limit 4095Mb (mask 0xffffffff)
Jun 12 11:09:01 blueberry kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 12 11:09:01 blueberry kernel: ide3 at 0x1408-0x140f,0x1416 on irq 11
Jun 12 11:09:01 blueberry kernel: hda: attached ide-disk driver.
Jun 12 11:09:01 blueberry kernel: hda: host protected area => 1
Jun 12 11:09:01 blueberry kernel: hda: 6327720 sectors (3240 MB) w/256KiB Cache, CHS=837/120/63, UDMA(33)
Jun 12 11:09:01 blueberry kernel: hdg: attached ide-disk driver.
Jun 12 11:09:01 blueberry kernel: Partition check:
Jun 12 11:09:01 blueberry kernel:  hda: hda1 hda2 hda3
Jun 12 11:09:01 blueberry kernel: NET4: Linux TCP/IP 1.0 for NET4.0

even something as simple as hdparm -i /dev/hdg fails:

~$ sudo hdparm -i /dev/hdg

/dev/hdg:
 HDIO_GET_IDENTITY failed: No message of desired type
~$

Any hints?

Thanks,
Jurriaan
-- 
Asking female officers for their clothing could lead to misunderstanding.
	Tuvok - Startrek Voyager
Debian (Unstable) GNU/Linux 2.5.70-bk13 4112 bogomips load av: 0.16 0.21 0.31
