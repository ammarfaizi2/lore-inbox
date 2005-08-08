Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVHHWVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVHHWVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVHHWVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:21:53 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:22451
	"HELO linuxace.com") by vger.kernel.org with SMTP id S932287AbVHHWVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:21:52 -0400
Date: Mon, 8 Aug 2005 15:21:46 -0700
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12->2.6.13-rc6 SMT changes -- intentional?
Message-ID: <20050808222146.GA7123@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just booted a box on 2.6.13-rc6, and noticed that it now only reports
a single processor, whereas on 2.6.12.4 it reports two.  While there
is only one physical processor, I wonder if this change was intentional,
since I can't find anything in the changelog about SMT changes.

Below is dmesg output from each kernel.

Phil

Linux version 2.6.12.4 (root@) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 SMP Mon Aug 8 17:13:40 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f686c00 (usable)
 BIOS-e820: 000000003f686c00 - 000000003f688c00 (ACPI NVS)
 BIOS-e820: 000000003f688c00 - 000000003f68ac00 (ACPI data)
 BIOS-e820: 000000003f68ac00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 259718
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 30342 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fec00
ACPI: RSDT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcc04
ACPI: FADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcc44
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffd3468
ACPI: MADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fccb8
ACPI: BOOT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcd2a
ACPI: ASF! (v016 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcd52
ACPI: MCFG (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcdb9
ACPI: HPET (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcdf7
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro nofirewire root=/dev/sda9 console=tty0 console=ttyS0,9600 panic=1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c034a000 soft=c0348000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2994.062 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1026420k/1038872k available (1635k kernel code, 11624k reserved, 486k data, 188k init, 121368k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5898.24 BogoMIPS (lpj=2949120)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00100000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c034b000 soft=c0349000
Initializing CPU#1
Calibrating delay loop... 5980.16 BogoMIPS (lpj=2990080)
CPU: After generic identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00100000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Total of 2 processors activated (11878.40 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
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

********************************************
********************************************
********************************************

Linux version 2.6.13-rc6 (root@) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 SMP Mon Aug 8 17:43:09 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f686c00 (usable)
 BIOS-e820: 000000003f686c00 - 000000003f688c00 (ACPI NVS)
 BIOS-e820: 000000003f688c00 - 000000003f68ac00 (ACPI data)
 BIOS-e820: 000000003f68ac00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 259718
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 30342 pages, LIFO batch:15
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: Opti GX280   APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
I/O APIC #8 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 40000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro nofirewire root=/dev/sda9 console=tty0 console=ttyS0,9600 panic=1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0324000 soft=c0322000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2993.183 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1026576k/1038872k available (1542k kernel code, 11468k reserved, 447k data, 168k init, 121368k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5995.45 BogoMIPS (lpj=11990917)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00100000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Total of 1 processors activated (5995.45 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
Brought up 1 CPUs

