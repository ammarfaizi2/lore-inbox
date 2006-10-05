Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWJESvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWJESvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWJESvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:51:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21654 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750824AbWJESvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:51:11 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64
From: Steve Fox <drfickle@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <200610052027.02208.ak@suse.de>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <200610051740.58511.ak@suse.de> <1160071032.29690.19.camel@flooterbu>
	 <200610052027.02208.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 13:51:03 -0500
Message-Id: <1160074263.29690.23.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 20:27 +0200, Andi Kleen wrote:

> I guess we need to track when it gets corrupted. Can you send the full
> boot log with this patch applied?

Here she blows!

root (hd0,0)
 Filesystem type is reiserfs, partition type 0x83
kernel /boot/vmlinuz-autobench root=/dev/sda1 vga=791
ip=9.47.67.239:9.47.67.5
0:9.47.67.1:255.255.255.0 resume=/dev/sdb1 showopts console=tty0
console=ttyS0,
57600 autobench_args: root=/dev/sda1 ABAT:1160073474
   [Linux-bzImage, setup=0x1400, size=0x1dd755]
initrd /boot/initrd-autobench.img
   [Linux-initrd @ 0x37ceb000, 0x304c57 bytes]

Linux version 2.6.18-git22 (root@elm3b239) (gcc version 4.1.0 (SUSE
Linux)) #4 SMP Thu Oct 5 11:36:21 PDT 2006
Command line: root=/dev/sda1 vga=791
ip=9.47.67.239:9.47.67.50:9.47.67.1:255.255.255.0 resume=/dev/sdb1
showopts console=tty0 console=ttyS0,57600 autobench_args: root=/dev/sda1
ABAT:1160073474
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
 BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bff764c0 (usable)
 BIOS-e820: 00000000bff764c0 - 00000000bff98880 (ACPI data)
 BIOS-e820: 00000000bff98880 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000c00000000 (usable)
end_pfn_map = 12582912
DMI 2.3 present.
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 -> 12582912
early_node_map[3] active PFN ranges
    0:        0 ->      154
    0:      256 ->   786294
    0:  1048576 -> 12582912
ACPI: PM-Timer IO Port: 0x9c
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x10] enabled)
Processor #16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x11] enabled)
Processor #17
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x16] enabled)
Processor #22
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x17] enabled)
Processor #23
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x20] enabled)
Processor #32
ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
Processor #33
ACPI: LAPIC (acpi_id[0x12] lapic_id[0x26] enabled)
Processor #38
ACPI: LAPIC (acpi_id[0x13] lapic_id[0x27] enabled)
Processor #39
ACPI: LAPIC (acpi_id[0x14] lapic_id[0x30] enabled)
Processor #48
ACPI: LAPIC (acpi_id[0x15] lapic_id[0x31] enabled)
Processor #49
ACPI: LAPIC (acpi_id[0x16] lapic_id[0x36] enabled)
Processor #54
ACPI: LAPIC (acpi_id[0x17] lapic_id[0x37] enabled)
Processor #55
ACPI: LAPIC (acpi_id[0x20] lapic_id[0x40] enabled)
Processor #64
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x21] lapic_id[0x41] enabled)
Processor #65
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x22] lapic_id[0x46] enabled)
Processor #70
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x23] lapic_id[0x47] enabled)
Processor #71
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x24] lapic_id[0x50] enabled)
Processor #80
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x25] lapic_id[0x51] enabled)
Processor #81
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x26] lapic_id[0x56] enabled)
Processor #86
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x27] lapic_id[0x57] enabled)
Processor #87
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x30] lapic_id[0x60] enabled)
Processor #96
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x31] lapic_id[0x61] enabled)
Processor #97
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x32] lapic_id[0x66] enabled)
Processor #102
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x33] lapic_id[0x67] enabled)
Processor #103
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x34] lapic_id[0x70] enabled)
Processor #112
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x35] lapic_id[0x71] enabled)
Processor #113
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x36] lapic_id[0x76] enabled)
Processor #118
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x37] lapic_id[0x77] enabled)
Processor #119
WARNING: NR_CPUS limit of 16 reached. Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x10] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x11] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x12] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x13] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x14] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x15] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x16] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x17] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x20] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x21] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x22] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x23] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x24] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x25] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x26] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x27] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x30] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x31] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x32] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x33] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x34] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x35] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x36] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x37] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 15, address 0xfec00000, GSI 0-35
ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[36])
IOAPIC[1]: apic_id 14, address 0xfec01000, GSI 36-71
ACPI: IOAPIC (id[0x0d] address[0xfec02000] gsi_base[72])
IOAPIC[2]: apic_id 13, address 0xfec02000, GSI 72-107
ACPI: IOAPIC (id[0x0c] address[0xfec03000] gsi_base[108])
IOAPIC[3]: apic_id 12, address 0xfec03000, GSI 108-143
ACPI: IOAPIC (id[0x0b] address[0xfec04000] gsi_base[144])
IOAPIC[4]: apic_id 11, address 0xfec04000, GSI 144-179
ACPI: IOAPIC (id[0x0a] address[0xfec05000] gsi_base[180])
IOAPIC[5]: apic_id 10, address 0xfec05000, GSI 180-215
ACPI: IOAPIC (id[0x09] address[0xfec06000] gsi_base[216])
IOAPIC[6]: apic_id 9, address 0xfec06000, GSI 216-251
ACPI: IOAPIC (id[0x08] address[0xfec07000] gsi_base[252])
IOAPIC[7]: apic_id 8, address 0xfec07000, GSI 252-287
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
Setting APIC routing to clustered
ACPI: HPET id: 0x10142201 base: 0xfde84000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009a000 - 000000000009b000
Nosave address range: 000000000009b000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 00000000bff76000 - 00000000bff77000
Nosave address range: 00000000bff77000 - 00000000bff98000
Nosave address range: 00000000bff98000 - 00000000bff99000
Nosave address range: 00000000bff99000 - 00000000c0000000
Nosave address range: 00000000c0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
afinfo corrupted at init/main.c:512
SMP: Allowing 16 CPUs, 0 hotplug CPUs
PERCPU: Allocating 33920 bytes of per cpu data
afinfo corrupted at init/main.c:527
Built 1 zonelists.  Total pages: 12147064
Kernel command line: root=/dev/sda1 vga=791
ip=9.47.67.239:9.47.67.50:9.47.67.1:255.255.255.0 resume=/dev/sdb1
showopts console=tty0 console=ttyS0,57600 autobench_args: root=/dev/sda1
ABAT:1160073474
afinfo corrupted at init/main.c:536
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
afinfo corrupted at init/main.c:545
afinfo corrupted at init/main.c:548
Console: colour VGA+ 80x25
Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
afinfo corrupted at init/main.c:582
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x310c2000 - 0x350c2000
Memory: 48422908k/50331648k available (2566k kernel code, 858868k
reserved, 1345k data, 184k init)
afinfo corrupted at init/main.c:584
Calibrating delay using timer specific routine.. 5677.94 BogoMIPS
(lpj=11355895)
afinfo corrupted at init/main.c:593
afinfo corrupted at init/main.c:603
Mount-cache hash table entries: 256
afinfo corrupted at init/main.c:610
afinfo corrupted at init/main.c:618
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 10425802
Detected 10.425 MHz APIC timer.
afinfo corrupted at init/main.c:749
SMP alternatives: switching to SMP code
Booting processor 1/16 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5671.84 BogoMIPS
(lpj=11343680)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 799
cycles)
SMP alternatives: switching to SMP code
Booting processor 2/16 APIC 0x6
Initializing CPU#2
Calibrating delay using timer specific routine.. 5671.99 BogoMIPS
(lpj=11343984)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU2: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -13 cycles, maxerr 3341
cycles)
SMP alternatives: switching to SMP code
Booting processor 3/16 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 5672.06 BogoMIPS
(lpj=11344129)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU3: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff 178 cycles, maxerr 3171
cycles)
SMP alternatives: switching to SMP code
Booting processor 4/16 APIC 0x10
Initializing CPU#4
Calibrating delay using timer specific routine.. 5672.04 BogoMIPS
(lpj=11344087)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 8
CPU: Processor Core ID: 0
CPU4: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 4: Syncing TSC to CPU 0.
CPU 4: synchronized TSC with CPU 0 (last diff -420 cycles, maxerr 3510
cycles)
SMP alternatives: switching to SMP code
Booting processor 5/16 APIC 0x11
Initializing CPU#5
Calibrating delay using timer specific routine.. 5672.04 BogoMIPS
(lpj=11344081)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 8
CPU: Processor Core ID: 0
CPU5: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 5: Syncing TSC to CPU 0.
CPU 5: synchronized TSC with CPU 0 (last diff -801 cycles, maxerr 3315
cycles)
SMP alternatives: switching to SMP code
Booting processor 6/16 APIC 0x16
Initializing CPU#6
Calibrating delay using timer specific routine.. 5672.02 BogoMIPS
(lpj=11344046)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 11
CPU: Processor Core ID: 0
CPU6: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 6: Syncing TSC to CPU 0.
CPU 6: synchronized TSC with CPU 0 (last diff -287 cycles, maxerr 3281
cycles)
SMP alternatives: switching to SMP code
Booting processor 7/16 APIC 0x17
Initializing CPU#7
Calibrating delay using timer specific routine.. 5672.01 BogoMIPS
(lpj=11344028)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 11
CPU: Processor Core ID: 0
CPU7: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 7: Syncing TSC to CPU 0.
CPU 7: synchronized TSC with CPU 0 (last diff 238 cycles, maxerr 3391
cycles)
SMP alternatives: switching to SMP code
Booting processor 8/16 APIC 0x20
Initializing CPU#8
Calibrating delay using timer specific routine.. 5672.42 BogoMIPS
(lpj=11344847)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 16
CPU: Processor Core ID: 0
CPU8: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 8: Syncing TSC to CPU 0.
CPU 8: synchronized TSC with CPU 0 (last diff 101 cycles, maxerr 8577
cycles)
SMP alternatives: switching to SMP code
Booting processor 9/16 APIC 0x21
Initializing CPU#9
Calibrating delay using timer specific routine.. 5672.28 BogoMIPS
(lpj=11344576)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 16
CPU: Processor Core ID: 0
CPU9: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 9: Syncing TSC to CPU 0.
CPU 9: synchronized TSC with CPU 0 (last diff 200 cycles, maxerr 8109
cycles)
SMP alternatives: switching to SMP code
Booting processor 10/16 APIC 0x26
Initializing CPU#10
Calibrating delay using timer specific routine.. 5672.50 BogoMIPS
(lpj=11345012)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 19
CPU: Processor Core ID: 0
CPU10: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 10: Syncing TSC to CPU 0.
CPU 10: synchronized TSC with CPU 0 (last diff 72 cycles, maxerr 8551
cycles)
SMP alternatives: switching to SMP code
Booting processor 11/16 APIC 0x27
Initializing CPU#11
Calibrating delay using timer specific routine.. 5672.90 BogoMIPS
(lpj=11345804)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 19
CPU: Processor Core ID: 0
CPU11: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 11: Syncing TSC to CPU 0.
CPU 11: synchronized TSC with CPU 0 (last diff -548 cycles, maxerr 8526
cycles)
SMP alternatives: switching to SMP code
Booting processor 12/16 APIC 0x30
Initializing CPU#12
Calibrating delay using timer specific routine.. 5672.75 BogoMIPS
(lpj=11345516)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 24
CPU: Processor Core ID: 0
CPU12: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 12: Syncing TSC to CPU 0.
CPU 12: synchronized TSC with CPU 0 (last diff 35 cycles, maxerr 8636
cycles)
SMP alternatives: switching to SMP code
Booting processor 13/16 APIC 0x31
Initializing CPU#13
Calibrating delay using timer specific routine.. 5672.55 BogoMIPS
(lpj=11345119)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 24
CPU: Processor Core ID: 0
CPU13: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 13: Syncing TSC to CPU 0.
CPU 13: synchronized TSC with CPU 0 (last diff -1125 cycles, maxerr 7829
cycles)
SMP alternatives: switching to SMP code
Booting processor 14/16 APIC 0x36
Initializing CPU#14
Calibrating delay using timer specific routine.. 5672.25 BogoMIPS
(lpj=11344507)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 27
CPU: Processor Core ID: 0
CPU14: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 14: Syncing TSC to CPU 0.
CPU 14: synchronized TSC with CPU 0 (last diff -796 cycles, maxerr 8568
cycles)
SMP alternatives: switching to SMP code
Booting processor 15/16 APIC 0x37
Initializing CPU#15
Calibrating delay using timer specific routine.. 5672.24 BogoMIPS
(lpj=11344495)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: L3 cache: 4096K
CPU: Physical Processor ID: 27
CPU: Processor Core ID: 0
CPU15: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 2.83GHz stepping 01
CPU 15: Syncing TSC to CPU 0.
CPU 15: synchronized TSC with CPU 0 (last diff -3 cycles, maxerr 7531
cycles)
Brought up 16 CPUs
testing NMI watchdog ... OK.
time.c: Using 333.333333 MHz WALL PIT GTOD PIT/HPET timer.
time.c: Detected 2835.836 MHz processor.
afinfo corrupted at init/main.c:755
migration_cost=29,1007
afinfo corrupted at init/main.c:761
afinfo corrupted at init/main.c:769
Calling initcall 0xffffffff802166c0: init_smp_flush+0x0/0x60()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806077b0: helper_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607b40: pm_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607bc0: ksysfs_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060a490: filelock_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060afa0: init_script_binfmt+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060afb0: init_elf_binfmt+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80614400: sock_init+0x0/0x60()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80614ba0: netlink_proto_init+0x0/0x1a0()
afinfo corrupted at init/main.c:659
NET: Registered protocol family 16
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060c080: kobject_uevent_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060c210: pcibus_class_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060c7e0: pci_driver_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060eca0: tty_class_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060f790: vtconsole_class_init+0x0/0xc0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060c920: acpi_pci_init+0x0/0x40()
afinfo corrupted at init/main.c:659
ACPI: bus type pci registered
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060d65f: init_acpi_device_notify+0x0/0x4b()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80613810: pci_access_init+0x0/0x30()
afinfo corrupted at init/main.c:659
PCI: Using configuration type 1
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806054d0: topology_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806074e0: param_sysfs_init+0x0/0x200()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80249d00: pm_sysrq_init+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060ac50: init_bio+0x0/0x110()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bf40: genhd_device_init+0x0/0x60()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060d472: acpi_init+0x0/0x1ed()
afinfo corrupted at init/main.c:659
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060d945: acpi_ec_init+0x0/0x62()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060dd5e: acpi_pci_root_init+0x0/0x28()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060dda6: acpi_pci_link_init+0x0/0x48()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060df2c: acpi_power_init+0x0/0x77()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060dfa3: acpi_system_init+0x0/0xc6()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e069: acpi_event_init+0x0/0x3f()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e0a8: acpi_scan_init+0x0/0x1ac()
afinfo corrupted at init/main.c:659
ACPI: PCI Root Bridge [VP00] (0000:00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Root Bridge [VP01] (0000:01)
ACPI: PCI Root Bridge [VP02] (0000:02)
ACPI: PCI Root Bridge [VP03] (0000:04)
ACPI: PCI Root Bridge [VP04] (0000:06)
ACPI: PCI Root Bridge [VP05] (0000:08)
ACPI: PCI Root Bridge [VP06] (0000:0a)
ACPI: PCI Root Bridge [VP07] (0000:0c)
ACPI: PCI Root Bridge [VP10] (0000:0e)
ACPI: PCI Root Bridge [VP11] (0000:0f)
ACPI: PCI Root Bridge [VP12] (0000:10)
ACPI: PCI Root Bridge [VP13] (0000:12)
ACPI: PCI Root Bridge [VP14] (0000:14)
ACPI: PCI Root Bridge [VP15] (0000:16)
ACPI: PCI Root Bridge [VP16] (0000:18)
ACPI: PCI Root Bridge [VP17] (0000:1a)
ACPI: PCI Root Bridge [VP20] (0000:1c)
ACPI: PCI Root Bridge [VP21] (0000:1d)
ACPI: PCI Root Bridge [VP22] (0000:1e)
ACPI: PCI Root Bridge [VP23] (0000:20)
ACPI: PCI Root Bridge [VP24] (0000:22)
ACPI: PCI Root Bridge [VP25] (0000:24)
ACPI: PCI Root Bridge [VP26] (0000:26)
ACPI: PCI Root Bridge [VP27] (0000:28)
ACPI: PCI Root Bridge [VP30] (0000:2a)
ACPI: PCI Root Bridge [VP31] (0000:2b)
ACPI: PCI Root Bridge [VP32] (0000:2c)
ACPI: PCI Root Bridge [VP33] (0000:2e)
ACPI: PCI Root Bridge [VP34] (0000:30)
ACPI: PCI Root Bridge [VP35] (0000:32)
ACPI: PCI Root Bridge [VP36] (0000:34)
ACPI: PCI Root Bridge [VP37] (0000:36)
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e3c4: acpi_cm_sbs_init+0x0/0xc()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e3d0: pnp_init+0x0/0x30()
afinfo corrupted at init/main.c:659
Linux Plug and Play Support v0.97 (c) Adam Belay
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e660: pnpacpi_init+0x0/0x70()
afinfo corrupted at init/main.c:659
pnp: PnP ACPI init
pnp: PnP ACPI: found 47 devices
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060f200: misc_init+0x0/0x90()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80375670: cn_init+0x0/0xe0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611560: init_scsi+0x0/0x90()
afinfo corrupted at init/main.c:659
SCSI subsystem initialized
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612240: serio_init+0x0/0xd0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612660: input_init+0x0/0x120()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612a70: rtc_init+0x0/0x50()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612ac0: rtc_sysfs_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612ad0: rtc_proc_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612ae0: rtc_dev_init+0x0/0xb0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80613840: pci_acpi_init+0x0/0xb0()
afinfo corrupted at init/main.c:659
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806138f0: pci_legacy_init+0x0/0x120()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80613ea0: pcibios_irq_init+0x0/0x4f0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80614390: pcibios_init+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806144c0: proto_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80614660: net_dev_init+0x0/0x210()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80614d40: genl_init+0x0/0xb0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff805fdfc0: late_hpet_init+0x0/0xb0()
afinfo corrupted at init/main.c:659
hpet0: at MMIO 0xfde84000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 3707069 Hz
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff805ffe20: pci_iommu_init+0x0/0x20()
afinfo corrupted at init/main.c:659
PCI-GART: No AMD northbridge found.
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060a410: init_pipe_fs+0x0/0x50()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e294: acpi_motherboard_init+0x0/0x130()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e500: pnp_system_init+0x0/0x10()
afinfo corrupted at init/main.c:659
pnp: 00:0a: ioport range 0x400-0x47f has been reserved
pnp: 00:0a: ioport range 0x480-0x4ff could not be reserved
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060e9e0: chr_dev_init+0x0/0x80()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806107b0: firmware_class_init+0x0/0x80()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80613220: pcibios_assign_resources+0x0/0x90()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80615750: inet_init+0x0/0x400()
afinfo corrupted at init/main.c:659
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8020db10: time_init_device+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff805fe760: i8259A_init_sysfs+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff805fe730: init_timer_sysfs+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff805fed80: vsyscall_init+0x0/0xb0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff805ff010: sbf_init+0x0/0xe0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff805ffdf0: i8237A_init_sysfs+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80600270: periodic_mcheck_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806002a0: mce_init_device+0x0/0x80()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806003e0: thermal_throttle_init_device
+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80600450: threshold_init_device+0x0/0x50()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80601c50: init_lapic_sysfs+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806027f0: ioapic_init_sysfs+0x0/0xf0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8021d1f0: cache_sysfs_init+0x0/0x60()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806055e0: x8664_sysctl_init+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80606aa0: create_proc_profile+0x0/0x280()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80606ee0: ioresources_init+0x0/0x50()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607050: timekeeping_init_device+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607170: uid_cache_init+0x0/0x90()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806076e0: init_posix_timers+0x0/0xd0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806077f0: init_posix_cpu_timers+0x0/0xf0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607910: latency_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607a00: init_clocksource_sysfs+0x0/0x60()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607a60: init_jiffies_clocksource+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607a70: init+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607ae0: proc_dma_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80245840: percpu_modinit+0x0/0x80()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607b10: kallsyms_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80607b80: ikconfig_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80608cd0: init_per_zone_pages_min+0x0/0x60()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80609c40: pdflush_init+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80609c90: kswapd_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80609cc0: setup_vmstat+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80609d30: procswaps_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80609da0: hugetlb_init+0x0/0x70()
afinfo corrupted at init/main.c:659
Total HugeTLB memory allocated, 0
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80609e10: init_tmpfs+0x0/0xe0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80609ef0: cpucache_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060a460: fasync_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060ab70: aio_setup+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060adf0: inotify_setup+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060ae00: inotify_user_setup+0x0/0xc0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060aec0: eventpoll_init+0x0/0xe0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060afc0: init_mbcache+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060aff0: dnotify_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b4b0: init_devpts_fs+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b4f0: init_reiserfs_fs+0x0/0x80()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b570: init_ext3_fs+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b6a0: journal_init+0x0/0xe0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b780: init_ext2_fs+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b840: init_ramfs_fs+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b850: init_hugetlbfs_fs+0x0/0x80()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b910: init_fat_fs+0x0/0x50()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b960: init_vfat_fs+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b970: init_nls_cp437+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b980: init_nls_iso8859_1+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b990: init_autofs_fs+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060b9a0: init_autofs4_fs+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
initcall at 0xffffffff8060b9a0: init_autofs4_fs+0x0/0x10(): returned
with error code -16
Calling initcall 0xffffffff8060b9b0: ipc_init+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bc80: init_mqueue_fs+0x0/0xe0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bd60: crypto_algapi_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bda0: init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bdb0: init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bfa0: noop_init+0x0/0x10()
afinfo corrupted at init/main.c:659
io scheduler noop registered
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bfb0: as_init+0x0/0x10()
afinfo corrupted at init/main.c:659
io scheduler anticipatory registered (default)
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bfc0: deadline_init+0x0/0x10()
afinfo corrupted at init/main.c:659
io scheduler deadline registered
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060bfd0: cfq_init+0x0/0xb0()
afinfo corrupted at init/main.c:659
io scheduler cfq registered
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8032c1d0: pci_init+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060c7f0: pci_sysfs_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060c830: pci_proc_init+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060d6aa: acpi_ac_init+0x0/0x45()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060d6ef: acpi_battery_init+0x0/0x45()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060dd00: acpi_video_init+0x0/0x5e()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060ddee: irqrouter_init_sysfs+0x0/0x38()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060ea80: rand_initialize+0x0/0x30()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060eab0: tty_init+0x0/0x1f0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060ed10: pty_init+0x0/0x4f0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060f850: hpet_init+0x0/0x70()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060f8c0: agp_init+0x0/0x30()
afinfo corrupted at init/main.c:659
Linux agpgart interface v0.101 (c) Dave Jones
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060fa20: cn_proc_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff8060fe60: serial8250_init+0x0/0x150()
afinfo corrupted at init/main.c:659
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80610090: serial8250_pnp_init+0x0/0x10()
afinfo corrupted at init/main.c:659
00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806100a0: serial8250_pci_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80384c90: topology_sysfs_init+0x0/0x50()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80610830: e1000_init_module+0x0/0x50()
afinfo corrupted at init/main.c:659
Intel(R) PRO/1000 Network Driver - version 7.2.9-k2
Copyright (c) 1999-2006 Intel Corporation.
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80610880: tg3_init+0x0/0x10()
afinfo corrupted at init/main.c:659
tg3.c:v3.66 (September 23, 2006)
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 24
eth0: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:0d:60:98:63:54
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1]
TSOcap[0]
eth0: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 28
eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:0d:60:98:63:55
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:0f:01.0[A] -> GSI 96 (level, low) -> IRQ 96
eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:14:5e:1c:45:0c
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1]
TSOcap[0]
eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:0f:01.1[B] -> GSI 100 (level, low) -> IRQ 100
eth3: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:14:5e:1c:45:0d
eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
eth3: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:1d:01.0[A] -> GSI 168 (level, low) -> IRQ 168
eth4: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:14:5e:1c:45:6c
eth4: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1]
TSOcap[0]
eth4: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:1d:01.1[B] -> GSI 172 (level, low) -> IRQ 172
eth5: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:14:5e:1c:45:6d
eth5: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
eth5: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:2b:01.0[A] -> GSI 240 (level, low) -> IRQ 240
eth6: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:14:5e:1c:43:82
eth6: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1]
TSOcap[0]
eth6: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:2b:01.1[B] -> GSI 244 (level, low) -> IRQ 244
eth7: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit)
10/100/1000BaseT Ethernet 00:14:5e:1c:43:83
eth7: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
eth7: dma_rwctrl[769f0000] dma_mask[64-bit]
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80610910: net_olddevs_init+0x0/0xc0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff803a8630: init_netconsole+0x0/0x80()
afinfo corrupted at init/main.c:659
netconsole: not configured, aborting
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff803a8710: cmd64x_ide_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806109e0: piix_ide_init+0x0/0xd0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff803aa810: svwks_ide_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff803ab480: generic_ide_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80610b20: ide_init+0x0/0x90()
afinfo corrupted at init/main.c:659
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
SvrWks CSB6: simplex device: DMA disabled
ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
hda: MATSHITADVD-ROM SR-8178, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806114f0: ide_generic_init+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611510: idedisk_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611520: ide_cdrom_init+0x0/0x10()
afinfo corrupted at init/main.c:659
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611530: idefloppy_init+0x0/0x30()
afinfo corrupted at init/main.c:659
ide-floppy driver 0.99.newide
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611800: raid_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611810: spi_transport_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611850: fc_transport_init+0x0/0x50()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806118a0: iscsi_transport_init+0x0/0x120()
afinfo corrupted at init/main.c:659
Loading iSCSI transport class v2.0-685.afinfo corrupted at
init/main.c:663
Calling initcall 0xffffffff806119c0: sas_transport_init+0x0/0xc0()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611a80: iscsi_tcp_init+0x0/0x50()
afinfo corrupted at init/main.c:659
iscsi: registered transport (tcp)
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611ad0: aac_init+0x0/0x70()
afinfo corrupted at init/main.c:659
Adaptec aacraid driver (1.1-5[2409]-mh2)
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 25
AAC0: kernel 5.0-2[8264]
AAC0: monitor 5.0-2[8264]
AAC0: bios 5.0-2[8264]
AAC0: serial 162348
AAC0: 64bit support enabled.
AAC0: 64 Bit DAC enabled
scsi0 : ServeRAID
scsi 0:0:0:0: Direct-Access     IBM      Drive 1          V1.0 PQ: 0
ANSI: 2
scsi 0:0:1:0: Direct-Access     IBM      Drive 2          V1.0 PQ: 0
ANSI: 2
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611b40: qla1280_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611d10: sym2_init+0x0/0x110()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611e20: init_sd+0x0/0x60()
afinfo corrupted at init/main.c:659
SCSI device sda: 143132672 512-byte hdwr sectors (73284 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 143132672 512-byte hdwr sectors (73284 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi removable disk sda
SCSI device sdb: 143132672 512-byte hdwr sectors (73284 MB)
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
SCSI device sdb: 143132672 512-byte hdwr sectors (73284 MB)
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 0:0:1:0: Attached scsi removable disk sdb
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611e80: fusion_init+0x0/0x100()
afinfo corrupted at init/main.c:659
Fusion MPT base driver 3.04.01
Copyright (c) 1999-2005 LSI Logic Corporation
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80611f80: mptspi_init+0x0/0xc0()
afinfo corrupted at init/main.c:659
Fusion MPT SPI Host driver 3.04.01
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612040: mptfc_init+0x0/0xf0()
afinfo corrupted at init/main.c:659
Fusion MPT FC Host driver 3.04.01
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612130: mptctl_init+0x0/0x100()
afinfo corrupted at init/main.c:659
Fusion MPT misc device (ioctl) driver 3.04.01
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612230: cdrom_init+0x0/0x10()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612310: i8042_init+0x0/0x350()
afinfo corrupted at init/main.c:659
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612780: mousedev_init+0x0/0x100()
afinfo corrupted at init/main.c:659
mice: PS/2 mouse device common for all mice
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612880: atkbd_init+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80612b90: hwmon_init+0x0/0x40()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff806149d0: flow_cache_init+0x0/0x1d0()
afinfo corrupted at init/main.c:659
input: AT Translated Set 2 keyboard as /class/input/input0
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80615e60: init_syncookies+0x0/0x20()
afinfo corrupted at init/main.c:659
afinfo corrupted at init/main.c:663
Calling initcall 0xffffffff80615e80: xfrm4_beet_init+0x0/0x20()
afinfo corrupted at init/main.c:659
Unable to handle kernel NULL pointer dereference at 0000000000000827
RIP:
 [<ffffffff80470666>] xfrm_register_mode+0x36/0x60
PGD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.18-git22 #4
RIP: 0010:[<ffffffff80470666>]  [<ffffffff80470666>] xfrm_register_mode
+0x36/0x60
RSP: 0000:ffff810bffcbded0  EFLAGS: 00010286
RAX: 000000000000081f RBX: ffffffff805588a0 RCX: 0000000000100000
RDX: ffffffffffffffff RSI: 0000000000000002 RDI: ffffffff80559550
RBP: 00000000ffffffef R08: 0000000000000002 R09: fffffffffffffffd
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
R13: ffff810bffcbdef0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff805d2000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000827 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff810bffcbc000, task
ffff810bffcbb4e0)
Stack:  0000000000000000 0000000000000000 ffffffff8061fc48
ffffffff802071d6
 6f6320726f727265 000036312d206564 0000000000000000 0000000000000000
 0000000000000000 0000000000000000 0000000000000000 0000000000090000
Call Trace:
 [<ffffffff802071d6>] init+0x1b6/0x3b0
 [<ffffffff8020aa28>] child_rip+0xa/0x12
 [<ffffffff80339542>] acpi_ds_init_one_object+0x0/0x82
 [<ffffffff80207020>] init+0x0/0x3b0
 [<ffffffff8020aa1e>] child_rip+0x0/0x12


Code: 48 83 78 08 00 75 06 48 89 58 08 31 ed 48 89 d7 e8 e5 fe ff
RIP  [<ffffffff80470666>] xfrm_register_mode+0x36/0x60
 RSP <ffff810bffcbded0>
CR2: 0000000000000827
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

-- 

Steve Fox
IBM Linux Technology Center
