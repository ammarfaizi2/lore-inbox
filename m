Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTININp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbTININp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:13:45 -0400
Received: from webmail.netregistry.net ([203.202.16.21]:39827 "EHLO
	webmail.netregistry.net") by vger.kernel.org with ESMTP
	id S262331AbTINIMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:12:54 -0400
Message-ID: <1063527169.3f642301c00e7@webmail.netregistry.net>
Date: Sun, 14 Sep 2003 18:12:49 +1000
From: Dmitri Katchalov <dmitrik@users.sourceforge.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5 atkbd.c: Unknown key (100% reproduceable)
References: <1063443074.3f62da82a7e24@webmail.netregistry.net> <20030913220743.B3295@pclin040.win.tue.nl>
In-Reply-To: <20030913220743.B3295@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 144.132.160.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andries Brouwer <aebr@win.tue.nl>:

> On Sat, Sep 13, 2003 at 06:51:14PM +1000, Dmitri Katchalov wrote:
> 
> > I'm consistently getting this error:
> > 
> > atkbd.c: Unknown key (set 2, scancode 0xab, on isa0060/serio0) pressed.
> > This happens whenever I type 'f' in "<F7>usbdevfs". 
> 
> Question 1: Does the error remain if you switch off preemptive?

Yes. I also tried nosmp at the lilo prompt but my kernel gets stuck when
it comes to initialising ide controller (it says "ide2: lost interrupt")
Not sure if it is a bug or a feature:)

> Question 2: Can you enable DEBUG in i8042.c, repeat the error
> and mail me the resulting output?

See below. Hope it helps. 

Oh yes, it eats 'f' in "make menuconfig" 3 out of 4 times. 
The keyboard in question is "StudyMate" keyboard.
In addition to the usual keys it has left and right windows keys,
menu key, power, sleep, wake and Fn keys. These extra keys 
have never worked as far as I remember.
On the back it says: "Turbo-Track Keyboard" FCC ID: HQK BITS9001
The keyboard worked just fine in "the other" OS 

Regards,
Dmitri


Sep 15 01:19:33 box kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Sep 15 01:19:33 box kernel: Inspecting /boot/System.map-2.6.0-test5
Sep 15 01:19:33 box kernel: Loaded 22605 symbols from /boot/System.map-2.6.0-
test5.
Sep 15 01:19:33 box kernel: Symbols match kernel version 2.6.0.
Sep 15 01:19:33 box kernel: No module symbols loaded - kernel modules not 
enabled. 
Sep 15 01:19:33 box kernel: Linux version 2.6.0-test5 (root@box) (gcc version 
2.95.4 20011002 (Debian prerelease)) #7 SMP Mon Sep 15 00:56:00 EST 2003
Sep 15 01:19:33 box kernel: Video mode to be used for restore is ffff
Sep 15 01:19:33 box kernel: BIOS-provided physical RAM map:
Sep 15 01:19:33 box kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 
(usable)
Sep 15 01:19:33 box kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 
(reserved)
Sep 15 01:19:33 box kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Sep 15 01:19:33 box kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 
(usable)
Sep 15 01:19:33 box kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 
(ACPI NVS)
Sep 15 01:19:33 box kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 
(ACPI data)
Sep 15 01:19:33 box kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 
(reserved)
Sep 15 01:19:33 box kernel: 127MB HIGHMEM available.
Sep 15 01:19:33 box kernel: 896MB LOWMEM available.
Sep 15 01:19:33 box kernel: found SMP MP-table at 000f5cd0
Sep 15 01:19:33 box kernel: hm, page 000f5000 reserved twice.
Sep 15 01:19:33 box kernel: hm, page 000f6000 reserved twice.
Sep 15 01:19:33 box kernel: hm, page 000f0000 reserved twice.
Sep 15 01:19:33 box kernel: hm, page 000f1000 reserved twice.
Sep 15 01:19:33 box kernel: On node 0 totalpages: 262128
Sep 15 01:19:33 box kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep 15 01:19:33 box kernel:   Normal zone: 225280 pages, LIFO batch:16
Sep 15 01:19:33 box kernel:   HighMem zone: 32752 pages, LIFO batch:7
Sep 15 01:19:33 box kernel: DMI 2.2 present.
Sep 15 01:19:33 box kernel: ACPI: RSDP (v000 
IntelR                                    ) @ 0x000f7b00
Sep 15 01:19:33 box kernel: ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff3000
Sep 15 01:19:33 box kernel: ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff3040
Sep 15 01:19:33 box kernel: ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff75c0
Sep 15 01:19:33 box kernel: ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 
0x0100000e) @ 0x00000000
Sep 15 01:19:33 box kernel: ACPI: Local APIC address 0xfee00000
Sep 15 01:19:33 box kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Sep 15 01:19:33 box kernel: Processor #0 15:2 APIC version 20
Sep 15 01:19:33 box kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Sep 15 01:19:33 box kernel: Processor #1 15:2 APIC version 20
Sep 15 01:19:33 box kernel: ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger
[0x1] lint[0x1])
Sep 15 01:19:33 box kernel: ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger
[0x1] lint[0x1])
Sep 15 01:19:33 box kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] 
global_irq_base[0x0])
Sep 15 01:19:33 box kernel: IOAPIC[0]: Assigned apic_id 2
Sep 15 01:19:33 box kernel: IOAPIC[0]: apic_id 2, version 32, address 
0xfec00000, IRQ 0-23
Sep 15 01:19:33 box kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] 
polarity[0x0] trigger[0x0])
Sep 15 01:19:33 box kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] 
polarity[0x1] trigger[0x3])
Sep 15 01:19:33 box kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Sep 15 01:19:33 box kernel: Using ACPI (MADT) for SMP configuration information
Sep 15 01:19:33 box kernel: Building zonelist for node : 0
Sep 15 01:19:33 box kernel: Kernel command line: BOOT_IMAGE=Linux ro root=2103
Sep 15 01:19:33 box kernel: Initializing CPU#0
Sep 15 01:19:33 box kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Sep 15 01:19:33 box kernel: Detected 2405.928 MHz processor.
Sep 15 01:19:33 box kernel: Console: colour VGA+ 80x25
Sep 15 01:19:33 box kernel: Memory: 1033944k/1048512k available (1827k kernel 
code, 13640k reserved, 920k data, 140k init, 131008k highmem)
Sep 15 01:19:33 box kernel: Calibrating delay loop... 4751.36 BogoMIPS
Sep 15 01:19:33 box kernel: Dentry cache hash table entries: 131072 (order: 7, 
524288 bytes)
Sep 15 01:19:33 box kernel: Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Sep 15 01:19:33 box kernel: Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Sep 15 01:19:33 box kernel: -> /dev
Sep 15 01:19:33 box kernel: -> /dev/console
Sep 15 01:19:33 box kernel: -> /root
Sep 15 01:19:33 box kernel: CPU:     After generic identify, caps: bfebfbff 
00000000 00000000 00000000
Sep 15 01:19:33 box kernel: CPU:     After vendor identify, caps: bfebfbff 
00000000 00000000 00000000
Sep 15 01:19:33 box kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Sep 15 01:19:33 box kernel: CPU: L2 cache: 512K
Sep 15 01:19:33 box kernel: CPU: Physical Processor ID: 0
Sep 15 01:19:33 box kernel: CPU:     After all inits, caps: bfebfbff 00000000 
00000000 00000080
Sep 15 01:19:33 box kernel: Intel machine check architecture supported.
Sep 15 01:19:33 box kernel: Intel machine check reporting enabled on CPU#0.
Sep 15 01:19:33 box kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) 
available
Sep 15 01:19:33 box kernel: CPU#0: Thermal monitoring enabled
Sep 15 01:19:33 box kernel: Enabling fast FPU save and restore... done.
Sep 15 01:19:33 box kernel: Enabling unmasked SIMD FPU exception support... 
done.
Sep 15 01:19:33 box kernel: Checking 'hlt' instruction... OK.
Sep 15 01:19:34 box kernel: POSIX conformance testing by UNIFIX
Sep 15 01:19:34 box kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Sep 15 01:19:34 box kernel: per-CPU timeslice cutoff: 1463.08 usecs.
Sep 15 01:19:34 box kernel: task migration cache decay timeout: 2 msecs.
Sep 15 01:19:34 box kernel: enabled ExtINT on CPU#0
Sep 15 01:19:34 box kernel: ESR value before enabling vector: 00000000
Sep 15 01:19:34 box kernel: ESR value after enabling vector: 00000000
Sep 15 01:19:34 box kernel: Booting processor 1/1 eip 2000
Sep 15 01:19:34 box kernel: Initializing CPU#1
Sep 15 01:19:34 box kernel: masked ExtINT on CPU#1
Sep 15 01:19:34 box kernel: ESR value before enabling vector: 00000000
Sep 15 01:19:34 box kernel: ESR value after enabling vector: 00000000
Sep 15 01:19:34 box kernel: Calibrating delay loop... 4800.51 BogoMIPS
Sep 15 01:19:34 box kernel: CPU:     After generic identify, caps: bfebfbff 
00000000 00000000 00000000
Sep 15 01:19:34 box kernel: CPU:     After vendor identify, caps: bfebfbff 
00000000 00000000 00000000
Sep 15 01:19:34 box kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Sep 15 01:19:34 box kernel: CPU: L2 cache: 512K
Sep 15 01:19:34 box kernel: CPU: Physical Processor ID: 0
Sep 15 01:19:34 box kernel: CPU:     After all inits, caps: bfebfbff 00000000 
00000000 00000080
Sep 15 01:19:34 box kernel: Intel machine check architecture supported.
Sep 15 01:19:34 box kernel: Intel machine check reporting enabled on CPU#1.
Sep 15 01:19:34 box kernel: CPU#1: Intel P4/Xeon Extended MCE MSRs (12) 
available
Sep 15 01:19:34 box kernel: CPU#1: Thermal monitoring enabled
Sep 15 01:19:34 box kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Sep 15 01:19:34 box kernel: Total of 2 processors activated (9551.87 BogoMIPS).
Sep 15 01:19:34 box kernel: cpu_sibling_map[0] = 1
Sep 15 01:19:34 box kernel: cpu_sibling_map[1] = 0
Sep 15 01:19:34 box kernel: ENABLING IO-APIC IRQs
Sep 15 01:19:34 box kernel: init IO_APIC IRQs
Sep 15 01:19:34 box kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 
2-20, 2-21, 2-22, 2-23 not connected.
Sep 15 01:19:34 box kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Sep 15 01:19:34 box kernel: number of MP IRQ sources: 15.
Sep 15 01:19:34 box kernel: number of IO-APIC #2 registers: 24.
Sep 15 01:19:34 box kernel: testing the IO APIC.......................
Sep 15 01:19:34 box kernel: IO APIC #2......
Sep 15 01:19:34 box kernel: .... register #00: 02000000
Sep 15 01:19:34 box kernel: .......    : physical APIC id: 02
Sep 15 01:19:34 box kernel: .......    : Delivery Type: 0
Sep 15 01:19:34 box kernel: .......    : LTS          : 0
Sep 15 01:19:34 box kernel: .... register #01: 00178020
Sep 15 01:19:34 box kernel: .......     : max redirection entries: 0017
Sep 15 01:19:34 box kernel: .......     : PRQ implemented: 1
Sep 15 01:19:34 box kernel: .......     : IO APIC version: 0020
Sep 15 01:19:34 box kernel: .... IRQ redirection table:
Sep 15 01:19:34 box kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:   
Sep 15 01:19:34 box kernel:  00 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  01 001 01  0    0    0   0   0    1    1    39
Sep 15 01:19:34 box kernel:  02 001 01  0    0    0   0   0    1    1    31
Sep 15 01:19:34 box kernel:  03 001 01  0    0    0   0   0    1    1    41
Sep 15 01:19:34 box kernel:  04 001 01  0    0    0   0   0    1    1    49
Sep 15 01:19:34 box kernel:  05 001 01  0    0    0   0   0    1    1    51
Sep 15 01:19:34 box kernel:  06 001 01  0    0    0   0   0    1    1    59
Sep 15 01:19:34 box kernel:  07 001 01  0    0    0   0   0    1    1    61
Sep 15 01:19:34 box kernel:  08 001 01  0    0    0   0   0    1    1    69
Sep 15 01:19:34 box kernel:  09 001 01  1    1    0   0   0    1    1    71
Sep 15 01:19:34 box kernel:  0a 001 01  0    0    0   0   0    1    1    79
Sep 15 01:19:34 box kernel:  0b 001 01  0    0    0   0   0    1    1    81
Sep 15 01:19:34 box kernel:  0c 001 01  0    0    0   0   0    1    1    89
Sep 15 01:19:34 box kernel:  0d 001 01  0    0    0   0   0    1    1    91
Sep 15 01:19:34 box kernel:  0e 001 01  0    0    0   0   0    1    1    99
Sep 15 01:19:34 box kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Sep 15 01:19:34 box kernel:  10 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  11 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  12 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  13 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  14 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  15 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  16 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel:  17 000 00  1    0    0   0   0    0    0    00
Sep 15 01:19:34 box kernel: IRQ to pin mappings:
Sep 15 01:19:34 box kernel: IRQ0 -> 0:2
Sep 15 01:19:34 box kernel: IRQ1 -> 0:1
Sep 15 01:19:34 box kernel: IRQ3 -> 0:3
Sep 15 01:19:34 box kernel: IRQ4 -> 0:4
Sep 15 01:19:34 box kernel: IRQ5 -> 0:5
Sep 15 01:19:34 box kernel: IRQ6 -> 0:6
Sep 15 01:19:34 box kernel: IRQ7 -> 0:7
Sep 15 01:19:34 box kernel: IRQ8 -> 0:8
Sep 15 01:19:34 box kernel: IRQ9 -> 0:9
Sep 15 01:19:34 box kernel: IRQ10 -> 0:10
Sep 15 01:19:34 box kernel: IRQ11 -> 0:11
Sep 15 01:19:34 box kernel: IRQ12 -> 0:12
Sep 15 01:19:34 box kernel: IRQ13 -> 0:13
Sep 15 01:19:34 box kernel: IRQ14 -> 0:14
Sep 15 01:19:34 box kernel: IRQ15 -> 0:15
Sep 15 01:19:34 box kernel: .................................... done.
Sep 15 01:19:34 box kernel: Using local APIC timer interrupts.
Sep 15 01:19:34 box kernel: calibrating APIC timer ...
Sep 15 01:19:34 box kernel: ..... CPU clock speed is 2405.0089 MHz.
Sep 15 01:19:34 box kernel: ..... host bus clock speed is 200.0423 MHz.
Sep 15 01:19:34 box kernel: checking TSC synchronization across 2 CPUs: passed.
Sep 15 01:19:34 box kernel: Starting migration thread for cpu 0
Sep 15 01:19:34 box kernel: Bringing up 1
Sep 15 01:19:34 box kernel: CPU 1 IS NOW UP!
Sep 15 01:19:34 box kernel: Starting migration thread for cpu 1
Sep 15 01:19:34 box kernel: CPUS done 2
Sep 15 01:19:34 box kernel: NET: Registered protocol family 16
Sep 15 01:19:34 box kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbb20, last 
bus=2
Sep 15 01:19:34 box kernel: PCI: Using configuration type 1
Sep 15 01:19:34 box kernel: mtrr: v2.0 (20020519)
Sep 15 01:19:34 box kernel: ACPI: Subsystem revision 20030813
Sep 15 01:19:34 box kernel: ACPI: Interpreter enabled
Sep 15 01:19:34 box kernel: ACPI: Using IOAPIC for interrupt routing
Sep 15 01:19:34 box kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep 15 01:19:34 box kernel: PCI: Probing PCI hardware (bus 00)
Sep 15 01:19:34 box kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Sep 15 01:19:34 box kernel: Transparent bridge - 0000:00:1e.0
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.HUB0._PRT]
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 
*11 12 14 15)
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 
11 12 14 15)
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 
11 12 14 15)
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 
11 12 14 15)
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 
11 12 14 15, disabled)
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 
11 12 14 15, disabled)
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 
11 12 14 15, disabled)
Sep 15 01:19:34 box kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *9 10 
11 12 14 15)
Sep 15 01:19:34 box kernel: ACPI: Power Resource [PFAN] (off)
Sep 15 01:19:34 box kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> 
IRQ 16 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:00:1f[C] -> 2-16 -> IRQ 16
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> 
IRQ 18 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:00:1f[A] -> 2-18 -> IRQ 18
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> 
IRQ 17 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:00:1f[B] -> 2-17 -> IRQ 17
Sep 15 01:19:34 box kernel: Pin 2-16 already programmed
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> 
IRQ 19 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:00:1d[B] -> 2-19 -> IRQ 19
Sep 15 01:19:34 box kernel: Pin 2-18 already programmed
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> 
IRQ 23 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:00:1d[D] -> 2-23 -> IRQ 23
Sep 15 01:19:34 box kernel: Pin 2-16 already programmed
Sep 15 01:19:34 box kernel: Pin 2-17 already programmed
Sep 15 01:19:34 box kernel: Pin 2-18 already programmed
Sep 15 01:19:34 box kernel: Pin 2-19 already programmed
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> 
IRQ 20 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:02:08[A] -> 2-20 -> IRQ 20
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> 
IRQ 21 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:02:08[B] -> 2-21 -> IRQ 21
Sep 15 01:19:34 box kernel: IOAPIC[0]: Set PCI routing entry (2-22 -> 0xe1 -> 
IRQ 22 Mode:1 Active:1)
Sep 15 01:19:34 box kernel: 00:02:08[C] -> 2-22 -> IRQ 22
Sep 15 01:19:34 box kernel: Pin 2-23 already programmed
Sep 15 01:19:34 box kernel: Pin 2-17 already programmed
Sep 15 01:19:34 box kernel: Pin 2-18 already programmed
Sep 15 01:19:34 box kernel: Pin 2-19 already programmed
Sep 15 01:19:34 box kernel: Pin 2-16 already programmed
Sep 15 01:19:34 box kernel: Pin 2-20 already programmed
Sep 15 01:19:34 box kernel: Pin 2-21 already programmed
Sep 15 01:19:34 box kernel: Pin 2-22 already programmed
Sep 15 01:19:34 box kernel: Pin 2-23 already programmed
Sep 15 01:19:34 box kernel: Pin 2-21 already programmed
Sep 15 01:19:34 box kernel: Pin 2-22 already programmed
Sep 15 01:19:34 box kernel: Pin 2-23 already programmed
Sep 15 01:19:34 box kernel: Pin 2-20 already programmed
Sep 15 01:19:34 box kernel: Pin 2-22 already programmed
Sep 15 01:19:34 box kernel: Pin 2-23 already programmed
Sep 15 01:19:34 box kernel: Pin 2-20 already programmed
Sep 15 01:19:34 box kernel: Pin 2-21 already programmed
Sep 15 01:19:34 box kernel: Pin 2-23 already programmed
Sep 15 01:19:34 box kernel: Pin 2-20 already programmed
Sep 15 01:19:34 box kernel: Pin 2-21 already programmed
Sep 15 01:19:34 box kernel: Pin 2-22 already programmed
Sep 15 01:19:34 box kernel: Pin 2-18 already programmed
Sep 15 01:19:34 box kernel: Pin 2-19 already programmed
Sep 15 01:19:34 box kernel: Pin 2-16 already programmed
Sep 15 01:19:34 box kernel: Pin 2-17 already programmed
Sep 15 01:19:34 box kernel: Pin 2-17 already programmed
Sep 15 01:19:34 box kernel: Pin 2-18 already programmed
Sep 15 01:19:34 box kernel: Pin 2-19 already programmed
Sep 15 01:19:34 box kernel: Pin 2-16 already programmed
Sep 15 01:19:34 box kernel: Pin 2-19 already programmed
Sep 15 01:19:34 box kernel: Pin 2-16 already programmed
Sep 15 01:19:34 box kernel: Pin 2-17 already programmed
Sep 15 01:19:34 box kernel: Pin 2-18 already programmed
Sep 15 01:19:34 box kernel: PCI: Using ACPI for IRQ routing
Sep 15 01:19:34 box kernel: PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi=off'
Sep 15 01:19:34 box kernel: pty: 256 Unix98 ptys configured
Sep 15 01:19:34 box kernel: Machine check exception polling timer started.
Sep 15 01:19:34 box kernel: IA-32 Microcode Update Driver: v1.11 
<tigran@veritas.com>
Sep 15 01:19:34 box kernel: Starting balanced_irq
Sep 15 01:19:34 box kernel: ikconfig 0.6 with /proc/ikconfig
Sep 15 01:19:34 box kernel: highmem bounce pool size: 64 pages
Sep 15 01:19:34 box kernel: NTFS driver 2.1.4 [Flags: R/O].
Sep 15 01:19:34 box kernel: udf: registering filesystem
Sep 15 01:19:34 box kernel: ACPI: Power Button (FF) [PWRF]
Sep 15 01:19:34 box kernel: ACPI: Fan [FAN] (off)
Sep 15 01:19:34 box kernel: ACPI: Processor [CPU0] (supports C1)
Sep 15 01:19:34 box kernel: ACPI: Processor [CPU1] (supports C1)
Sep 15 01:19:34 box kernel: ACPI: Thermal Zone [THRM] (41 C)
Sep 15 01:19:34 box kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ 
sharing disabled
Sep 15 01:19:34 box kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 15 01:19:34 box kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep 15 01:19:34 box kernel: parport0: PC-style at 0x378 (0x778) 
[PCSPP,TRISTATE,EPP]
Sep 15 01:19:34 box kernel: parport0: irq 7 detected
Sep 15 01:19:34 box kernel: parport0: cpp_daisy: aa5500ff(38)
Sep 15 01:19:34 box kernel: parport0: assign_addrs: aa5500ff(38)
Sep 15 01:19:34 box kernel: parport0: cpp_daisy: aa5500ff(38)
Sep 15 01:19:34 box kernel: parport0: assign_addrs: aa5500ff(38)
Sep 15 01:19:34 box kernel: Using anticipatory scheduling io scheduler
Sep 15 01:19:34 box kernel: Floppy drive(s): fd0 is 1.44M
Sep 15 01:19:34 box kernel: FDC 0 is a post-1991 82077
Sep 15 01:19:34 box kernel: loop: loaded (max 8 devices)
Sep 15 01:19:34 box kernel: nbd: registered device at major 43
Sep 15 01:19:34 box kernel: Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Sep 15 01:19:34 box kernel: ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Sep 15 01:19:34 box kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Sep 15 01:19:34 box kernel: ICH5: chipset revision 2
Sep 15 01:19:34 box kernel: ICH5: not 100%% native mode: will probe irqs later
Sep 15 01:19:34 box kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: 
hda:DMA, hdb:pio
Sep 15 01:19:34 box kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: 
hdc:pio, hdd:pio
Sep 15 01:19:34 box kernel: ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
Sep 15 01:19:34 box kernel: ICH5-SATA: chipset revision 2
Sep 15 01:19:34 box kernel: ICH5-SATA: 100%% native mode on irq 18
Sep 15 01:19:34 box kernel:     ide2: BM-DMA at 0xd000-0xd007, BIOS settings: 
hde:DMA, hdf:pio
Sep 15 01:19:34 box kernel:     ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: 
hdg:pio, hdh:pio
Sep 15 01:19:34 box kernel: hde: ST3120026AS, ATA DISK drive
Sep 15 01:19:34 box kernel: hdf: probing with STATUS(0x00) instead of ALTSTATUS
(0x50)
Sep 15 01:19:34 box kernel: hdf: probing with STATUS(0x00) instead of ALTSTATUS
(0x50)
Sep 15 01:19:34 box kernel: ide2 at 0xc000-0xc007,0xc402 on irq 18
Sep 15 01:19:34 box kernel: hde: max request size: 1024KiB
Sep 15 01:19:34 box kernel: hde: 234441648 sectors (120034 MB) w/8192KiB Cache, 
CHS=16383/255/63, UDMA(33)
Sep 15 01:19:34 box kernel:  hde: hde1 hde2 hde3
Sep 15 01:19:34 box kernel: mice: PS/2 mouse device common for all mice
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) 
[0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 47 <- i8042 (return) 
[0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 56 -> i8042 
(parameter) [0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) 
[0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f0 -> i8042 
(parameter) [0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 0f <- i8042 (return) 
[0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) 
[0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 56 -> i8042 
(parameter) [0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: a9 <- i8042 (return) 
[0]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: a4 -> i8042 
(parameter) [1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 5b <- i8042 (return) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 5a -> i8042 
(parameter) [1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: a5 <- i8042 (return) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: a7 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 76 <- i8042 (return) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 56 <- i8042 (return) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 74 -> i8042 
(parameter) [1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 54 -> i8042 
(parameter) [1]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[2]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 56 -> i8042 
(parameter) [2]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[2]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f2 -> i8042 
(parameter) [2]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [4]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 <- i8042 
(interrupt, aux, 12) [5]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[5]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 54 -> i8042 
(parameter) [5]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[6]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 56 -> i8042 
(parameter) [6]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[6]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f2 -> i8042 
(parameter) [6]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [8]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 <- i8042 
(interrupt, aux, 12) [10]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[10]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f6 -> i8042 
(parameter) [10]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [12]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[12]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e8 -> i8042 
(parameter) [12]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [15]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[15]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 -> i8042 
(parameter) [15]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [17]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[17]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e8 -> i8042 
(parameter) [17]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [20]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[20]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 -> i8042 
(parameter) [20]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [22]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[22]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e8 -> i8042 
(parameter) [22]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [25]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[25]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 -> i8042 
(parameter) [25]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [27]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[27]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e8 -> i8042 
(parameter) [27]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [30]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[30]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 -> i8042 
(parameter) [30]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [32]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[32]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e9 -> i8042 
(parameter) [32]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [35]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 <- i8042 
(interrupt, aux, 12) [36]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 <- i8042 
(interrupt, aux, 12) [37]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 64 <- i8042 
(interrupt, aux, 12) [38]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[38]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e8 -> i8042 
(parameter) [38]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [41]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[41]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 03 -> i8042 
(parameter) [41]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [43]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[43]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e6 -> i8042 
(parameter) [43]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [46]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[46]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e6 -> i8042 
(parameter) [46]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [49]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[49]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e6 -> i8042 
(parameter) [49]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [51]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[51]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e9 -> i8042 
(parameter) [51]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [54]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 <- i8042 
(interrupt, aux, 12) [55]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 03 <- i8042 
(interrupt, aux, 12) [56]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 64 <- i8042 
(interrupt, aux, 12) [57]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[57]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e8 -> i8042 
(parameter) [57]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [60]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[60]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 -> i8042 
(parameter) [60]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [62]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[62]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e6 -> i8042 
(parameter) [62]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [65]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[65]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e6 -> i8042 
(parameter) [65]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [67]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[67]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e6 -> i8042 
(parameter) [67]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [70]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[70]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e9 -> i8042 
(parameter) [70]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [72]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 <- i8042 
(interrupt, aux, 12) [73]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 <- i8042 
(interrupt, aux, 12) [74]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 64 <- i8042 
(interrupt, aux, 12) [76]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[76]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [76]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [78]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[78]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: c8 -> i8042 
(parameter) [78]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [81]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[81]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [81]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [83]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[83]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 64 -> i8042 
(parameter) [83]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [86]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[86]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [86]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [88]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[88]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 50 -> i8042 
(parameter) [88]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [91]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[91]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f2 -> i8042 
(parameter) [91]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [93]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 03 <- i8042 
(interrupt, aux, 12) [95]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[95]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [95]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [97]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[97]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: c8 -> i8042 
(parameter) [97]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [100]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[100]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [100]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [102]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[102]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: c8 -> i8042 
(parameter) [102]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [105]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[105]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [105]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [107]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[107]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 50 -> i8042 
(parameter) [107]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [110]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[110]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f2 -> i8042 
(parameter) [110]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [112]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 03 <- i8042 
(interrupt, aux, 12) [114]
Sep 15 01:19:34 box kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[114]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [114]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [116]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[116]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 64 -> i8042 
(parameter) [116]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [119]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[119]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f3 -> i8042 
(parameter) [119]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [121]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[121]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: c8 -> i8042 
(parameter) [121]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [124]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[124]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e8 -> i8042 
(parameter) [124]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [126]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[126]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 03 -> i8042 
(parameter) [126]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [129]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[129]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: e6 -> i8042 
(parameter) [129]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [131]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[131]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: ea -> i8042 
(parameter) [131]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [134]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) 
[134]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f4 -> i8042 
(parameter) [134]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, aux, 12) [136]
Sep 15 01:19:34 box kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[136]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 46 -> i8042 
(parameter) [136]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) 
[137]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 47 -> i8042 
(parameter) [137]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) 
[137]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [140]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: ab <- i8042 
(interrupt, kbd, 1) [144]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 41 <- i8042 
(interrupt, kbd, 1) [148]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) 
[148]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [152]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) 
[152]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [155]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) 
[155]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [161]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) 
[161]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [165]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) 
[165]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [169]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) 
[169]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [172]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) 
[172]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [176]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) 
[176]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: fa <- i8042 
(interrupt, kbd, 1) [179]
Sep 15 01:19:34 box kernel: drivers/input/serio/i8042.c: 41 <- i8042 
(interrupt, kbd, 1) [180]
Sep 15 01:19:34 box kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep 15 01:19:34 box kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 15 01:19:34 box kernel: NET: Registered protocol family 2
Sep 15 01:19:34 box kernel: IP: routing cache hash table of 4096 buckets, 
64Kbytes
Sep 15 01:19:34 box kernel: TCP: Hash tables configured (established 131072 
bind 43690)
Sep 15 01:19:34 box kernel: NET: Registered protocol family 1
Sep 15 01:19:34 box kernel: NET: Registered protocol family 17
Sep 15 01:19:34 box kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Sep 15 01:19:34 box kernel: kjournald starting.  Commit interval 5 seconds
Sep 15 01:19:34 box kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 15 01:19:34 box kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 15 01:19:34 box kernel: Freeing unused kernel memory: 140k freed
Sep 15 01:19:34 box kernel: EXT3 FS on hde3, internal journal
Sep 15 01:19:34 box kernel: rtc: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: rtc: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: usbcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: uhci_hcd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: NTFS volume version 3.1.
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: RRIP_1991A
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: RRIP_1991A
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: RRIP_1991A
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: RRIP_1991A
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: RRIP_1991A
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: RRIP_1991A
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 15 01:19:34 box kernel: ISO 9660 Extensions: RRIP_1991A
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: snd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: snd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: rtc: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: snd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: snd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: snd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: snd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: soundcore: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:19:34 box kernel: snd: version magic '2.6.0-test5 SMP preempt 
PENTIUM4 gcc-2.95' should be '2.6.0-test5 SMP PENTIUM4 gcc-2.95'
Sep 15 01:20:47 box kernel: drivers/input/serio/i8042.c: 41 <- i8042 
(interrupt, kbd, 1) [80466]
Sep 15 01:20:47 box kernel: drivers/input/serio/i8042.c: c1 <- i8042 
(interrupt, kbd, 1) [80561]
Sep 15 01:20:48 box kernel: drivers/input/serio/i8042.c: 16 <- i8042 
(interrupt, kbd, 1) [81692]
Sep 15 01:20:48 box kernel: drivers/input/serio/i8042.c: 96 <- i8042 
(interrupt, kbd, 1) [81772]
Sep 15 01:20:48 box kernel: drivers/input/serio/i8042.c: 1f <- i8042 
(interrupt, kbd, 1) [82032]
Sep 15 01:20:49 box kernel: drivers/input/serio/i8042.c: 9f <- i8042 
(interrupt, kbd, 1) [82113]
Sep 15 01:20:49 box kernel: drivers/input/serio/i8042.c: 30 <- i8042 
(interrupt, kbd, 1) [82347]
Sep 15 01:20:49 box kernel: drivers/input/serio/i8042.c: b0 <- i8042 
(interrupt, kbd, 1) [82443]
Sep 15 01:20:49 box kernel: drivers/input/serio/i8042.c: 20 <- i8042 
(interrupt, kbd, 1) [82661]
Sep 15 01:20:49 box kernel: drivers/input/serio/i8042.c: a0 <- i8042 
(interrupt, kbd, 1) [82757]
Sep 15 01:20:49 box kernel: drivers/input/serio/i8042.c: 12 <- i8042 
(interrupt, kbd, 1) [83018]
Sep 15 01:20:50 box kernel: drivers/input/serio/i8042.c: 92 <- i8042 
(interrupt, kbd, 1) [83098]
Sep 15 01:20:50 box kernel: drivers/input/serio/i8042.c: 2f <- i8042 
(interrupt, kbd, 1) [83304]
Sep 15 01:20:50 box kernel: drivers/input/serio/i8042.c: af <- i8042 
(interrupt, kbd, 1) [83385]
Sep 15 01:20:50 box kernel: drivers/input/serio/i8042.c: 21 <- i8042 
(interrupt, kbd, 1) [83675]
Sep 15 01:20:50 box kernel: drivers/input/serio/i8042.c: ab <- i8042 
(interrupt, kbd, 1) [83737]
Sep 15 01:20:50 box kernel: atkbd.c: Unknown key (set 2, scancode 0xab, on 
isa0060/serio0) pressed.
Sep 15 01:20:51 box kernel: drivers/input/serio/i8042.c: 1f <- i8042 
(interrupt, kbd, 1) [84426]
Sep 15 01:20:51 box kernel: drivers/input/serio/i8042.c: 9f <- i8042 
(interrupt, kbd, 1) [84507]






