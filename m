Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWBZVNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWBZVNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWBZVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:13:25 -0500
Received: from i-216-58-89-227.gta.igs.net ([216.58.89.227]:47765 "EHLO
	mail.undead.cc") by vger.kernel.org with ESMTP id S1751405AbWBZVNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:13:24 -0500
X-AuthUser: john@undead.cc
Message-ID: <440219EF.3040407@undead.cc>
Date: Sun, 26 Feb 2006 16:13:19 -0500
From: John Zielinski <john_ml@undead.cc>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: RTL 8139 stops RX after receiving a jumbo frame
References: <44012D53.30700@undead.cc> <20060226144424.GA26879@electric-eye.fr.zoreil.com>
In-Reply-To: <20060226144424.GA26879@electric-eye.fr.zoreil.com>
Content-Type: multipart/mixed;
 boundary="------------080008040107020504030007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008040107020504030007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Francois Romieu wrote:
> Can you send lspci -vx, dmesg and lsmod after the hang ?
>   


--------------080008040107020504030007
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Flags: bus master, medium devsel, latency 0
	Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 91 06 06 00 10 22 c4 00 00 06 00 00 00 00
10: 08 00 00 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f6000000-f75fffff
	Prefetchable memory behind bridge: f7700000-fbffffff
	Capabilities: [80] Power Management version 2
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 f6 50 f7 70 f7 f0 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

0000:00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, stepping, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 87 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 1a 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 04 00 00

0000:00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 1a 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 04 00 00

0000:00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at b800 [size=128]
	Memory at f5800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 20000000 [disabled] [size=64K]
00: ec 10 39 81 07 00 00 02 10 00 00 02 00 20 00 00
10: 01 b8 00 00 00 00 80 f5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 20 40

0000:01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] (rev a3) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 001b
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f7800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at f77f0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0
00: de 10 00 02 07 00 b0 02 a3 00 00 03 00 40 00 00
10: 00 00 00 f6 08 00 00 f8 08 00 80 f7 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 45 15 1b 00
30: 00 00 7f f7 60 00 00 00 00 00 00 00 0a 01 05 01

--------------080008040107020504030007
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.15.4 (root@test) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #2 PREEMPT Sun Feb 26 14:01:26 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98284
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 94188 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f7360
ACPI: RSDT (v001 ASUS   TUV4X    0x30303031 MSFT 0x31313031) @ 0x17fec000
ACPI: FADT (v001 ASUS   TUV4X    0x30303031 MSFT 0x31313031) @ 0x17fec080
ACPI: BOOT (v001 ASUS   TUV4X    0x30303031 MSFT 0x31313031) @ 0x17fec040
ACPI: DSDT (v001   ASUS TUV4X    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 20000000 (gap: 18000000:e7ff0000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 vga=0xa
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01301000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 805.786 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 132x60
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 386492k/393136k available (1736k kernel code, 6136k reserved, 555k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1613.23 BogoMIPS (lpj=3226475)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0d20, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [1106/0691] 000600 00
PCI: Calling quirk c01dff40 for 0000:00:00.0
PCI: Calling quirk c0257a10 for 0000:00:00.0
PCI: Calling quirk c0257de0 for 0000:00:00.0
PCI: Found 0000:00:01.0 [1106/8598] 000604 01
PCI: Calling quirk c01dff40 for 0000:00:01.0
PCI: Calling quirk c0257a10 for 0000:00:01.0
PCI: Calling quirk c0257de0 for 0000:00:01.0
PCI: Found 0000:00:04.0 [1106/0686] 000601 00
PCI: Calling quirk c01dff40 for 0000:00:04.0
PCI: Calling quirk c0257a10 for 0000:00:04.0
PCI: Calling quirk c0257de0 for 0000:00:04.0
PCI: Found 0000:00:04.1 [1106/0571] 000101 00
PCI: Calling quirk c01dff40 for 0000:00:04.1
PCI: Calling quirk c0257a10 for 0000:00:04.1
PCI: Calling quirk c0257de0 for 0000:00:04.1
PCI: Found 0000:00:04.2 [1106/3038] 000c03 00
PCI: Calling quirk c01dff40 for 0000:00:04.2
PCI: Calling quirk c0257a10 for 0000:00:04.2
PCI: Calling quirk c0257de0 for 0000:00:04.2
PCI: Found 0000:00:04.3 [1106/3038] 000c03 00
PCI: Calling quirk c01dff40 for 0000:00:04.3
PCI: Calling quirk c0257a10 for 0000:00:04.3
PCI: Calling quirk c0257de0 for 0000:00:04.3
PCI: Found 0000:00:04.4 [1106/3057] 000600 00
PCI: Calling quirk c01df9b0 for 0000:00:04.4
PCI quirk: region e800-e80f claimed by vt82c686 SMB
PCI: Calling quirk c01dfc90 for 0000:00:04.4
PCI: Calling quirk c01dff40 for 0000:00:04.4
PCI: Calling quirk c0257a10 for 0000:00:04.4
PCI: Calling quirk c0257de0 for 0000:00:04.4
PCI: Found 0000:00:0a.0 [10ec/8139] 000200 00
PCI: Calling quirk c01dff40 for 0000:00:0a.0
PCI: Calling quirk c0257a10 for 0000:00:0a.0
PCI: Calling quirk c0257de0 for 0000:00:0a.0
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [10de/0200] 000300 00
PCI: Calling quirk c01dff40 for 0000:01:00.0
PCI: Calling quirk c0257a10 for 0000:01:00.0
PCI: Calling quirk c0257de0 for 0000:01:00.0
Boot video device is 0000:01:00.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Bus scan for 0000:00 returning with max=01
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
  got res [20000000:2000ffff] bus [20000000:2000ffff] flags 7200 for BAR 6 of 0000:00:0a.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f6000000-f75fffff
  PREFETCH window: f7700000-fbffffff
PCI: Calling quirk c01dfcf0 for 0000:00:01.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Calling quirk c01dfdf0 for 0000:00:00.0
PCI: Calling quirk c024bea0 for 0000:00:00.0
PCI: Calling quirk c01dfdf0 for 0000:00:01.0
PCI: Calling quirk c024bea0 for 0000:00:01.0
PCI: Calling quirk c01dfb50 for 0000:00:04.0
PCI: Disabling Via external APIC routing
PCI: Calling quirk c01dfdf0 for 0000:00:04.0
PCI: Calling quirk c024bea0 for 0000:00:04.0
PCI: Calling quirk c01dfdf0 for 0000:00:04.1
PCI: Calling quirk c024bea0 for 0000:00:04.1
PCI: Calling quirk c01dfdf0 for 0000:00:04.2
PCI: Calling quirk c024bea0 for 0000:00:04.2
PCI: Calling quirk c01dfdf0 for 0000:00:04.3
PCI: Calling quirk c024bea0 for 0000:00:04.3
PCI: Calling quirk c01dfdf0 for 0000:00:04.4
PCI: Calling quirk c024bea0 for 0000:00:04.4
PCI: Calling quirk c01dfdf0 for 0000:00:0a.0
PCI: Calling quirk c024bea0 for 0000:00:0a.0
PCI: Calling quirk c01dfdf0 for 0000:01:00.0
PCI: Calling quirk c024bea0 for 0000:01:00.0
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
PCI: Calling quirk c01dfcf0 for 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 91728D8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: BENQ DVD DUAL DW1610, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 33750864 sectors (17280 MB) w/512KiB Cache, CHS=33483/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
logips2pp: Detected unknown logitech mouse model 72
input: PS/2 Logitech Mouse as /class/input/input1
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 979924k swap on /dev/hda2.  Priority:-1 extents:1 across:979924k
8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:00:0a.0 (0004 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xd8932000, 00:4f:4e:00:5d:fd, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139 rev K'
eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1

--------------080008040107020504030007
Content-Type: text/plain;
 name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod"

Module                  Size  Used by
8139too                27136  0 

--------------080008040107020504030007--
