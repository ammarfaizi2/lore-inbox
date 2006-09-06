Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWIFWK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWIFWK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWIFWK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:10:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40653 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751757AbWIFWKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:10:55 -0400
Date: Wed, 6 Sep 2006 15:10:08 -0700
From: Paul Jackson <pj@sgi.com>
To: mel@skynet.ie (Mel Gorman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com,
       apw@shadowen.org, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       kmannth@gmail.com, tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: Re: x86_64 account-for-memmap patch in 2.6.18-rc4-mm3 doesn't boot.
Message-Id: <20060906151008.e84ffdd1.pj@sgi.com>
In-Reply-To: <20060904094503.GA4475@skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com>
	<Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie>
	<20060831100156.24fc0521.pj@sgi.com>
	<Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie>
	<20060901202430.0681f5c5.pj@sgi.com>
	<20060904094503.GA4475@skynet.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> I could do with those lines, but I believe there was enough information
> printed to determine why it failed to boot. I've attached a patch that
> should boot the machine and assuming it works, I just need the output of
> dmesg.

Yup - that patch booted it, and produced the output you asked for.

Here's the dmesg output from booting your patch:

Linux version 2.6.18-rc4-mm3 (pj@spandau) (gcc version 4.1.0 (SUSE Linux)) #60 SMP Wed Sep 6 16:34:36 CDT 2006
Command line: root=/dev/sda3 console=ttyS1,115200 showopts pj1
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f932000 (usable)
 BIOS-e820: 000000007f932000 - 000000007f9d0000 (ACPI NVS)
 BIOS-e820: 000000007f9d0000 - 000000007fa42000 (usable)
 BIOS-e820: 000000007fa42000 - 000000007fa9a000 (reserved)
 BIOS-e820: 000000007fa9a000 - 000000007fad6000 (usable)
 BIOS-e820: 000000007fad6000 - 000000007fb1a000 (ACPI NVS)
 BIOS-e820: 000000007fb1a000 - 000000007fb2b000 (usable)
 BIOS-e820: 000000007fb2b000 - 000000007fb3a000 (ACPI data)
 BIOS-e820: 000000007fb3a000 - 000000007fc00000 (usable)
 BIOS-e820: 00000000ffc00000 - 00000000ffc0c000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 522546) 1 entries of 3200 used
Entering add_active_range(0, 522704, 522818) 2 entries of 3200 used
Entering add_active_range(0, 522906, 522966) 3 entries of 3200 used
Entering add_active_range(0, 523034, 523051) 4 entries of 3200 used
Entering add_active_range(0, 523066, 523264) 5 entries of 3200 used
end_pfn_map = 1047564
DMI 2.4 present.
ACPI: RSDP (v002 INTEL                                 ) @ 0x00000000000f0350
ACPI: XSDT (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000007fb39120
ACPI: FADT (v003 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000007fb36000
ACPI: MADT (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000007fb35000
ACPI: SPCR (v001 INTEL  S5000PAL 0x00000000 INTL 0x01000013) @ 0x000000007fb2e000
ACPI: HPET (v001 INTEL  S5000PAL 0x00000001 INTL 0x01000013) @ 0x000000007fb2d000
ACPI: MCFG (v001 INTEL  S5000PAL 0x00000001 INTL 0x01000013) @ 0x000000007fb2c000
ACPI: SSDT (v002 INTEL  S5000PAL 0x00004000 INTL 0x01000013) @ 0x000000007fb2b000
ACPI: DSDT (v002 INTEL  S5000PAL 0x00000008 INTL 0x01000013) @ 0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-000000007fc00000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 522546) 1 entries of 3200 used
Entering add_active_range(0, 522704, 522818) 2 entries of 3200 used
Entering add_active_range(0, 522906, 522966) 3 entries of 3200 used
Entering add_active_range(0, 523034, 523051) 4 entries of 3200 used
Entering add_active_range(0, 523066, 523264) 5 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000007fc00000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[6] active PFN ranges
    0:        0 ->      159
    0:      256 ->   522546
    0:   522704 ->   522818
    0:   522906 ->   522966
    0:   523034 ->   523051
    0:   523066 ->   523264
On node 0 totalpages: 522838
  DMA zone: 7154 pages used for memmap
memmap_size of 7154 exceeds 3999
  DMA zone: 1732 pages reserved
  DMA zone: 2267 pages, LIFO batch:0
  DMA32 zone: 518839 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x84] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x85] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x86] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x87] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec84000] gsi_base[48])
IOAPIC[2]: apic_id 10, address 0xfec84000, GSI 48-71
ACPI: IOAPIC (id[0x0b] address[0xfec84400] gsi_base[72])
IOAPIC[3]: apic_id 11, address 0xfec84400, GSI 72-95
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7fc00000:80000000)
SMP: Allowing 8 CPUs, 4 hotplug CPUs
PERCPU: Allocating 32000 bytes of per cpu data
Built 1 zonelists.  Total pages: 521106
Kernel command line: root=/dev/sda3 console=ttyS1,115200 showopts pj1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
Memory: 2052128k/2093056k available (3520k kernel code, 39224k reserved, 2327k data, 280k init)
Calibrating delay using timer specific routine.. 5324.65 BogoMIPS (lpj=10649309)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 20781307
Detected 20.781 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 5320.18 BogoMIPS (lpj=10640368)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/6 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM2)
Genuine Intel(R) CPU                  @ 2.66GHz stepping 04
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 5320.13 BogoMIPS (lpj=10640272)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 2/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM2)
Genuine Intel(R) CPU                  @ 2.66GHz stepping 04
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 5320.15 BogoMIPS (lpj=10640316)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 3/7 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 1
CPU3: Thermal monitoring enabled (TM2)
Genuine Intel(R) CPU                  @ 2.66GHz stepping 04
Brought up 4 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2660.008 MHz processor.
migration_cost=24,8015
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at a0000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Losing some ticks... checking if CPU frequency changed.
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:10:0c.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXPC._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXPC.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXPC.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIO.PCIA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE.PCIW.PCIQ._PRT]
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:03:00.0
  IO window: disabled.
  MEM window: b8900000-b89fffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:03:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: b8900000-b89fffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:02:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:02.0
  IO window: 2000-2fff
  MEM window: b8000000-b88fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.0
  IO window: 2000-2fff
  MEM window: b8000000-b89fffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:01:00.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: 2000-2fff
  MEM window: b8000000-b8afffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:0c:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:0c:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: b8c00000-b8cfffff
  PREFETCH window: b0000000-b7ffffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:01:00.0 to 64
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:00.0 to 64
PCI: Setting latency timer of device 0000:03:00.0 to 64
PCI: Setting latency timer of device 0000:03:00.2 to 64
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:01.0 to 64
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.3 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:05.0 to 64
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:0c:00.0 to 64
PCI: Setting latency timer of device 0000:0c:00.2 to 64
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with large block/inode numbers, no debug enabled
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie01]
PCI: Setting latency timer of device 0000:00:03.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie01]
PCI: Setting latency timer of device 0000:00:04.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie01]
Allocate Port Service[0000:00:04.0:pcie02]
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
Allocate Port Service[0000:00:05.0:pcie01]
Allocate Port Service[0000:00:05.0:pcie02]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
Allocate Port Service[0000:00:06.0:pcie01]
Allocate Port Service[0000:00:06.0:pcie02]
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
Allocate Port Service[0000:00:07.0:pcie01]
PCI: Setting latency timer of device 0000:01:00.0 to 64
Allocate Port Service[0000:01:00.0:pcie10]
Allocate Port Service[0000:01:00.0:pcie11]
PCI: Setting latency timer of device 0000:02:00.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:00.0:pcie20]
Allocate Port Service[0000:02:00.0:pcie21]
Allocate Port Service[0000:02:00.0:pcie22]
PCI: Setting latency timer of device 0000:02:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:01.0:pcie20]
Allocate Port Service[0000:02:01.0:pcie21]
PCI: Setting latency timer of device 0000:02:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:02.0:pcie20]
Allocate Port Service[0000:02:02.0:pcie21]
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:02.0:pcie01 failed with error 2
aer_init: AER service init fails - No ACPI _OSC support
aer: probe of 0000:00:03.0:pcie01 failed with error 1
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:04.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:05.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:06.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:07.0:pcie01 failed with error 2
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Invalid PBLK length [5]
ACPI: Invalid PBLK length [5]
ACPI: Invalid PBLK length [5]
ACPI: Invalid PBLK length [5]
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x4
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x5
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x6
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x7
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.1.9-k6
Copyright (c) 1999-2006 Intel Corporation.
GSI 17 sharing vector 0x42 and IRQ 17
ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:07:00.0 to 64
e1000: 0000:07:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x4) 00:04:23:cf:2d:d2
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 18 sharing vector 0x4A and IRQ 18
ACPI: PCI Interrupt 0000:07:00.1[B] -> GSI 19 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:07:00.1 to 64
e1000: 0000:07:00.1: e1000_probe: (PCI Express:2.5Gb/s:Width x4) 00:04:23:cf:2d:d3
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ESB2: IDE controller at PCI slot 0000:00:1f.1
GSI 19 sharing vector 0x52 and IRQ 19
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 20 (level, low) -> IRQ 82
ESB2: chipset revision 9
ESB2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x30a0-0x30a7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: DV-28E-N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
megaraid: 2.20.4.9 (Release Date: Sun Jul 16 12:27:22 EST 2006)
megasas: 00.00.03.01 Sun May 14 22:49:52 PDT 2006
megasas: 0x1000:0x0411:0x8086:0x3501: bus 4:slot 14:func 0
ACPI: PCI Interrupt 0000:04:0e.0[A] -> GSI 18 (level, low) -> IRQ 66
scsi0 : LSI Logic SAS based MegaRAID driver
scsi 0:0:0:0: Direct-Access     ATA      HDT722525DLA380  A80A PQ: 0 ANSI: 5
scsi 0:0:1:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:0:2:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:0:3:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:0:4:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:2:0:0: Direct-Access     INTEL    SROMBSAS18E      1.00 PQ: 0 ANSI: 5
scsi 0:2:1:0: Direct-Access     INTEL    SROMBSAS18E      1.00 PQ: 0 ANSI: 5
SCSI device sda: 486326272 512-byte hdwr sectors (248999 MB)
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
SCSI device sda: 486326272 512-byte hdwr sectors (248999 MB)
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:2:0:0: Attached scsi disk sda
SCSI device sdb: 2923825152 512-byte hdwr sectors (1496998 MB)
sdb: test WP failed, assume Write Enabled
sdb: asking for cache data failed
sdb: assuming drive cache: write through
SCSI device sdb: 2923825152 512-byte hdwr sectors (1496998 MB)
sdb: test WP failed, assume Write Enabled
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1
sd 0:2:1:0: Attached scsi disk sdb
sd 0:2:0:0: Attached scsi generic sg0 type 0
sd 0:2:1:0: Attached scsi generic sg1 type 0
Fusion MPT base driver 3.04.01
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.01
Fusion MPT SAS Host driver 3.04.01
ieee1394: raw1394: /dev/raw1394 device initialized
GSI 20 sharing vector 0x5A and IRQ 20
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 90
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 90, io mem 0xb8d00000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc4-mm3 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 90
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 90, io base 0x00003080
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc4-mm3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 21 sharing vector 0x62 and IRQ 21
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 98
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 98, io base 0x00003060
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-rc4-mm3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 23 (level, low) -> IRQ 90
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 90, io base 0x00003040
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.18-rc4-mm3 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 22 (level, low) -> IRQ 98
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 98, io base 0x00003020
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.18-rc4-mm3 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
Intel 810 + AC97 Audio, version 1.01, 16:33:05 Sep  6 2006
oprofile: using timer interrupt.
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: (supports S0 S1 S4 S5)
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input1
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 280k freed
Adding 9438176k swap on /dev/disk/by-id/scsi-3600062b0000011200c86316cf30a2b4c-part2.  Priority:-1 extents:1 across:9438176k
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
