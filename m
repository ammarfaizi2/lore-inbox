Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423418AbWJZGso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423418AbWJZGso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 02:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423453AbWJZGso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 02:48:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:56527 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423418AbWJZGsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 02:48:43 -0400
X-Authenticated: #14349625
Subject: [2.6.18-rt7] BUG: time warp detected!
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 07:20:10 +0000
Message-Id: <1161847210.32585.14.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

$subject happened on my single P4/HT box sometime after resume from
disk.  Hohum activity:  I had just read lkml and was retrieving latest
glibc snapshot when I noticed the trace.  I also noticed that the kernel
decided to use pit instead of tsc.

Linux version 2.6.18-rt7-smp (root@Homer) (gcc version 4.1.2 20060920 (prerelease) (SUSE Linux)) #184 SMP PREEMPT Sun Oct 22 05:57:53 Local time zone must be set
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
1023MB LOWMEM available.
found SMP MP-table at 000f5320
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 258032 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f6cc0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7200
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 2992.611 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists.  Total pages: 262128
Kernel command line: root=/dev/hdc3 vga=0x314 resume=/dev/hdc2 console=ttyS0,115200n8 console=tty profile=1
kernel profiling enabled (shift: 1)
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
Clock event device pit configured with caps set: 07
CPU 0 irqstacks, hard=b15cd000 soft=b15c5000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1015040k/1048512k available (3773k kernel code, 33084k reserved, 1289k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5986.97 BogoMIPS (lpj=2993488)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=b15ce000 soft=b15c6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5984.19 BogoMIPS (lpj=2992096)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Total of 2 processors activated (11971.16 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
checking TSC synchronization across 2 CPUs: passed.
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
Brought up 2 CPUs
...
Starting balanced_irq
Using IPI No-Shortcut mode
Time: pit clocksource has been installed.
...
BUG: time warp detected!
prev > now, 101faf80ccb64133 > 101faf80ccb64132:
= 1 delta, on CPU#0
 [<b10041fb>] show_trace_log_lvl+0x179/0x18f
 [<b10048bd>] show_trace+0x12/0x14
 [<b10049de>] dump_stack+0x19/0x1b
 [<b102c0cc>] do_gettimeofday+0x19e/0x1c7
 [<b12bacc5>] evdev_event+0xea/0x167
 [<b12b6f25>] input_event+0xc5/0x467
 [<b12b24f6>] hidinput_report_event+0x34/0x5e
 [<b12ad115>] hid_input_report+0x286/0x3a1
 [<b12ae791>] hid_irq_in+0x4b/0x118
 [<b1296800>] usb_hcd_giveback_urb+0x1a/0x4f
 [<b12a7077>] uhci_giveback_urb+0x80/0x171
 [<b12a77e0>] uhci_scan_schedule+0x57a/0x8cf
 [<b12a988b>] uhci_irq+0x6d/0x162
 [<b12973b6>] usb_hcd_irq+0x27/0x56
 [<b104f9d5>] handle_IRQ_event+0x5e/0xdb
 [<b104fef7>] thread_simple_irq+0x4b/0x85
 [<b10507d5>] do_irqd+0x2a9/0x314
 [<b1035f79>] kthread+0xe4/0xe8
 [<b1001005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<b10048bd>] show_trace+0x12/0x14
 [<b10049de>] dump_stack+0x19/0x1b
 [<b102c0cc>] do_gettimeofday+0x19e/0x1c7
 [<b12bacc5>] evdev_event+0xea/0x167
 [<b12b6f25>] input_event+0xc5/0x467
 [<b12b24f6>] hidinput_report_event+0x34/0x5e
 [<b12ad115>] hid_input_report+0x286/0x3a1
 [<b12ae791>] hid_irq_in+0x4b/0x118
 [<b1296800>] usb_hcd_giveback_urb+0x1a/0x4f
 [<b12a7077>] uhci_giveback_urb+0x80/0x171
 [<b12a77e0>] uhci_scan_schedule+0x57a/0x8cf
 [<b12a988b>] uhci_irq+0x6d/0x162
 [<b12973b6>] usb_hcd_irq+0x27/0x56
 [<b104f9d5>] handle_IRQ_event+0x5e/0xdb
 [<b104fef7>] thread_simple_irq+0x4b/0x85
 [<b10507d5>] do_irqd+0x2a9/0x314
 [<b1035f79>] kthread+0xe4/0xe8
 [<b1001005>] kernel_thread_helper+0x5/0xb


