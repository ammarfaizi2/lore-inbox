Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVDANAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVDANAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDANAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:00:22 -0500
Received: from smtp05.web.de ([217.72.192.209]:43919 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S262738AbVDAM4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:56:23 -0500
Message-ID: <424D44F0.6090707@web.de>
Date: Fri, 01 Apr 2005 14:56:16 +0200
From: Michael Thonke <tk-shockwave@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050323)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI-Express not working/unuseable on Intel 925XE Chipset since 2.6.12-rc1[mm1-4]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0513-2, 01.04.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since the first version of 2.6.12-rc1 and mm[1-4] kernel I can't use any
of my PCI-Express devices that worked with all 2.6.11.[1-6] kernels. 
It's a real odd right now.

I have 25 computers with an Intel 925XE Chipset based motherboards and 
Intel 6xx CPU on it. So far it does not metter which vendor I choose 
(ASUS,ABIT,MSI etc.) the problem stay the same and spread all over.I
tried to boot with pci=routeicq but it did not help to get one device
working with any 2.6.12-rc1-xx kernel. As I mentioned before I tested it 
with on several (over 25 computer) with various motherboards (with 
ASUS,ABIT,MSI etc.) no luck. Its an 64bit system with [EMT64] and 
SMP/SMT and preempt enabled + cpufreq.

My first look was on PCI Routingtable and I found a difference to
2.6.11.x working kernel:

So far
Thanks in advance and best regards

//possible bug/problem

PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Can't get handler for 0000:00:1b.0 --> why this happen
ACPI: Can't get handler for 0000:00:1f.3 --> it does not appear
ACPI: Can't get handler for 0000:04:00.0 --> on 2.6.11.x kernels.
ACPI: Can't get handler for 0000:02:00.0 --> - * -
ACPI: Can't get handler for 0000:01:09.0 --> - * -
ACPI: Can't get handler for 0000:01:0a.0 --> - * -
//this looks like a garbage routing and handler table here

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)

//lspci -v output

0000:00:00.0 Host bridge: Intel Corporation 925X/XE Memory Controller
Hub (rev 0e)
    Subsystem: Intel Corporation: Unknown device 2580
    Flags: bus master, fast devsel, latency 0
    Capabilities: [e0] #09 [0109]

0000:00:01.0 PCI bridge: Intel Corporation 925X/XE PCI Express Root Port
(rev 0e) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: d2f00000-d7ffffff
    Prefetchable memory behind bridge: d8000000-dfffffff
    Expansion ROM at 0000e000 [disabled] [size=4K]
    Capabilities: [88] #0d [0000]
    Capabilities: [80] Power Management version 2
    Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
    Capabilities: [a0] #10 [0141]

0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
    Subsystem: ASUSTeK Computer Inc.: Unknown device 813d
    Flags: bus master, fast devsel, latency 0, IRQ 169
    Memory at d2cf4000 (64-bit, non-prefetchable)
    Capabilities: [50] Power Management version 2
    Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
    Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000d000-0000dfff
    Expansion ROM at 0000d000 [disabled] [size=4K]
    Capabilities: [40] #10 [0141]
    Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
    Capabilities: [90] #0d [0000]
    Capabilities: [a0] Power Management version 2

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 0000c000-0000cfff
    Memory behind bridge: d2e00000-d2efffff
    Expansion ROM at 0000c000 [disabled] [size=4K]
    Capabilities: [40] #10 [0141]
    Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
    Capabilities: [90] #0d [0000]
    Capabilities: [a0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
    Flags: bus master, medium devsel, latency 0, IRQ 50
    I/O ports at 9880 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
    Flags: bus master, medium devsel, latency 0, IRQ 233
    I/O ports at 9c00 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
    Flags: bus master, medium devsel, latency 0, IRQ 225
    I/O ports at a000 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
    Flags: bus master, medium devsel, latency 0, IRQ 169
    I/O ports at a080 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
    Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
    Flags: bus master, medium devsel, latency 0, IRQ 50
    Memory at d2cff800 (32-bit, non-prefetchable)
    Capabilities: [50] Power Management version 2
    Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d4)
(prog-if 01 [Subtractive decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
    I/O behind bridge: 0000b000-0000bfff
    Memory behind bridge: d2d00000-d2dfffff
    Expansion ROM at 0000b000 [disabled] [size=4K]
    Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC
Interface Bridge (rev 04)
    Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
    Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
    Flags: bus master, medium devsel, latency 0, IRQ 225
    I/O ports at <unassigned>
    I/O ports at <unassigned>
    I/O ports at <unassigned>
    I/O ports at <unassigned>
    I/O ports at ffa0 [size=16]

0000:00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW)
SATA Controller (rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
    Subsystem: ASUSTeK Computer Inc.: Unknown device 2601
    Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 233
    I/O ports at ac00
    I/O ports at a880 [size=4]
    I/O ports at a800 [size=8]
    I/O ports at a480 [size=4]
    I/O ports at a400 [size=16]
    Memory at d2cffc00 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [70] Power Management version 2

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) SMBus Controller (rev 04)
    Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
    Flags: medium devsel
    I/O ports at 0400 [size=32]

0000:01:09.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
    Subsystem: TERRATEC Electronic GmbH: Unknown device 1158
    Flags: bus master, medium devsel, latency 32, IRQ 7
    Memory at d2dff800 (32-bit, non-prefetchable)
    Capabilities: [40] Power Management version 1

0000:01:0a.0 Ethernet controller: VIA Technologies, Inc. VT6105
[Rhine-III] (rev 86)
    Subsystem: D-Link System Inc DFE-530TX rev C
    Flags: bus master, medium devsel, latency 32, IRQ 217
    I/O ports at b800 [size=d2de0000]
    Memory at d2dffc00 (32-bit, non-prefetchable) [size=256]
    Expansion ROM at 00010000 [disabled]
    Capabilities: [40] Power Management version 2

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit
Ethernet Controller (rev 19)
    Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet
Controller (Asus)
    Flags: bus master, fast devsel, latency 0, IRQ 7
    Memory at d2efc000 (64-bit, non-prefetchable) [size=d2ec0000]
    I/O ports at c800 [size=256]
    Expansion ROM at 00020000 [disabled]
    Capabilities: [48] Power Management version 2
    Capabilities: [50] Vital Product Data
    Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1
Enable-
    Capabilities: [e0] #10 [0011]

0000:04:00.0 VGA compatible controller: nVidia Corporation NV43 [MSI
NX6600GT-TD128E] (rev a2) (prog-if 00 [VGA])
    Flags: bus master, fast devsel, latency 0, IRQ 169
    Memory at d4000000 (32-bit, non-prefetchable) [size=d2fe0000]
    Memory at d8000000 (64-bit, prefetchable) [size=128M]
    Memory at d3000000 (64-bit, non-prefetchable) [size=16M]
    Expansion ROM at 00020000 [disabled]
    Capabilities: [60] Power Management version 2
    Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
    Capabilities: [78] #10 [0001]


//dmesg output
Linux version 2.6.12-rc1-mm4 (root@ioGL64NX) (gcc-Version 3.4.3-20050110
(Gentoo Linux 3.4.3.20050110-r1, ssp-3.4.3.20050110-0, pie-8.7.7)) #1
SMP PREEMPT Fri Apr 1 03:47:10 CEST 2005
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @
0x00000000000fafa0
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000503 MSFT 0x00000097) @
0x000000003ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x02000503 MSFT 0x00000097) @
0x000000003ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x02000503 MSFT 0x00000097) @
0x000000003ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x02000503 MSFT 0x00000097) @
0x000000003ffbe040
ACPI: MCFG (v001 A M I  OEMMCFG  0x02000503 MSFT 0x00000097) @
0x000000003ffb6c40
ACPI: DSDT (v001  A0144 A0144000 0x00000000 INTL 0x02002026) @
0x0000000000000000
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257968 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/md0 vga=794 console=tty0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 3236.075 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1025400k/1048256k available (2858k kernel code, 22228k reserved,
1187k data, 208k init)
Calibrating delay loop... 6389.76 BogoMIPS (lpj=3194880)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using IO APIC NMI watchdog
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU0:               Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Booting processor 1/1 rip 6000 rsp ffff81003ff19f58
Initializing CPU#1
Calibrating delay loop... 6455.29 BogoMIPS (lpj=3227648)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Total of 2 processors activated (12845.05 BogoMIPS).
activating NMI Watchdog ... done.
Using local APIC timer interrupts.
Detected 12.640 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
CPU0 attaching sched-domain:
domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1 attaching sched-domain:
domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Can't get handler for 0000:00:1b.0
ACPI: Can't get handler for 0000:00:1f.3
ACPI: Can't get handler for 0000:04:00.0
ACPI: Can't get handler for 0000:02:00.0
ACPI: Can't get handler for 0000:01:09.0
ACPI: Can't get handler for 0000:01:0a.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1112328651.185:0): initialized
inotify device minor=63
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: No ACPI bus support for pcie00
Allocate Port Service[pcie03]
ACPI: No ACPI bus support for pcie03
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: No ACPI bus support for pcie00
Allocate Port Service[pcie02]
ACPI: No ACPI bus support for pcie02
Allocate Port Service[pcie03]
ACPI: No ACPI bus support for pcie03
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: No ACPI bus support for pcie00
Allocate Port Service[pcie02]
ACPI: No ACPI bus support for pcie02
Allocate Port Service[pcie03]
ACPI: No ACPI bus support for pcie03
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using
5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: No ACPI bus support for vesafb.0
fb1: Virtual frame buffer device, using 1024K of video memory
ACPI: No ACPI bus support for vfb.0
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
hw_random: RNG not detected
io scheduler noop registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: No ACPI bus support for floppy.0
RAMDISK driver initialized: 4 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
ub: sizeof ub_scsi_cmd 88 ub_dev 2680
usbcore: registered new driver ub
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 217
eth0: VIA Rhine III at 0xd2dffc00, 00:0d:88:17:47:40, IRQ 217.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 225
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ACPI: No ACPI bus support for 0.0
Probing IDE interface ide1...
hda: ATAPI 94X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 233
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 233
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata1: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
ata1: dev 1 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata1: dev 1 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata2: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
ata2: dev 1 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata2: dev 1 ATA, max UDMA7, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
ata2: dev 1 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP1213C   Rev: SV10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 0:0:0:0
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 0:0:1:0
  Vendor: ATA       Model: SAMSUNG SP1213C   Rev: SV10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 1:0:0:0
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 1:0:1:0
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sda: drive cache: write back
sda: sda1 sda2 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
sdb: sdb1 sdb2 < sdb5 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 234493056 512-byte hdwr sectors (120060 MB)
Losing some ticks... checking if CPU frequency changed.
SCSI device sdc: drive cache: write back
SCSI device sdc: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sdc: drive cache: write back
sdc: sdc1 sdc2 < sdc5 sdc6 >
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
sdd: sdd1
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi1, channel 0, id 1, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 50, io mem 0xd2cff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ACPI: No ACPI bus support for usb1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: No ACPI bus support for 1-0:1.0
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 50, io base 0x00009880
ACPI: No ACPI bus support for usb2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 2-0:1.0
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 233, io base 0x00009c00
ACPI: No ACPI bus support for usb3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 3-0:1.0
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 225, io base 0x0000a000
ACPI: No ACPI bus support for usb4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 4-0:1.0
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000a080
ACPI: No ACPI bus support for usb5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 5-0:1.0
Initializing USB Mass Storage driver...
usb 3-1: new low speed USB device using uhci_hcd and address 2
ACPI: No ACPI bus support for 3-1
ACPI: No ACPI bus support for 3-1:1.0
ACPI: No ACPI bus support for 3-1:1.1
usb 3-2: new low speed USB device using uhci_hcd and address 3
ACPI: No ACPI bus support for 3-2
ACPI: No ACPI bus support for 3-2:1.0
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on
usb-0000:00:1d.1-1
input: USB HID v1.10 Device [Logitech HID compliant keyboard] on
usb-0000:00:1d.1-1
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:1d.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  4704.000 MB/sec
raid5: using function: generic_sse (4704.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA device list:
  #0: HDA Intel at 0xd2cf4000 irq 169
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI wakeup devices:
P0P1 P0P3 P0P4 P0P5 P0P6 P0P7 USB1 USB2 USB3 USB4 EUSB MC97
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc6 ...
md: sdc5 has different UUID to sdd1
md:  adding sdb1 ...
md:  adding sda6 ...
md: sda5 has different UUID to sdd1
md: created md1
md: bind<sda6>
md: bind<sdb1>
md: bind<sdc6>
md: bind<sdd1>
md: running: <sdd1><sdc6><sdb1><sda6>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdd1
raid0:   comparing sdd1(14996544) with sdd1(14996544)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc6
raid0:   comparing sdc6(14996544) with sdd1(14996544)
raid0:   EQUAL
raid0: looking at sdb1
raid0:   comparing sdb1(14996544) with sdd1(14996544)
raid0:   EQUAL
raid0: looking at sda6
raid0:   comparing sda6(14996544) with sdd1(14996544)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 59986176 blocks.
raid0 : conf->hash_spacing is 59986176 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering sdc5 ...
md:  adding sdc5 ...
md:  adding sda5 ...
md: created md0
md: bind<sda5>
md: bind<sdc5>
md: running: <sdc5><sda5>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdc5
raid0:   comparing sdc5(30001280) with sdc5(30001280)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda5
raid0:   comparing sda5(30001280) with sdc5(30001280)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 60002560 blocks.
raid0 : conf->hash_spacing is 60002560 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 208k freed
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:04:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue
Mar 22 06:45:40 PST 2005
ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
ReiserFS: sdc1: using ordered data mode
ReiserFS: sdc1: journal params: device sdc1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdc1: checking transaction log (sdc1)
ReiserFS: sdc1: Using r5 hash to sort names


