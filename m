Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTFIGnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 02:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTFIGnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 02:43:31 -0400
Received: from mout0.freenet.de ([194.97.50.131]:986 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S264257AbTFIGnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 02:43:25 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: [2.4.17rc7] broken IO-APIC support with MPS 1.4
Date: Mon, 09 Jun 2003 09:03:26 +0200
Organization: privat
Message-ID: <bc1bfu$28r$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1055142206 2331 192.168.1.3 (9 Jun 2003 07:03:26 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.2
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm using a 8K5A motherboard with APIC (MPS 1.4; Epox says in the manual,
that linux would use this version) turned on in bios and kernel. Using this
configuration breakes the onboard sound (VT8233/A/8235 AC97 Audio
Controller (rev 50).

If I use MPS 1.1 in BIOS, sound works fine.


> dmesg
Linux version 2.4.21-rc7 (root@athlon) (gcc version 3.2.3) #3 Sam Jun 7
20:03:20 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5d40
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=2421rc7 rw root=301
BOOT_FILE=/boot/vmlinuz-2.4.21-rc7 init 2
Initializing CPU#0
Detected 1670.487 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3335.78 BogoMIPS
Memory: 516480k/524224k available (1021k kernel code, 7356k reserved, 224k
data, 236k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 001 01  1    1    0   1   0    1    1    99
 12 001 01  1    1    0   1   0    1    1    A1
 13 001 01  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1670.5134 MHz.
..... host bus clock speed is 267.2820 MHz.
cpu: 0, clocks: 2672820, slice: 1336410
CPU0<T0:2672816,T1:1336400,D:6,S:1336410,C:2672820>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 18
PCI->APIC IRQ transform: (B0,I16,P0) -> 16
PCI->APIC IRQ transform: (B0,I16,P1) -> 17
PCI->APIC IRQ transform: (B0,I16,P2) -> 18
PCI->APIC IRQ transform: (B0,I16,P3) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I17,P2) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Via IRQ fixup for 00:10.0, from 11 to 0
PCI: Via IRQ fixup for 00:10.1, from 5 to 1
PCI: Via IRQ fixup for 00:10.2, from 11 to 2


> lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333
AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d8000000-dbffffff
        Capabilities: [80] Power Management version 2

00:09.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d000 [size=256]
        Memory at df022000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 1

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d400 [size=256]
        Memory at df020000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at df021000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at d800 [size=64]
        Memory at df000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20
[EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at df023000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at e800 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235
AC97 Audio Controller (rev 50)
        Subsystem: Unknown device 1695:3005
        Flags: medium devsel, IRQ 11
        I/O ports at ec00 [size=256]
        Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP
4x TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ
11
        Memory at d8000000 (32-bit, prefetchable) [size=64M]
        I/O ports at c000 [size=256]
        Memory at dd000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2


> cat /proc/interupts (MSP version 1.4)
           CPU0
  0:      72798    IO-APIC-edge  timer
  1:       3355    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  7:          2    IO-APIC-edge  parport0
 12:      22081    IO-APIC-edge  PS/2 Mouse
 14:      28730    IO-APIC-edge  ide0
 15:          2    IO-APIC-edge  ide1
 17:       4184   IO-APIC-level  eth0
 18:          4   IO-APIC-level  eth1, via82cxxx
NMI:          0
LOC:      72753
ERR:          0
MIS:          0


Kind regards,
Andreas Hartmann
