Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbTLFLfr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTLFLfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:35:24 -0500
Received: from may.nosdns.com ([207.44.240.96]:44428 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S265094AbTLFLU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:20:56 -0500
Date: Sat, 6 Dec 2003 04:19:18 -0700
From: "Russell \"Elik\" Rademacher" <elik@webspires.com>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: "Rusell \"Elik\" Rademacher" <elik@webspires.com>
X-Priority: 3 (Normal)
Message-ID: <119145131687.20031206041918@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: Hyperthreading Patch Results
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  Okay folks.  I have installed it on 28 production servers with that patch contributed by William Lee Irwin III including Dell Servers and 2 Compaq servers among other types of hardware with 3ware, MPT SCSI, straight IDE, MylexRaid in the mix.  I have reported no problems with them and they all correctly reported the HyperThreading CPUs.  Previous versions since 2.4.21 have problems reporting the Hyperthreaded Dual Xeons and report it as 2 CPUs instead of 4.

  So..I recommend this patch being pushed to 2.4.x tree for inclusion.

Here is a snippet of one of the servers that is made possible with the patch: 

Linux version 2.4.23-ow1 (root@tiamat.nosdns.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #2 SMP Sat Dec 6 03:34:00 CST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fffec00 (ACPI data)
 BIOS-e820: 000000007fffec00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
ACPI: RSDP (v000 DELL                                      ) @ 0x000fdc60
ACPI: RSDT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdc74
ACPI: FADT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdca4
ACPI: MADT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdd18
ACPI: SPCR (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x000fdda0
ACPI: DSDT (v001 DELL   PE1600SC 0x00000001 MSFT 0x0100000a) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 4
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, IRQ 0-15
ACPI: IOAPIC (id[0x05] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 5
IOAPIC[1]: apic_id 5, version 17, address 0xfec01000, IRQ 16-31
ACPI: IOAPIC (id[0x06] address[0xfec02000] global_irq_base[0x20])
IOAPIC[2]: Assigned apic_id 6
IOAPIC[2]: apic_id 6, version 17, address 0xfec02000, IRQ 32-47
ACPI BALANCE SET
Using ACPI (MADT) for SMP configuration information
Kernel command line: auto BOOT_IMAGE=linux ro root=803 BOOT_FILE=/boot/vmlinuz-2.4.23-ow1
Initializing CPU#0
Detected 1993.397 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 2069356k/2097088k available (1653k kernel code, 27348k reserved, 374k data, 312k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.00GHz stepping 07
per-CPU timeslice cutoff: 1462.63 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3984.58 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 2.00GHz stepping 07
Booting processor 2/2 eip 3000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3984.58 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU2: Intel(R) Xeon(TM) CPU 2.00GHz stepping 07
Booting processor 3/3 eip 3000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3984.58 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU3: Intel(R) Xeon(TM) CPU 2.00GHz stepping 07
Total of 4 processors activated (15925.24 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-2, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15, 6-0, 6-1, 6-2, 6-3, 6-4, 6-5, 6-6, 6-7, 6-8, 6-9, 6-10, 6-11, 6-12, 6-13, 6-14, 6-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1993.4366 MHz.
..... host bus clock speed is 132.8955 MHz.
cpu: 0, clocks: 1328955, slice: 265791
CPU0<T0:1328944,T1:1063152,D:1,S:265791,C:1328955>
cpu: 1, clocks: 1328955, slice: 265791
cpu: 3, clocks: 1328955, slice: 265791
cpu: 2, clocks: 1328955, slice: 265791
CPU1<T0:1328944,T1:797360,D:2,S:265791,C:1328955>
CPU3<T0:1328944,T1:265776,D:4,S:265791,C:1328955>
CPU2<T0:1328944,T1:531568,D:3,S:265791,C:1328955>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfc6ee, last bus=2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)

<Snip>  No need to post everything. :)


-- 
Best regards,
Russell "Elik" Rademacher
Freelance Remote System Adminstrator/Tech Support    

