Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSHRQOf>; Sun, 18 Aug 2002 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHRQOf>; Sun, 18 Aug 2002 12:14:35 -0400
Received: from ares.sdinet.de ([193.103.161.26]:50183 "HELO ares.sdinet.de")
	by vger.kernel.org with SMTP id <S315276AbSHRQOe>;
	Sun, 18 Aug 2002 12:14:34 -0400
Date: Sun, 18 Aug 2002 18:18:33 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.4.20-pre2-ac3 IDE better than 2.4.19-pre10
Message-ID: <Pine.LNX.4.44.0208181802130.11362-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

My machine: Toshiba Satellite Pro 4600

With my former kernel 2.4.19-pre10 it would hang hard every time after
some heavier downloads over the eepro100 to the local ide-harddisk,
without anything in the logfiles.

Now with 2.4.20-pre2-ac3 it only logs

Aug 18 06:03:57 aurora kernel: hda: dma_timer_expiry: dma status == 0x21
Aug 18 06:04:12 aurora kernel: hda: timeout waiting for DMA
Aug 18 06:04:12 aurora kernel: hda: timeout waiting for DMA
Aug 18 06:04:12 aurora kernel: hda: (__ide_dma_test_irq) called while not
waiting
Aug 18 06:04:12 aurora kernel: hda: status timeout: status=0xd0 { Busy }
Aug 18 06:04:12 aurora kernel:
Aug 18 06:04:12 aurora kernel: hda: drive not ready for command
Aug 18 06:04:12 aurora kernel: ide0: reset: success

and continues to work.

Thanks a lot, now the box is usable even for bigger files!

c'ya
sven


ps: some information for the interested, more available on request:

00:1f.1 IDE interface: Intel Corp. 82801BAM IDE U100 (rev 03) (prog-if 80
[Master])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Flags: bus master, medium devsel, latency 0
        [virtual] I/O ports at 01f0 [size=8]
        [virtual] I/O ports at 03f4 [size=4]
        [virtual] I/O ports at 0170 [size=8]
        [virtual] I/O ports at 0374 [size=4]
        I/O ports at cff0 [size=16]


02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet
Controller (rev 03)
        Subsystem: Intel Corp.: Unknown device 3013
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at f7dff000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at df40 [size=64]
        Capabilities: [dc] Power Management version 2

Aug 18 05:47:09 aurora kernel: PCI: PCI BIOS revision 2.10 entry at
0xfdbb5, las
t bus=7
Aug 18 05:47:09 aurora kernel: PCI: Using configuration type 1
Aug 18 05:47:09 aurora kernel: PCI: Probing PCI hardware
Aug 18 05:47:09 aurora kernel: Unknown bridge resource 0: assuming
transparent
Aug 18 05:47:09 aurora kernel: Unknown bridge resource 2: assuming
transparent
Aug 18 05:47:09 aurora kernel: Unknown bridge resource 2: assuming
transparent
Aug 18 05:47:09 aurora kernel: PCI: Using IRQ router PIIX [8086/244c] at
00:1f.0
Aug 18 05:47:09 aurora kernel: PCI: Found IRQ 11 for device 02:0c.0
Aug 18 05:47:09 aurora kernel: PCI: Sharing IRQ 11 with 01:00.0
Aug 18 05:47:09 aurora kernel: PCI: Found IRQ 11 for device 02:0d.0
Aug 18 05:47:09 aurora kernel: PCI: Found IRQ 11 for device 02:0d.1
Aug 18 05:47:09 aurora kernel: PCI: Sharing IRQ 11 with 00:1f.5
Aug 18 05:47:09 aurora kernel: PCI: Sharing IRQ 11 with 00:1f.6
...
Aug 18 05:47:09 aurora kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Aug 18 05:47:09 aurora kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Aug 18 05:47:09 aurora kernel: ICH2M: IDE controller on PCI bus 00 dev f9
Aug 18 05:47:09 aurora kernel: ICH2M: chipset revision 3
Aug 18 05:47:09 aurora kernel: ICH2M: not 100%% native mode: will probe
irqs later
Aug 18 05:47:09 aurora kernel:     ide0: BM-DMA at 0xcff0-0xcff7, BIOS
settings: hda:DMA, hdb:pio
Aug 18 05:47:09 aurora kernel:     ide1: BM-DMA at 0xcff8-0xcfff, BIOS
settings: hdc:DMA, hdd:pio
Aug 18 05:47:09 aurora kernel: hda: IBM-DJSA-210, ATA DISK drive
Aug 18 05:47:09 aurora kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 18 05:47:09 aurora kernel: hdc: CD-224E-BA, ATAPI CD/DVD-ROM drive
Aug 18 05:47:09 aurora kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 18 05:47:09 aurora kernel: hda: host protected area => 1
Aug 18 05:47:09 aurora kernel: hda: 19640880 sectors (10056 MB) w/384KiB
Cache, CHS=1222/255/63, UDMA(66)
Aug 18 05:47:09 aurora kernel: Partition check:
Aug 18 05:47:09 aurora kernel:  hda: hda1 hda2 hda3 hda4


cat /proc/interrupts:

           CPU0
  0:    4201709          XT-PIC  timer
  1:      26354          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:     382697          XT-PIC  rtc
 11:    2028987          XT-PIC  Texas Instruments PCI1410 PC card Cardbus
Controller, Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge
with ZV Support, Toshiba America Info Systems ToPIC95 PCI to Cardbus
Bridge with ZV Support (#2), usb-uhci, usb-uhci, orinoco_cs, Intel
82801BA-ICH2, eth0
 12:     248224          XT-PIC  PS/2 Mouse
 14:     242584          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0
ERR:          0


-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

