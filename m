Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSIJT57>; Tue, 10 Sep 2002 15:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSIJT56>; Tue, 10 Sep 2002 15:57:58 -0400
Received: from regenboog.xs4all.nl ([213.84.113.241]:3200 "HELO xwing.home")
	by vger.kernel.org with SMTP id <S317628AbSIJT5y>;
	Tue, 10 Sep 2002 15:57:54 -0400
Date: Tue, 10 Sep 2002 22:02:44 +0200 (CEST)
From: Koos Vriezen <koos.vriezen@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
Message-ID: <Pine.LNX.4.33.0209102152500.818-100000@xwing.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  o i845G fixes

This doesn't include i845E? Kernel crashes right after boot message:

.....
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Found IRQ 10 for device 00:1f.1
<Crash>

Or something similar. These lines are from 2.4.20-pre5-ac3, which goes on
with:
CI: Sharing IRQ 10 with 00:1d.2
ICH4: Not fully BIOS configured!
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340016A, ATA DISK drive
hdc: LITE-ON LTR-48125W, ATAPI CD/DVD-ROM drive
hdd: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(100)
Partition check:
........

koos$ /sbin/lspci -v
00:00.0 Host bridge: Intel Corporation: Unknown device 1a30 (rev 11)
        Subsystem: Asustek Computer, Inc.: Unknown device 8088
        Flags: bus master, fast devsel, latency 0
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation: Unknown device 1a31 (rev 11)
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: ed000000-ee7fffff
        Prefetchable memory behind bridge: eff00000-f7ffffff

00:1d.0 USB Controller: Intel Corporation: Unknown device 24c2 (rev 01)
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corporation: Unknown device 24c4 (rev 01)
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at d400 [size=32]

00:1d.2 USB Controller: Intel Corporation: Unknown device 24c7 (rev 01)
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at d000 [size=32]

00:1d.7 USB Controller: Intel Corporation: Unknown device 24cd (rev 01)
(prog-if 20)
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 9
        Memory at ec800000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI
(rev 81) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Prefetchable memory behind bridge: ee800000-efefffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 24c0 (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 24cb (rev 01)
(prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at f000 [size=16]
        Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)
(prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 0001
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
        Memory at ed000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at efff0000 [disabled] [size=64K]
        Capabilities: <available only to root>

02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
        Subsystem: Asustek Computer, Inc.: Unknown device 80e2
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 9
        I/O ports at b800 [size=256]
        Capabilities: <available only to root>

02:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at ef000000 (32-bit, prefetchable) [size=4K]

02:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at ee800000 (32-bit, prefetchable) [size=4K]

02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Flags: medium devsel, IRQ 9
        I/O ports at b400 [size=32]

Regards,

Koos Vriezen

