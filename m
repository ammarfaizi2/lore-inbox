Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313907AbSDZMBW>; Fri, 26 Apr 2002 08:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSDZMBV>; Fri, 26 Apr 2002 08:01:21 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:22033 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313907AbSDZMBU>; Fri, 26 Apr 2002 08:01:20 -0400
Date: Fri, 26 Apr 2002 14:01:07 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: PDC20265 / 2.5.10 / Alpha (Miata) - unexpected interrupt flood
Message-ID: <20020426120107.GA9344@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running linux-2.5.10 on my Miata Alpha system, and I get a *lot* of
messages like this:

ide: unexpected interrupt 1 44

The limiting in drivers/ide/ide.c works fine, I never get more than 1 a
second or something like that. Still, 1 per second is a lot.

dmesg (system parameters/ide messages):

Linux version 2.5.10 (root@alpha) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Fri Apr 26 09:54:57 CEST 2002
Booting on Miata using machine vector Miata from SRM
Command line: ro root=/dev/sda1 video=tdfx:1600x1200-16@85,nohwcursor
memcluster 0, usage 1, start        0, end      236
memcluster 1, usage 0, start      236, end   196607
memcluster 2, usage 1, start   196607, end   196608
freeing pages 236:384
freeing pages 839:196607
reserving pages 839:842
pci: cia revision 1 (pyxis)
On node 0 totalpages: 196607
zone(0): 196607 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/sda1 video=tdfx:1600x1200-16@85,nohwcursor
HWRPB cycle frequency bogus.  Estimated 499787208 Hz
Calibrating delay loop... 990.32 BogoMIPS
Memory: 1553416k/1572856k available (2280k kernel code, 17552k reserved, 676k data, 376k init)
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
pci: tbia workaround enabled
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
CMD Technology Inc PCI0646: IDE controller on PCI slot 00:04.0
CMD Technology Inc PCI0646: chipset revision 1
CMD Technology Inc PCI0646: not 100% native mode: will probe irqs later
CMD Technology Inc PCI0646: chipset revision 0x01, MultiWord DMA Limited, IRQ workaround enabled
CMD Technology Inc PCI0646: simplex device:  DMA disabled
ide0: CMD Technology Inc PCI0646 Bus-Master DMA was disabled by BIOS
CMD Technology Inc PCI0646: simplex device:  DMA disabled
ide1: CMD Technology Inc PCI0646 Bus-Master DMA was disabled by BIOS
Promise Technology, Inc. 20265: IDE controller on PCI slot 01:0a.0
Promise Technology, Inc. 20265: chipset revision 2
Promise Technology, Inc. 20265: not 100% native mode: will probe irqs later
Promise Technology, Inc. 20265: ROM enabled at 0x20020000
Promise Technology, Inc. 20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
Promise Technology, Inc. 20265: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:DMA, hdh:pio
hdg: IBM-DTLA-307045, ATA DISK drive
ide3 at 0x9048-0x904f,0x9056 on irq 44
hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
Partition check:
 hdg: [PTBL] [5606/255/63] hdg1 hdg2

Has anything changed? I ran 2.4.x since 2.4.10 or so on this machine
with the same hardware and never saw this message.

Thanks,
Jurriaan
-- 
Linux hackers are funny people: They count the time in patchlevels.
	Gerd Knorr
GNU/Linux 2.5.10 on Debian/Alpha 988 bogomips load:0.04 0.14 0.08
