Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSILP3a>; Thu, 12 Sep 2002 11:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSILP3a>; Thu, 12 Sep 2002 11:29:30 -0400
Received: from mail.wp-sa.pl ([212.77.102.105]:49556 "EHLO mail.wp-sa.pl")
	by vger.kernel.org with ESMTP id <S316576AbSILP3Z>;
	Thu, 12 Sep 2002 11:29:25 -0400
Date: Thu, 12 Sep 2002 17:33:28 +0200
From: Mariusz Zielinski <mzielinski@wp-sa.pl>
Subject: unexpected IO-APIC on IBM xSeries 440
To: linux-kernel@vger.kernel.org
Reply-to: mzielinski@wp-sa.pl
Message-id: <200209121733.28871.mzielinski@wp-sa.pl>
Organization: Wirtualna Polska S.A.
MIME-version: 1.0
X-Mailer: KMail [version 1.4]
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
as instructed I'm making contact (attached dmesg). IBM claims that machine
is supported under linux (RedHat Advanced Server 2.1) but I couldn't find any 
patches. Is it possible that RedHat is hiding some patches from linux 
community? :)

The problem is that /proc/cpuinfo shows at most 4 processors (depending on 
kernel version). Dmesg shows many  "APIC error on CPUx: 00(80)" errors.
I can provide you with further details (make some tests) if needed. 

Kernel is preemptible and is compiled with bigmem and acpi enabled.

Linux version 2.5.34 (root@levi) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #2 SMP czw wrz 12 16:32:16 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dffb6fc0 (usable)
 BIOS-e820: 00000000dffb6fc0 - 00000000dffbf800 (ACPI data)
 BIOS-e820: 00000000dffbf800 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
3712MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009dd40
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org 
if you experience SMP problems!
On node 0 totalpages: 1179648
  DMA zone: 4096 pages
  Normal zone: 225280 pages
  HighMem zone: 950272 pages
ACPI: RSDP (v000 IBM                        ) @ 0x000fdba0
ACPI: RSDT (v001 IBM    SERVIGIL 00000.04096) @ 0xdffbf780
ACPI: FADT (v001 IBM    SERVIGIL 00000.04096) @ 0xdffbf700
ACPI: MADT (v001 IBM    SERVIGIL 00000.04096) @ 0xdffbf600
ACPI: SRAT (v001 IBM    SERVIGIL 00000.04096) @ 0xdffbf4c0
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x10] enabled)
Processor #16 invalid (max 16)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
Processor #18 invalid (max 16)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x20] enabled)
Processor #32 invalid (max 16)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x22] enabled)
Processor #34 invalid (max 16)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x30] enabled)
Processor #48 invalid (max 16)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x32] enabled)
Processor #50 invalid (max 16)
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 14
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, IRQ 0-50
ACPI: IOAPIC (id[0x0d] address[0xfec01000] global_irq_base[0x33])
IOAPIC[1]: Assigned apic_id 13
IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, IRQ 51-101
ACPI: INT_SRC_OVR (bus[0] irq[0x8] global_irq[0x8] polarity[0x3] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x24] polarity[0x0] 
trigger[0x0])
Using ACPI (MADT) for SMP configuration information
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Kernel command line: auto BOOT_IMAGE=linux-2.5 root=802 
BOOT_FILE=/boot/linux-2.5
Initializing CPU#0
Detected 1397.813 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2703.36 BogoMIPS
Memory: 4139296k/4718592k available (1788k kernel code, 54316k reserved, 817k 
data, 120k init, 3276504k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal LVT vector (0xf0) already installed
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel Pentium 4 (Unknown) stepping 01
per-CPU timeslice cutoff: 731.82 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
mtrr: SMP support incomplete for this vendor
Calibrating delay loop... 2785.28 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel Pentium 4 (Unknown) stepping 01
Total of 2 processors activated (5488.64 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 14-0, 14-2, 14-16, 14-17, 14-18, 14-19, 14-20, 14-21, 
14-22, 14-23, 14-24, 14-25, 14-26, 14-27, 14-28, 14-29, 14-30, 14-31, 14-32, 
14-33, 14-34,
14-35, 14-37, 14-38, 14-39, 14-40, 14-41, 14-42, 14-43, 14-44, 14-45, 14-46, 
14-47, 14-48, 14-49, 14-50, 13-0, 13-1, 13-2, 13-3, 13-4, 13-5, 13-6, 13-7, 
13-8, 13-9, 13
-10, 13-11, 13-12, 13-13, 13-14, 13-15, 13-16, 13-17, 13-18, 13-19, 13-20, 
13-21, 13-22, 13-23, 13-24, 13-25, 13-26, 13-27, 13-28, 13-29, 13-30, 13-31, 
13-32, 13-33, 1
3-34, 13-35, 13-36, 13-37, 13-38, 13-39, 13-40, 13-41, 13-42, 13-43, 13-44, 
13-45, 13-46, 13-47, 13-48, 13-49, 13-50 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #14 registers: 51.
number of IO-APIC #13 registers: 51.
testing the IO APIC.......................

IO APIC #14......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.... register #01: 00320011
.......     : max redirection entries: 0032
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   1   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
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
 18 000 00  1    0    0   0   0    0    0    00
 19 000 00  1    0    0   0   0    0    0    00
 1a 000 00  1    0    0   0   0    0    0    00
 1b 000 00  1    0    0   0   0    0    0    00
 1c 000 00  1    0    0   0   0    0    0    00
 1d 000 00  1    0    0   0   0    0    0    00
 1e 000 00  1    0    0   0   0    0    0    00
 1f 000 00  1    0    0   0   0    0    0    00
 20 000 00  1    0    0   0   0    0    0    00
 21 000 00  1    0    0   0   0    0    0    00
 22 000 00  1    0    0   0   0    0    0    00
 23 000 00  1    0    0   0   0    0    0    00
 24 001 01  0    0    0   0   0    1    1    71
 25 000 00  1    0    0   0   0    0    0    00
 26 000 00  1    0    0   0   0    0    0    00
 27 000 00  1    0    0   0   0    0    0    00
 28 000 00  1    0    0   0   0    0    0    00
 29 000 00  1    0    0   0   0    0    0    00
 2a 000 00  1    0    0   0   0    0    0    00
 2b 000 00  1    0    0   0   0    0    0    00
 2c 000 00  1    0    0   0   0    0    0    00
 2d 000 00  1    0    0   0   0    0    0    00
 2e 000 00  1    0    0   0   0    0    0    00
 2f 000 00  1    0    0   0   0    0    0    00
 30 000 00  1    0    0   0   0    0    0    00
 31 000 00  1    0    0   0   0    0    0    00
 32 000 00  1    0    0   0   0    0    0    00

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.... register #01: 00320011
.......     : max redirection entries: 0032
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
 18 000 00  1    0    0   0   0    0    0    00
 19 000 00  1    0    0   0   0    0    0    00
 1a 000 00  1    0    0   0   0    0    0    00
 1b 000 00  1    0    0   0   0    0    0    00
 1c 000 00  1    0    0   0   0    0    0    00
 1d 000 00  1    0    0   0   0    0    0    00
 1e 000 00  1    0    0   0   0    0    0    00
 1f 000 00  1    0    0   0   0    0    0    00
 20 000 00  1    0    0   0   0    0    0    00
 21 000 00  1    0    0   0   0    0    0    00
 22 000 00  1    0    0   0   0    0    0    00
 23 000 00  1    0    0   0   0    0    0    00
 24 000 00  1    0    0   0   0    0    0    00
 25 000 00  1    0    0   0   0    0    0    00
 26 000 00  1    0    0   0   0    0    0    00
 27 000 00  1    0    0   0   0    0    0    00
 28 000 00  1    0    0   0   0    0    0    00
 29 000 00  1    0    0   0   0    0    0    00
 2a 000 00  1    0    0   0   0    0    0    00
 2b 000 00  1    0    0   0   0    0    0    00
 2c 000 00  1    0    0   0   0    0    0    00
 2d 000 00  1    0    0   0   0    0    0    00
 2e 000 00  1    0    0   0   0    0    0    00
 2f 000 00  1    0    0   0   0    0    0    00
 30 000 00  1    0    0   0   0    0    0    00
 31 000 00  1    0    0   0   0    0    0    00
 32 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:36
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1396.0951 MHz.
..... host bus clock speed is 99.0782 MHz.
cpu: 0, clocks: 99782, slice: 3023
CPU0<T0:99776,T1:96752,D:1,S:3023,C:99782>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 99782, slice: 3023
CPU1<T0:99776,T1:93728,D:2,S:3023,C:99782>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd30d, last bus=11
PCI: Using configuration type 1
ACPI: Subsystem revision 20020829
APIC error on CPU0: 00(80)
APIC error on CPU1: 00(80)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (00:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (00:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
ACPI: PCI Root Bridge [PCI5] (00:05)
PCI: Probing PCI hardware (bus 05)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI5._PRT]
ACPI: PCI Root Bridge [PCI7] (00:07)
PCI: Probing PCI hardware (bus 07)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI7._PRT]
ACPI: PCI Root Bridge [PCI9] (00:09)
PCI: Probing PCI hardware (bus 09)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI9._PRT]
ACPI: PCI Interrupt Link [LVIA] (IRQs *9)
ACPI: PCI Interrupt Link [LVIB] (IRQs *10)
ACPI: PCI Interrupt Link [LVIC] (IRQs *3)
ACPI: PCI Interrupt Link [LVID] (IRQs *5)
ACPI: PCI Interrupt Link [LVUS] (IRQs *7)
ACPI: PCI Interrupt Link [LHS1] (IRQs *5)
ACPI: PCI Interrupt Link [LHS2] (IRQs *5)
ACPI: PCI Interrupt Link [LHS3] (IRQs *5)
ACPI: PCI Interrupt Link [LHS4] (IRQs *10)
ACPI: PCI Interrupt Link [LHS5] (IRQs *11)
ACPI: PCI Interrupt Link [LHS6] (IRQs *15)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
IOAPIC[0]: Set PCI routing entry (14-39 -> 0xa9 -> IRQ 39)
00:00:03[A] -> 14-39 -> vector 0xa9 -> IRQ 39
IOAPIC[0]: Set PCI routing entry (14-16 -> 0xb1 -> IRQ 16)
00:00:04[A] -> 14-16 -> vector 0xb1 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (14-17 -> 0xb9 -> IRQ 17)
00:00:04[B] -> 14-17 -> vector 0xb9 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (14-47 -> 0xc1 -> IRQ 47)
00:00:05[D] -> 14-47 -> vector 0xc1 -> IRQ 47
IOAPIC[0]: Set PCI routing entry (14-40 -> 0xc9 -> IRQ 40)
00:01:03[A] -> 14-40 -> vector 0xc9 -> IRQ 40
IOAPIC[0]: Set PCI routing entry (14-41 -> 0xd1 -> IRQ 41)
00:01:03[B] -> 14-41 -> vector 0xd1 -> IRQ 41
IOAPIC[0]: Set PCI routing entry (14-42 -> 0xd9 -> IRQ 42)
00:01:04[A] -> 14-42 -> vector 0xd9 -> IRQ 42
IOAPIC[1]: Set PCI routing entry (13-0 -> 0xe1 -> IRQ 51)
00:02:01[A] -> 13-0 -> vector 0xe1 -> IRQ 51
IOAPIC[1]: Set PCI routing entry (13-1 -> 0xe9 -> IRQ 52)
00:02:01[B] -> 13-1 -> vector 0xe9 -> IRQ 52
IOAPIC[1]: Set PCI routing entry (13-2 -> 0x32 -> IRQ 53)
00:02:01[C] -> 13-2 -> vector 0x32 -> IRQ 53
IOAPIC[1]: Set PCI routing entry (13-3 -> 0x3a -> IRQ 54)
00:02:01[D] -> 13-3 -> vector 0x3a -> IRQ 54
IOAPIC[1]: Set PCI routing entry (13-4 -> 0x42 -> IRQ 55)
00:02:02[A] -> 13-4 -> vector 0x42 -> IRQ 55
IOAPIC[1]: Set PCI routing entry (13-5 -> 0x4a -> IRQ 56)
00:02:02[B] -> 13-5 -> vector 0x4a -> IRQ 56
IOAPIC[1]: Set PCI routing entry (13-6 -> 0x52 -> IRQ 57)
00:02:02[C] -> 13-6 -> vector 0x52 -> IRQ 57
IOAPIC[1]: Set PCI routing entry (13-7 -> 0x5a -> IRQ 58)
00:02:02[D] -> 13-7 -> vector 0x5a -> IRQ 58
IOAPIC[1]: Set PCI routing entry (13-20 -> 0x62 -> IRQ 71)
00:05:04[A] -> 13-20 -> vector 0x62 -> IRQ 71
IOAPIC[1]: Set PCI routing entry (13-21 -> 0x6a -> IRQ 72)
00:05:04[B] -> 13-21 -> vector 0x6a -> IRQ 72
IOAPIC[1]: Set PCI routing entry (13-22 -> 0x72 -> IRQ 73)
00:05:04[C] -> 13-22 -> vector 0x72 -> IRQ 73
IOAPIC[1]: Set PCI routing entry (13-23 -> 0x7a -> IRQ 74)
00:05:04[D] -> 13-23 -> vector 0x7a -> IRQ 74
IOAPIC[1]: Set PCI routing entry (13-16 -> 0x82 -> IRQ 67)
00:07:03[A] -> 13-16 -> vector 0x82 -> IRQ 67
IOAPIC[1]: Set PCI routing entry (13-17 -> 0x8a -> IRQ 68)
00:07:03[B] -> 13-17 -> vector 0x8a -> IRQ 68
IOAPIC[1]: Set PCI routing entry (13-18 -> 0x92 -> IRQ 69)
00:07:03[C] -> 13-18 -> vector 0x92 -> IRQ 69
IOAPIC[1]: Set PCI routing entry (13-19 -> 0x9a -> IRQ 70)
00:07:03[D] -> 13-19 -> vector 0x9a -> IRQ 70
IOAPIC[1]: Set PCI routing entry (13-8 -> 0xa2 -> IRQ 59)
00:09:01[A] -> 13-8 -> vector 0xa2 -> IRQ 59
IOAPIC[1]: Set PCI routing entry (13-9 -> 0xaa -> IRQ 60)
00:09:01[B] -> 13-9 -> vector 0xaa -> IRQ 60
IOAPIC[1]: Set PCI routing entry (13-10 -> 0xb2 -> IRQ 61)
00:09:01[C] -> 13-10 -> vector 0xb2 -> IRQ 61
IOAPIC[1]: Set PCI routing entry (13-11 -> 0xba -> IRQ 62)
00:09:01[D] -> 13-11 -> vector 0xba -> IRQ 62
IOAPIC[1]: Set PCI routing entry (13-12 -> 0xc2 -> IRQ 63)
00:09:02[A] -> 13-12 -> vector 0xc2 -> IRQ 63
IOAPIC[1]: Set PCI routing entry (13-13 -> 0xca -> IRQ 64)
00:09:02[B] -> 13-13 -> vector 0xca -> IRQ 64
IOAPIC[1]: Set PCI routing entry (13-14 -> 0xd2 -> IRQ 65)
00:09:02[C] -> 13-14 -> vector 0xd2 -> IRQ 65
IOAPIC[1]: Set PCI routing entry (13-15 -> 0xda -> IRQ 66)
00:09:02[D] -> 13-15 -> vector 0xda -> IRQ 66
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi'
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
aio_setup: sizeof(struct page) = 44
Journalled Block Device driver loaded
Capability LSM initialized
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:05.2, from 7 to 15
PCI: Via IRQ fixup for 00:05.3, from 7 to 15
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CP07] (supports C1)
ACPI: Processor [CP06] (supports C1)
ACPI: Processor [CP05] (supports C1)
ACPI: Processor [CP04] (supports C1)
ACPI: Processor [CP03] (supports C1)
ACPI: Processor [CP02] (supports C1)
ACPI: Processor [CP01] (supports C1)
ACPI: Processor [CP00] (supports C1)

-- 
Mariusz Zielinski
