Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTKSLVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 06:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbTKSLVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 06:21:41 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:12161 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264016AbTKSLVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 06:21:24 -0500
Date: Wed, 19 Nov 2003 12:21:22 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Losing too many ticks! TSC cannot be used as time source...
Message-ID: <20031119112122.GA31451@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  today morning my kernel (2.6.0-test9-something) said that
TSC became unusable. There are no other messages around this
time in the log. It could be thermal throttling, but it should
print some message when X86_MCE_P4THERMAL is enabled, yes?
It happened after 17hrs 56min of uptime. System never produced
this message before. 

  Are there some more information I could supply, or should I
simple live with fact that TSC stopped working on my P4 today
morning?
					Thanks,
						Petr Vandrovec


Nov 18 14:44:49 vana ntpdate[1055]: step time server 195.113.144.201 offset -0.499475 sec
Nov 18 14:44:49 vana ntpd[1058]: ntpd 4.1.2a@1:4.1.2a-2 Tue Nov 11 11:33:28 UTC 2003 (2)
Nov 18 14:44:49 vana ntpd[1058]: precision = 13 usec
Nov 18 14:44:49 vana ntpd[1058]: kernel time discipline status 0040
Nov 18 14:44:49 vana ntpd[1058]: frequency initialized 4.967 from /var/lib/ntp/ntp.drift
Nov 18 14:48:13 vana ntpd[1058]: kernel time discipline status change 41
Nov 18 17:37:18 vana ntpd[1058]: synchronisation lost
Nov 19 08:40:27 vana kernel: Losing too many ticks!
Nov 19 08:40:27 vana kernel: TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Nov 19 08:40:27 vana kernel: Falling back to a sane timesource.
Nov 19 09:03:40 vana ntpd[1058]: time reset 0.348040 s
Nov 19 09:03:40 vana ntpd[1058]: synchronisation lost
Nov 19 09:54:11 vana ntpd[1058]: time reset -0.261271 s
Nov 19 09:54:11 vana ntpd[1058]: synchronisation lost


x86info v1.12b.  Dave Jones 2001-2003
Feedback to <davej@redhat.com>.

Found 1 CPU
--------------------------------------------------------------------------
eax in: 0x00000000, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 0x00000001, eax = 00000f12 ebx = 00010808 ecx = 00000000 edx = 3febfbff
eax in: 0x00000002, eax = 665b5001 ebx = 00000000 ecx = 00000000 edx = 007a7040

eax in: 0x80000000, eax = 80000004 ebx = 00000000 ecx = 00000000 edx = 00000000
eax in: 0x80000001, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
eax in: 0x80000002, eax = 20202020 ebx = 20202020 ecx = 20202020 edx = 6e492020
eax in: 0x80000003, eax = 286c6574 ebx = 50202952 ecx = 69746e65 edx = 52286d75
eax in: 0x80000004, eax = 20342029 ebx = 20555043 ecx = 30362e31 edx = 007a4847

Family: 15 Model: 1 Stepping: 2 Type: 0 Brand: 8
CPU Model: Pentium 4 (Willamette) [D0] Original OEM
Processor name string: Intel(R) Pentium(R) 4 CPU 1.60GHz

Feature flags:
	Onboard FPU
	Virtual Mode Extensions
	Debugging Extensions
	Page Size Extensions
	Time Stamp Counter
	Model-Specific Registers
	Physical Address Extensions
	Machine Check Architecture
	CMPXCHG8 instruction
	Onboard APIC
	SYSENTER/SYSEXIT
	Memory Type Range Registers
	Page Global Enable
	Machine Check Architecture
	CMOV instruction
	Page Attribute Table
	36-bit PSEs
	CLFLUSH instruction
	Debug Trace Store
	ACPI via MSR
	MMX support
	FXSAVE and FXRESTORE instructions
	SSE support
	SSE2 support
	CPU self snoop
	Hyper-Threading
	Automatic clock Control

Extended feature flags:

Pentium 4 specific MSRs:
IA32_PLATFORM_ID=0008000000000000
System bus in order queue depth=12
MSR_EBC_FREQUENCY_ID=000000008201ff00
IA32_BIOS_SIGN_ID=0000002800000000
Processor serial number is enabled
Fast strings are enabled
x87 FPU Fopcode compatability mode is disabled
Thermal monitor is enabled
Split lock is enabled

Instruction TLB: 4K, 2MB or 4MB pages, fully associative, 64 entries.
Data TLB: 4KB or 4MB pages, fully associative, 64 entries.
L1 Data cache:
	Size: 8KB	Sectored, 4-way associative.
	line size=64 bytes.
No level 2 cache or no level 3 cache if valid 2nd level cache.
Instruction trace cache:
	Size: 12K uOps	8-way associative.
L2 unified cache:
	Size: 256KB	Sectored, 8-way associative.
	line size=64 bytes.

Number of reporting banks : 4

Number of extended MC registers : 12


Bank: 0 (0x400)
MC0CTL:    00000000 00000000 00000000 00000000
           00000000 00000000 11111111 11111111
MC0STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC0ADDR:   00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000

Bank: 1 (0x404)
MC1CTL:    00000000 00000000 00000000 00000000
           00000000 00000011 10000000 00000000
MC1STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC1ADDR:   00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000

Bank: 2 (0x408)
MC2CTL:    00000000 00000000 00000000 00000000
           00000000 00000000 00000000 10000000
MC2STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC2ADDR:   Couldn't read MSR 0x40a

Bank: 3 (0x40c)
MC3CTL:    00000000 00000000 00000000 00000000
           00000000 00000000 00000000 01111110
MC3STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC3ADDR:   00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000

Number of logical processors supported within the physical package: 0

Microcode version: 0x0000000000000028

Connector type: Socket423 (PGA423 Socket)

Datasheet: http://developer.intel.com/design/pentium4/datashts/24919805.pdf
Errata: http://developer.intel.com/design/pentium4/specupdt/24919928.pdf

MTRR registers:
MTRRcap (0xfe): 0x0000000000000508
MTRRphysBase0 (0x200): 0x0000000000000006
MTRRphysMask0 (0x201): 0x0000000fe0000800
MTRRphysBase1 (0x202): 0x00000000da000001
MTRRphysMask1 (0x203): 0x0000000ffe000800
MTRRphysBase2 (0x204): 0x00000000e0000001
MTRRphysMask2 (0x205): 0x0000000ff0000800
MTRRphysBase3 (0x206): 0x0000000000000000
MTRRphysMask3 (0x207): 0x0000000000000000
MTRRphysBase4 (0x208): 0x0000000000000000
MTRRphysMask4 (0x209): 0x0000000000000000
MTRRphysBase5 (0x20a): 0x0000000000000000
MTRRphysMask5 (0x20b): 0x0000000000000000
MTRRphysBase6 (0x20c): 0x0000000000000000
MTRRphysMask6 (0x20d): 0x0000000000000000
MTRRphysBase7 (0x20e): 0x0000000000000000
MTRRphysMask7 (0x20f): 0x0000000000000000
MTRRfix64K_00000 (0x250): 0x0606060606060606
MTRRfix16K_80000 (0x258): 0x0606060606060606
MTRRfix16K_A0000 (0x259): 0x0000000000000000
MTRRfix4K_C8000 (0x269): 0x0505050505050505
MTRRfix4K_D0000 0x26a: 0x0000000000000000
MTRRfix4K_D8000 0x26b: 0x0000000000000000
MTRRfix4K_E0000 0x26c: 0x0505050505050505
MTRRfix4K_E8000 0x26d: 0x0505050505050505
MTRRfix4K_F0000 0x26e: 0x0505050505050505
MTRRfix4K_F8000 0x26f: 0x0505050505050505
MTRRdefType (0x2ff): 0x0000000000000c00


1.6Ghz processor (estimate).


Linux version 2.6.0-test9-c1431 (root@vana) (gcc version 3.3.2 (Debian)) #2 Wed Nov 12 16:45:51 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
 BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131008
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126912 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000ff980
ACPI: RSDT (v001 D845PT BG84510A 0x20020717 MSFT 0x00001011) @ 0x1fff0000
ACPI: FADT (v001 D845PT PT84510A 0x20020717 MSFT 0x00001011) @ 0x1fff1000
ACPI: MADT (v001 D845PT PT84510A 0x20020717 MSFT 0x00001011) @ 0x1ffe36fd
ACPI: DSDT (v001 D845PT PT84510A 0x00000003 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=301 ramdisk=0 video=matrox:vesa:0x117,fv:100,lower:1 video=matroxfb:vesa:0x117,fv:100,lower:1 video=scrollback:0 nmi_watchdog=2 psmouse_noext=1
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1595.660 MHz processor.
Console: colour VGA+ 80x25
Memory: 513560k/524032k available (2523k kernel code, 9736k reserved, 952k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3145.72 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 3febfbf7 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1594.0663 MHz.
..... host bus clock speed is 99.0666 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
SCSI subsystem initialized
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb1 -> IRQ 23 Mode:1 Active:1)
00:00:1f[C] -> 2-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:1f[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:01[A] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
00:02:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:02:09[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:02:09[B] -> 2-22 -> IRQ 22
Pin 2-23 already programmed
Pin 2-17 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-17 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-17 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-17 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xe1 -> IRQ 18 Mode:1 Active:1)
00:02:01[A] -> 2-18 -> IRQ 18
Pin 2-21 already programmed
Pin 2-22 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x16bpp (virtual: 1024x8190)
matroxfb: framebuffer at 0xDA000000, mapped to 0xe0810000, size 33554432
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
i810 TCO timer init: failed to reset NO_REBOOT flag, reboot disabled by hardware
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-00CRA0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA MK6409MAV, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: max request size: 128KiB
hdc: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)
 /dev/ide/host0/bus1/target0/lun0: p1
matroxfb_crtc2: secondary head of fb0 was registered as fb1
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 4
BIOS EDD facility v0.10 2003-Oct-11, 2 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 168k freed
Adding 1024120k swap on /dev/ide/host0/bus0/target0/lun0/part2.  Priority:-1 extents:1
quotaon: numerical sysctl 5 16 8 is obsolete.
e100: eth0 NIC Link is Up 100 Mbps Full duplex
