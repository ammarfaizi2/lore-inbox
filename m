Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBESii>; Mon, 5 Feb 2001 13:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRBESi2>; Mon, 5 Feb 2001 13:38:28 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:44292 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S129047AbRBESiW>; Mon, 5 Feb 2001 13:38:22 -0500
From: Norbert Preining <preining@logic.at>
Date: Mon, 5 Feb 2001 19:38:14 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.1: ide probs, irq timeout, disk hangs
Message-ID: <20010205193814.A15215@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have regularly the following problems with 2.4.1:

kernel: hda: irq timeout: status=0x80 { Busy }
kernel: hdb: DMA disabled
kernel: ide0: reset timed-out, status=0x80
kernel: hda: status timeout: status=0x80 { Busy }
kernel: hda: drive not ready for command
kernel: ide0: reset timed-out, status=0x80
kernel: VFS: Disk change detected on device ide0(3,64)
kernel: hda: status timeout: status=0x80 { Busy }
kernel: end_request: I/O error, dev 03:01 (hda), sector 52572
kernel: hda: drive not ready for command
kernel: hda: status timeout: status=0x80 { Busy }
kernel: hda: drive not ready for command
kernel: ide0: reset timed-out, status=0x80
kernel: hdb: DMA disabled
kernel: hda: status timeout: status=0x80 { Busy }
kernel: hda: drive not ready for command

And the disk is hanging indefinitely, making noises like:
	rrrrrt-click-rrrrrrt-click-rrrrrrt-click-.....
Even turning off power doesn't help always, at least I have
to turn of for some time.

I have linux on hde (Promise controller), hda is windows, hdb
is cd, hdc is another small disk, hdd is cdwriter.
The MoBO has chipset ALi 15x3, (Asus P5A-B). I didn't have
this problems up to (at least) 2.4.0-test10.

>From /var/log/boot.msg:
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>PDC20267: IDE controller on PCI bus 00 dev 50
<4>PCI: Found IRQ 12 for device 00:0a.0
<4>PDC20267: chipset revision 2
<4>PDC20267: not 100%% native mode: will probe irqs later
<4>PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
<4>    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
<4>ALI15X3: IDE controller on PCI bus 00 dev 78
<4>PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
<4>ALI15X3: chipset revision 193
<4>ALI15X3: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: IBM-DTTA-350840, ATA DISK drive
<4>hdb: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
<4>hdc: IBM-DCAA-33610, ATA DISK drive
<4>hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
<4>hde: Maxtor 52049H4, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0xd000-0xd007,0xb802 on irq 12
<6>hda: 16514064 sectors (8455 MB) w/467KiB Cache, CHS=1027/255/63, UDMA(33)
<6>hdc: 7056000 sectors (3613 MB) w/96KiB Cache, CHS=7000/16/63, DMA
<6>hde: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(100)
<4>hdb: ATAPI 40X DVD-ROM drive, 128kB Cache, (U)DMA
<6>Uniform CD-ROM driver Revision: 3.12

PLease send me a Cc: since I am not subscribed! Tell me if I can try/test
something to check out this problem.

I have tried disabling dma (hdparm -d0 /dev/hda) but it doesn't help.

Best wishes


Norbert
-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
