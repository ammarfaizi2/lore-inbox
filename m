Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVFUGvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVFUGvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFTVsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:48:08 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:5026 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261627AbVFTVbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:31:40 -0400
Message-ID: <42B735B1.6040803@pantasys.com>
Date: Mon, 20 Jun 2005 14:31:29 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: sean.bruno@dsl-only.net, koch@esa.informatik.tu-darmstadt.de,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
References: <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org> <20050610184815.A13999@jurassic.park.msu.ru> <200506102247.30842.koch@esa.informatik.tu-darmstadt.de> <1118762382.9161.3.camel@home-lap> <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de> <42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap> <42B1E9B2.30504@pantasys.com> <20050617135400.A32290@jurassic.park.msu.ru> <20050617093410.24a58d56.peter@pantasys.com> <20050618114531.A2523@jurassic.park.msu.ru>
In-Reply-To: <20050618114531.A2523@jurassic.park.msu.ru>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070005030003070401030202"
X-OriginalArrivalTime: 20 Jun 2005 21:28:50.0109 (UTC) FILETIME=[0CB236D0:01C575DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070005030003070401030202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivan,

I've just tried a recent pull from Linus post 2.6.12. It seems that the 
bar sizes are now (mostly) correct. However, there are still issues with 
the resources failing to be allocated and the bars being disabled. I've 
attached the latest dmesg and lspci -vvx to see whether there's any 
enlightenment out there...

thanks,

peter

--------------070005030003070401030202
Content-Type: text/plain;
 name="dmesg-2.6.12.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.12.txt"

Bootdata ok (command line is vga=normal root=/dev/hda3 console=tty0 iommu=force)
Linux version 2.6.12 (root@linux) (gcc version 3.3.4 (pre 3.3.5 20040809)) #1 SMP Mon Jun 20 14:01:45 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000008fff0000 (usable)
 BIOS-e820: 000000008fff0000 - 000000008fffe000 (ACPI data)
 BIOS-e820: 000000008fffe000 - 0000000090000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000280000000 (usable)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000f88c0
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000506 MSFT 0x00000097) @ 0x000000008fff0100
ACPI: FADT (v003 A M I  OEMFACP  0x06000506 MSFT 0x00000097) @ 0x000000008fff0290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000506 MSFT 0x00000097) @ 0x000000008fff0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x06000506 MSFT 0x00000097) @ 0x000000008fffe040
ACPI: SRAT (v001 A M I  OEMSRAT  0x06000506 MSFT 0x00000097) @ 0x000000008fff9cb0
ACPI: MCFG (v001 A M I  OEMMCFG  0x06000506 MSFT 0x00000097) @ 0x000000008fff9f70
ACPI: DSDT (v001  0ABHQ 0ABHQ007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> Node 3
ACPI: [SRAT:0x00] ignored 8 entries of 16 found
SRAT: Node 0 PXM 0 100000-bfffffff
SRAT: Node 1 PXM 1 c0000000-1008fffffff
SRAT: Node 2 PXM 2 180000000-1ffffffff
SRAT: Node 3 PXM 3 200000000-27fffffff
SRAT: Node 1 PXM 1 c0000000-1008fffffff
SRAT: Node 0 PXM 0 0-bfffffff
node 1 shift 24 addr ff000000 conflict 0
node 1 shift 25 addr 1fe000000 conflict 0
node 1 shift 26 addr 3fc000000 conflict 0
node 1 shift 27 addr 7f8000000 conflict 0
node 1 shift 28 addr ff0000000 conflict 0
node 1 shift 29 addr 1fe0000000 conflict 0
node 1 shift 30 addr 3fc0000000 conflict 0
node 1 shift 31 addr c0000000 conflict 0
node 1 shift 32 addr c0000000 conflict 0
node 1 shift 33 addr c0000000 conflict 0
node 1 shift 34 addr c0000000 conflict 0
node 1 shift 35 addr c0000000 conflict 0
node 1 shift 36 addr c0000000 conflict 0
node 1 shift 37 addr c0000000 conflict 0
node 1 shift 38 addr c0000000 conflict 0
node 1 shift 39 addr c0000000 conflict 0
node 1 shift 40 addr c0000000 conflict 0
node 1 shift 41 addr c0000000 conflict 0
node 1 shift 42 addr c0000000 conflict 0
node 1 shift 43 addr c0000000 conflict 0
node 1 shift 44 addr c0000000 conflict 0
node 1 shift 45 addr c0000000 conflict 0
node 1 shift 46 addr c0000000 conflict 0
node 1 shift 47 addr c0000000 conflict 0
SRAT: No NUMA node hash function found. Contact maintainer
SRAT: SRAT not used.
Scanning NUMA topology in Northbridge 24
Number of nodes 4
Node 0 MemBase 0000000000000000 Limit 00000000bfffffff
Node 1 MemBase 00000000c0000000 Limit 000000017fffffff
Node 2 MemBase 0000000180000000 Limit 00000001ffffffff
Node 3 MemBase 0000000200000000 Limit 000000027fffffff
node 1 shift 24 addr ff000000 conflict 0
node 2 shift 25 addr 1fe000000 conflict 0
Using node hash shift of 26
Bootmem setup node 0 0000000000000000-00000000bfffffff
Bootmem setup node 1 00000000c0000000-000000017fffffff
Bootmem setup node 2 0000000180000000-00000001ffffffff
Bootmem setup node 3 0000000200000000-000000027fffffff
On node 0 totalpages: 786431
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 782335 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 786431
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 786431 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 2 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 3 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x84] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x85] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x86] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x87] disabled)
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0x00000000] gsi_base[24])
WARNING: Bogus (zero) I/O APIC address found in MADT table, skipping!
ACPI: IOAPIC (id[0x06] address[0xbfefe000] gsi_base[48])
IOAPIC[1]: apic_id 6, version 17, address 0xbfefe000, GSI 48-71
ACPI: IOAPIC (id[0x07] address[0x9bbff000] gsi_base[72])
IOAPIC[2]: apic_id 7, version 17, address 0x9bbff000, GSI 72-95
ACPI: IOAPIC (id[0x08] address[0x00000000] gsi_base[96])
WARNING: Bogus (zero) I/O APIC address found in MADT table, skipping!
ACPI: IOAPIC (id[0x09] address[0x00000000] gsi_base[120])
WARNING: Bogus (zero) I/O APIC address found in MADT table, skipping!
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 90000000 (gap: 90000000:6ec00000)
Checking aperture...
CPU 0: aperture @ 90000000 size 64 MB
CPU 1: aperture @ 90000000 size 64 MB
CPU 2: aperture @ 90000000 size 64 MB
CPU 3: aperture @ 90000000 size 64 MB
Built 4 zonelists
Kernel command line: vga=normal root=/dev/hda3 console=tty0 iommu=force
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2000.015 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 8473608k/10485760k available (3430k kernel code, 0k reserved, 1615k data, 248k init)
Calibrating delay loop... 3964.92 BogoMIPS (lpj=1982464)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff8101fff85f58
Initializing CPU#1
Calibrating delay loop... 3997.69 BogoMIPS (lpj=1998848)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 846 HE stepping 0a
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/2 rip 6000 rsp ffff81017ffa7f58
CPU 1: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 896 cycles)
Initializing CPU#2
Calibrating delay loop... 3997.69 BogoMIPS (lpj=1998848)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 846 HE stepping 0a
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 906 cycles)
Booting processor 3/3 rip 6000 rsp ffff81017ff07f58
Initializing CPU#3
Calibrating delay loop... 3997.69 BogoMIPS (lpj=1998848)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 846 HE stepping 0a
CPU 3: Syncing TSC to CPU 0.
Brought up 4 CPUs
CPU 3: synchronized TSC with CPU 0 (last diff -9 cycles, maxerr 1524 cycles)
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
  domain 1: span 01
   groups: 01
   domain 2: span 0f
    groups: 01 02 04 08
CPU1 attaching sched-domain:
 domain 0: span 02
  groups: 02
  domain 1: span 02
   groups: 02
   domain 2: span 0f
    groups: 02 04 08 01
CPU2 attaching sched-domain:
 domain 0: span 04
  groups: 04
  domain 1: span 04
   groups: 04
   domain 2: span 0f
    groups: 04 08 01 02
CPU3 attaching sched-domain:
 domain 0: span 08
  groups: 08
  domain 1: span 08
   groups: 08
   domain 2: span 0f
    groups: 08 01 02 04
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [10de/005e] 000580 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:00.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:00.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:00.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:00.0
PCI: Found 0000:00:01.0 [10de/0051] 000601 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:01.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:01.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:01.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:01.0
PCI: Found 0000:00:01.1 [10de/0052] 000c05 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:01.1
PCI: Calling quirk ffffffff8028fe00 for 0000:00:01.1
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:01.1
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:01.1
PCI: Found 0000:00:02.0 [10de/005a] 000c03 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:02.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:02.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:02.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:02.0
PCI: Found 0000:00:06.0 [10de/0053] 000101 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:06.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:06.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:06.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:06.0
PCI: Found 0000:00:09.0 [10de/005c] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:00:09.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:09.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:09.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:09.0
PCI: Found 0000:00:0b.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:00:0b.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:0b.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:0b.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:0b.0
PCI: Found 0000:00:0c.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:00:0c.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:0c.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:0c.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:0c.0
PCI: Found 0000:00:0d.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:00:0d.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:0d.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:0d.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:0d.0
PCI: Found 0000:00:0e.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:00:0e.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:0e.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:0e.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:0e.0
PCI: Found 0000:00:18.0 [1022/1100] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:18.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:18.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:18.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:18.0
PCI: Found 0000:00:18.1 [1022/1101] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:18.1
PCI: Calling quirk ffffffff8028fe00 for 0000:00:18.1
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:18.1
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:18.1
PCI: Found 0000:00:18.2 [1022/1102] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:18.2
PCI: Calling quirk ffffffff8028fe00 for 0000:00:18.2
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:18.2
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:18.2
PCI: Found 0000:00:18.3 [1022/1103] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:18.3
PCI: Calling quirk ffffffff8028fe00 for 0000:00:18.3
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:18.3
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:18.3
PCI: Found 0000:00:19.0 [1022/1100] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:19.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:19.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:19.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:19.0
PCI: Found 0000:00:19.1 [1022/1101] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:19.1
PCI: Calling quirk ffffffff8028fe00 for 0000:00:19.1
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:19.1
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:19.1
PCI: Found 0000:00:19.2 [1022/1102] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:19.2
PCI: Calling quirk ffffffff8028fe00 for 0000:00:19.2
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:19.2
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:19.2
PCI: Found 0000:00:19.3 [1022/1103] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:19.3
PCI: Calling quirk ffffffff8028fe00 for 0000:00:19.3
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:19.3
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:19.3
PCI: Found 0000:00:1a.0 [1022/1100] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1a.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1a.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1a.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1a.0
PCI: Found 0000:00:1a.1 [1022/1101] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1a.1
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1a.1
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1a.1
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1a.1
PCI: Found 0000:00:1a.2 [1022/1102] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1a.2
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1a.2
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1a.2
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1a.2
PCI: Found 0000:00:1a.3 [1022/1103] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1a.3
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1a.3
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1a.3
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1a.3
PCI: Found 0000:00:1b.0 [1022/1100] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1b.0
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1b.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1b.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1b.0
PCI: Found 0000:00:1b.1 [1022/1101] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1b.1
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1b.1
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1b.1
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1b.1
PCI: Found 0000:00:1b.2 [1022/1102] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1b.2
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1b.2
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1b.2
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1b.2
PCI: Found 0000:00:1b.3 [1022/1103] 000600 00
PCI: Calling quirk ffffffff802907d0 for 0000:00:1b.3
PCI: Calling quirk ffffffff8028fe00 for 0000:00:1b.3
PCI: Calling quirk ffffffff803cfbf0 for 0000:00:1b.3
PCI: Calling quirk ffffffff803cf6a0 for 0000:00:1b.3
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:09.0, config 050500, pass 0
PCI: Scanning bus 0000:05
PCI: Found 0000:05:06.0 [1002/4752] 000300 00
PCI: Calling quirk ffffffff802907d0 for 0000:05:06.0
PCI: Calling quirk ffffffff8028fe00 for 0000:05:06.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:05:06.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:05:06.0
PCI: Found 0000:05:07.0 [8086/1076] 000200 00
PCI: Calling quirk ffffffff802907d0 for 0000:05:07.0
PCI: Calling quirk ffffffff8028fe00 for 0000:05:07.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:05:07.0
PCI: Calling quirk ffffffff803cf760 for 0000:05:07.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:05:07.0
PCI: Fixups for bus 0000:05
PCI: Transparent bridge - 0000:00:09.0
PCI: Bus scan for 0000:05 returning with max=05
PCI: Scanning behind PCI bridge 0000:00:0b.0, config 040400, pass 0
PCI: Scanning bus 0000:04
PCI: Fixups for bus 0000:04
PCI: Bus scan for 0000:04 returning with max=04
PCI: Scanning behind PCI bridge 0000:00:0c.0, config 030300, pass 0
PCI: Scanning bus 0000:03
PCI: Fixups for bus 0000:03
PCI: Bus scan for 0000:03 returning with max=03
PCI: Scanning behind PCI bridge 0000:00:0d.0, config 020200, pass 0
PCI: Scanning bus 0000:02
PCI: Fixups for bus 0000:02
PCI: Bus scan for 0000:02 returning with max=02
PCI: Scanning behind PCI bridge 0000:00:0e.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [15b3/6278] 000c06 00
PCI: Calling quirk ffffffff802907d0 for 0000:01:00.0
PCI: Calling quirk ffffffff8028fe00 for 0000:01:00.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:01:00.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:01:00.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:09.0, config 050500, pass 1
PCI: Scanning behind PCI bridge 0000:00:0b.0, config 040400, pass 1
PCI: Scanning behind PCI bridge 0000:00:0c.0, config 030300, pass 1
PCI: Scanning behind PCI bridge 0000:00:0d.0, config 020200, pass 1
PCI: Scanning behind PCI bridge 0000:00:0e.0, config 010100, pass 1
PCI: Bus scan for 0000:00 returning with max=05
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Root Bridge [PCIC] (0000:80)
PCI: Probing PCI hardware (bus 80)
PCI: Scanning bus 0000:80
PCI: Found 0000:80:00.0 [10de/005e] 000580 00
PCI: Calling quirk ffffffff802907d0 for 0000:80:00.0
PCI: Calling quirk ffffffff8028fe00 for 0000:80:00.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:80:00.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:80:00.0
PCI: Found 0000:80:01.0 [10de/00d3] 000580 00
PCI: Calling quirk ffffffff802907d0 for 0000:80:01.0
PCI: Calling quirk ffffffff8028fe00 for 0000:80:01.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:80:01.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:80:01.0
PCI: Found 0000:80:02.0 [10de/005a] 000c03 00
PCI: Calling quirk ffffffff802907d0 for 0000:80:02.0
PCI: Calling quirk ffffffff8028fe00 for 0000:80:02.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:80:02.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:80:02.0
PCI: Found 0000:80:0b.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:80:0b.0
PCI: Calling quirk ffffffff8028fe00 for 0000:80:0b.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:80:0b.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:80:0b.0
PCI: Found 0000:80:0c.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:80:0c.0
PCI: Calling quirk ffffffff8028fe00 for 0000:80:0c.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:80:0c.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:80:0c.0
PCI: Found 0000:80:0d.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:80:0d.0
PCI: Calling quirk ffffffff8028fe00 for 0000:80:0d.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:80:0d.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:80:0d.0
PCI: Found 0000:80:0e.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:80:0e.0
PCI: Calling quirk ffffffff8028fe00 for 0000:80:0e.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:80:0e.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:80:0e.0
PCI: Fixups for bus 0000:80
PCI: Scanning behind PCI bridge 0000:80:0b.0, config 848480, pass 0
PCI: Scanning bus 0000:84
PCI: Fixups for bus 0000:84
PCI: Bus scan for 0000:84 returning with max=84
PCI: Scanning behind PCI bridge 0000:80:0c.0, config 838380, pass 0
PCI: Scanning bus 0000:83
PCI: Fixups for bus 0000:83
PCI: Bus scan for 0000:83 returning with max=83
PCI: Scanning behind PCI bridge 0000:80:0d.0, config 828280, pass 0
PCI: Scanning bus 0000:82
PCI: Fixups for bus 0000:82
PCI: Bus scan for 0000:82 returning with max=82
PCI: Scanning behind PCI bridge 0000:80:0e.0, config 818180, pass 0
PCI: Scanning bus 0000:81
PCI: Found 0000:81:00.0 [10de/00f8] 000300 00
PCI: Calling quirk ffffffff802907d0 for 0000:81:00.0
PCI: Calling quirk ffffffff8028fe00 for 0000:81:00.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:81:00.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:81:00.0
PCI: Fixups for bus 0000:81
PCI: Bus scan for 0000:81 returning with max=81
PCI: Scanning behind PCI bridge 0000:80:0b.0, config 848480, pass 1
PCI: Scanning behind PCI bridge 0000:80:0c.0, config 838380, pass 1
PCI: Scanning behind PCI bridge 0000:80:0d.0, config 828280, pass 1
PCI: Scanning behind PCI bridge 0000:80:0e.0, config 818180, pass 1
PCI: Bus scan for 0000:80 returning with max=84
ACPI: PCI Interrupt Routing Table [\_SB_.PCIC._PRT]
ACPI: PCI Root Bridge [PCIA] (0000:40)
PCI: Probing PCI hardware (bus 40)
PCI: Scanning bus 0000:40
PCI: Found 0000:40:00.0 [10de/005e] 000580 00
PCI: Calling quirk ffffffff802907d0 for 0000:40:00.0
PCI: Calling quirk ffffffff8028fe00 for 0000:40:00.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:40:00.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:40:00.0
PCI: Found 0000:40:01.0 [10de/00d3] 000580 00
PCI: Calling quirk ffffffff802907d0 for 0000:40:01.0
PCI: Calling quirk ffffffff8028fe00 for 0000:40:01.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:40:01.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:40:01.0
PCI: Found 0000:40:0b.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:40:0b.0
PCI: Calling quirk ffffffff8028fe00 for 0000:40:0b.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:40:0b.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:40:0b.0
PCI: Found 0000:40:0c.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:40:0c.0
PCI: Calling quirk ffffffff8028fe00 for 0000:40:0c.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:40:0c.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:40:0c.0
PCI: Found 0000:40:0d.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:40:0d.0
PCI: Calling quirk ffffffff8028fe00 for 0000:40:0d.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:40:0d.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:40:0d.0
PCI: Found 0000:40:0e.0 [10de/005d] 000604 01
PCI: Calling quirk ffffffff802907d0 for 0000:40:0e.0
PCI: Calling quirk ffffffff8028fe00 for 0000:40:0e.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:40:0e.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:40:0e.0
PCI: Fixups for bus 0000:40
PCI: Scanning behind PCI bridge 0000:40:0b.0, config 444440, pass 0
PCI: Scanning bus 0000:44
PCI: Fixups for bus 0000:44
PCI: Bus scan for 0000:44 returning with max=44
PCI: Scanning behind PCI bridge 0000:40:0c.0, config 434340, pass 0
PCI: Scanning bus 0000:43
PCI: Fixups for bus 0000:43
PCI: Bus scan for 0000:43 returning with max=43
PCI: Scanning behind PCI bridge 0000:40:0d.0, config 424240, pass 0
PCI: Scanning bus 0000:42
PCI: Fixups for bus 0000:42
PCI: Bus scan for 0000:42 returning with max=42
PCI: Scanning behind PCI bridge 0000:40:0e.0, config 414140, pass 0
PCI: Scanning bus 0000:41
PCI: Found 0000:41:00.0 [10de/00f8] 000300 00
PCI: Calling quirk ffffffff802907d0 for 0000:41:00.0
PCI: Calling quirk ffffffff8028fe00 for 0000:41:00.0
PCI: Calling quirk ffffffff803cfbf0 for 0000:41:00.0
PCI: Calling quirk ffffffff803cf6a0 for 0000:41:00.0
PCI: Fixups for bus 0000:41
PCI: Bus scan for 0000:41 returning with max=41
PCI: Scanning behind PCI bridge 0000:40:0b.0, config 444440, pass 1
PCI: Scanning behind PCI bridge 0000:40:0c.0, config 434340, pass 1
PCI: Scanning behind PCI bridge 0000:40:0d.0, config 424240, pass 1
PCI: Scanning behind PCI bridge 0000:40:0e.0, config 414140, pass 1
PCI: Bus scan for 0000:40 returning with max=44
ACPI: PCI Interrupt Routing Table [\_SB_.PCIA._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *5
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *9
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *11
ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
ACPI: PCI Interrupt Link [LN2A] (IRQs 40 41 42 43) *15
ACPI: PCI Interrupt Link [LN2B] (IRQs 40 41 42 43) *15
ACPI: PCI Interrupt Link [LN2C] (IRQs 40 41 42 43) *15
ACPI: PCI Interrupt Link [LN2D] (IRQs 40 41 42 43) *15
ACPI: PCI Interrupt Link [LU20] (IRQs 44 45 46 47) *15
ACPI: PCI Interrupt Link [LK2N] (IRQs 44 45 46 47) *15
ACPI: PCI Interrupt Link [LT7D] (IRQs 44 45 46 47) *15
ACPI: PCI Interrupt Link [LT2E] (IRQs 44 45 46 47) *15
ACPI: PCI Interrupt Link [LN3A] (IRQs 64 65 66 67) *0, disabled.
ACPI: PCI Interrupt Link [LN3B] (IRQs 64 65 66 67) *0, disabled.
ACPI: PCI Interrupt Link [LN3C] (IRQs 64 65 66 67) *0, disabled.
ACPI: PCI Interrupt Link [LN3D] (IRQs 64 65 66 67) *0, disabled.
ACPI: PCI Interrupt Link [LU30] (IRQs 68 69 70 71) *0, disabled.
ACPI: PCI Interrupt Link [LN4A] (IRQs 88 89 90 91) *0, disabled.
ACPI: PCI Interrupt Link [LN4B] (IRQs 88 89 90 91) *0, disabled.
ACPI: PCI Interrupt Link [LN4C] (IRQs 88 89 90 91) *0, disabled.
ACPI: PCI Interrupt Link [LN4D] (IRQs 88 89 90 91) *0, disabled.
ACPI: PCI Interrupt Link [LN5A] (IRQs 112 113 114 115) *15
ACPI: PCI Interrupt Link [LN5B] (IRQs 112 113 114 115) *15
ACPI: PCI Interrupt Link [LN5C] (IRQs 112 113 114 115) *15
ACPI: PCI Interrupt Link [LN5D] (IRQs 112 113 114 115) *15
ACPI: PCI Interrupt Link [LN6A] (IRQs 136 137 138 139) *15
ACPI: PCI Interrupt Link [LN6B] (IRQs 136 137 138 139) *15
ACPI: PCI Interrupt Link [LN6C] (IRQs 136 137 138 139) *15
ACPI: PCI Interrupt Link [LN6D] (IRQs 136 137 138 139) *15
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:81:00.0
PCI: Cannot allocate resource region 1 of device 0000:81:00.0
PCI: Cannot allocate resource region 2 of device 0000:81:00.0
PCI: Cannot allocate resource region 0 of device 0000:41:00.0
PCI: Cannot allocate resource region 1 of device 0000:41:00.0
PCI: Cannot allocate resource region 2 of device 0000:41:00.0
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 90000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: 00:0c: ioport range 0xa00-0xa7f has been reserved
pnp: match found with the PnP device '00:0d' and the driver 'system'
pnp: match found with the PnP device '00:0e' and the driver 'system'
  got res [bc000000:bcffffff] bus [bc000000:bcffffff] flags 200 for BAR 0 of 0000:81:00.0
PCI: moved device 0000:81:00.0 resource 0 (200) to bc000000
  got res [c0000000:cfffffff] bus [c0000000:cfffffff] flags 1208 for BAR 1 of 0000:81:00.0
PCI: moved device 0000:81:00.0 resource 1 (1208) to c0000000
  got res [bd000000:bdffffff] bus [bd000000:bdffffff] flags 200 for BAR 2 of 0000:81:00.0
PCI: moved device 0000:81:00.0 resource 2 (200) to bd000000
  got res [98000000:98ffffff] bus [98000000:98ffffff] flags 200 for BAR 0 of 0000:41:00.0
PCI: moved device 0000:41:00.0 resource 0 (200) to 98000000
  got res [a0000000:afffffff] bus [a0000000:afffffff] flags 1208 for BAR 1 of 0000:41:00.0
PCI: moved device 0000:41:00.0 resource 1 (1208) to a0000000
  got res [99000000:99ffffff] bus [99000000:99ffffff] flags 200 for BAR 2 of 0000:41:00.0
PCI: moved device 0000:41:00.0 resource 2 (200) to 99000000
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
PCI: Calling quirk ffffffff80290700 for 0000:00:00.0
PCI: Calling quirk ffffffff80290700 for 0000:00:01.0
PCI: Calling quirk ffffffff80290700 for 0000:00:01.1
PCI: Calling quirk ffffffff80290700 for 0000:00:02.0
PCI: Calling quirk ffffffff80290700 for 0000:00:06.0
PCI: Calling quirk ffffffff80290700 for 0000:00:09.0
PCI: Calling quirk ffffffff80290700 for 0000:00:0b.0
PCI: Calling quirk ffffffff80290700 for 0000:00:0c.0
PCI: Calling quirk ffffffff80290700 for 0000:00:0d.0
PCI: Calling quirk ffffffff80290700 for 0000:00:0e.0
PCI: Calling quirk ffffffff80290700 for 0000:00:18.0
PCI: Calling quirk ffffffff80290700 for 0000:00:18.1
PCI: Calling quirk ffffffff80290700 for 0000:00:18.2
PCI: Calling quirk ffffffff80290700 for 0000:00:18.3
PCI: Calling quirk ffffffff80290700 for 0000:00:19.0
PCI: Calling quirk ffffffff80290700 for 0000:00:19.1
PCI: Calling quirk ffffffff80290700 for 0000:00:19.2
PCI: Calling quirk ffffffff80290700 for 0000:00:19.3
PCI: Calling quirk ffffffff80290700 for 0000:00:1a.0
PCI: Calling quirk ffffffff80290700 for 0000:00:1a.1
PCI: Calling quirk ffffffff80290700 for 0000:00:1a.2
PCI: Calling quirk ffffffff80290700 for 0000:00:1a.3
PCI: Calling quirk ffffffff80290700 for 0000:00:1b.0
PCI: Calling quirk ffffffff80290700 for 0000:00:1b.1
PCI: Calling quirk ffffffff80290700 for 0000:00:1b.2
PCI: Calling quirk ffffffff80290700 for 0000:00:1b.3
PCI: Calling quirk ffffffff80290700 for 0000:05:06.0
PCI: Calling quirk ffffffff80290700 for 0000:05:07.0
PCI: Calling quirk ffffffff80290700 for 0000:01:00.0
PCI: Calling quirk ffffffff80290700 for 0000:80:00.0
PCI: Calling quirk ffffffff80290700 for 0000:80:01.0
PCI: Calling quirk ffffffff80290700 for 0000:80:02.0
PCI: Calling quirk ffffffff80290700 for 0000:80:0b.0
PCI: Calling quirk ffffffff80290700 for 0000:80:0c.0
PCI: Calling quirk ffffffff80290700 for 0000:80:0d.0
PCI: Calling quirk ffffffff80290700 for 0000:80:0e.0
PCI: Calling quirk ffffffff80290700 for 0000:81:00.0
PCI: Calling quirk ffffffff80290700 for 0000:40:00.0
PCI: Calling quirk ffffffff80290700 for 0000:40:01.0
PCI: Calling quirk ffffffff80290700 for 0000:40:0b.0
PCI: Calling quirk ffffffff80290700 for 0000:40:0c.0
PCI: Calling quirk ffffffff80290700 for 0000:40:0d.0
PCI: Calling quirk ffffffff80290700 for 0000:40:0e.0
PCI: Calling quirk ffffffff80290700 for 0000:41:00.0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:80:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:80:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:80:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:80:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:40:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:40:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:40:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:40:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
ipmi message handler version v33
ipmi device interface version v33
IPMI System Interface driver version v33, KCS version v33, SMIC version v33, BT version v33
ipmi_si: Found SMBIOS-specified state machine at I/O address 0x62, slave address 0x20
 Could not set up I/O space
Trying to free nonexistent resource <00000062-00000063>
ipmi_si: Unable to find any System Interface(s)
Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot version v33.
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f12:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:05' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:06' and the driver 'serial'
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 4 RAM disks of 65536K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 6.0.54-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 19
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [LNKB] -> GSI 19 (level, low) -> IRQ 19
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
pcnet32.c:v1.30j 29.04.2005 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: FUJITSU MHT2040AS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3
usbmon: debugs is not available
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 22, io mem 0x968ff000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ACPI: PCI Interrupt Link [LU30] enabled at IRQ 71
ACPI: PCI Interrupt 0000:80:02.0[A] -> Link [LU30] -> GSI 71 (level, low) -> IRQ 71
PCI: Setting latency timer of device 0000:80:02.0 to 64
ohci_hcd 0000:80:02.0: OHCI Host Controller
ohci_hcd 0000:80:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:80:02.0: irq 71, io mem 0xbfeff000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v2.2
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
ib_mthca: Mellanox InfiniBand HCA driver v0.06-pre (November 8, 2004)
ib_mthca: Initializing  (0000:01:00.0)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKC] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:01:00.0 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 65536 buckets, 1024Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 344 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.6 loaded successfully
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PS2K PS2M USB0 USB1 P0P1 P0P2 P0P3 P0P4 P0P5 USB3 BR84 BR83 BR82 BR81 BRC4 BRC3 BRC2 BRC1 PWRB 
ACPI: (supports S0 S1 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 248k freed
EXT3 FS on hda3, internal journal
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
Adding 1052248k swap on /dev/hda2.  Priority:42 extents:1
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex

--------------070005030003070401030202
Content-Type: text/plain;
 name="lspci-vvx-2.6.12.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-vvx-2.6.12.txt"

0000:00:00.0 Memory controller: nVidia Corporation: Unknown device 005e (rev a3)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #08 [01e0]
	Capabilities: [e0] #08 [a801]
00: de 10 5e 00 06 01 b0 00 a3 00 80 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00

0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 0051 (rev a3)
	Subsystem: nVidia Corporation: Unknown device cb84
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: de 10 51 00 0f 00 a0 00 a3 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:01.1 SMBus: nVidia Corporation: Unknown device 0052 (rev a2)
	Subsystem: nVidia Corporation: Unknown device cb84
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 9000
	Region 4: I/O ports at 4c00 [size=64]
	Region 5: I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 52 00 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 4c 00 00 41 4c 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 01 03 01

0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 005a (rev a2) (prog-if 10 [OHCI])
	Subsystem: nVidia Corporation: Unknown device cb84
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 968ff000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 5a 00 07 00 b0 00 a2 10 03 0c 00 00 00 00
10: 00 f0 8f 96 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01

0000:00:06.0 IDE interface: nVidia Corporation: Unknown device 0053 (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: nVidia Corporation: Unknown device cb84
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at 6000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 53 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 60 00 00 00 00 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01

0000:00:09.0 PCI bridge: nVidia Corporation: Unknown device 005c (rev a2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
	I/O behind bridge: 0000d000-0000ffff
	Memory behind bridge: 94700000-967fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: de 10 5c 00 07 01 a0 00 a2 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 05 05 80 d0 f0 80 a2
20: 70 94 70 96 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:00:0c.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:00:0d.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: 94500000-946fffff
	Prefetchable memory behind bridge: 0000000096900000-0000000097800000
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 01 00 00
20: 50 94 60 94 91 96 81 97 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 InfiniBand: Mellanox Technology MT25208 InfiniHost III Ex HCA (Tavor compatibility mode) (rev a0)
	Subsystem: Mellanox Technology MT25208 InfiniHost III Ex HCA (Tavor compatibility mode)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at 94600000 (64-bit, non-prefetchable)
	Region 2: Memory at 97000000 (64-bit, prefetchable) [size=8M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Vital Product Data
	Capabilities: [90] Message Signalled Interrupts: 64bit+ Queue=0/5 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [84] #11 [001f]
	Capabilities: [60] #10 [0001]
00: b3 15 78 62 06 01 10 00 a0 00 06 0c 10 00 00 00
10: 04 00 60 94 00 00 00 00 0c 00 00 97 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b3 15 78 62
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 01 00 00

0000:05:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 95000000 (32-bit, non-prefetchable) [size=967c0000]
	Region 1: I/O ports at f000 [size=256]
	Region 2: Memory at 967ff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 47 87 00 90 02 27 00 00 03 10 40 00 00
10: 00 00 00 95 01 f0 00 00 00 f0 7f 96 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 08 80
30: 00 00 7c 96 5c 00 00 00 00 00 00 00 0a 01 08 00

0000:05:07.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller (rev 05)
	Subsystem: Giga-byte Technology: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 967a0000 (32-bit, non-prefetchable)
	Region 2: I/O ports at fc00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-00: 86 80 76 10 17 01 30 02 05 00 00 02 10 40 00 00
10: 00 00 7a 96 00 00 00 00 01 fc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 00 30
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 ff 00

0000:40:00.0 Memory controller: nVidia Corporation: Unknown device 005e (rev a3)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #08 [01e0]
	Capabilities: [e0] #08 [a800]
00: de 10 5e 00 06 01 b0 00 a3 00 80 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00

0000:40:01.0 Memory controller: nVidia Corporation: Unknown device 00d3 (rev a3)
	Subsystem: nVidia Corporation: Unknown device cb84
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 1: Memory at 9bbff000 (32-bit, non-prefetchable) [size=4K]
00: de 10 d3 00 0f 00 a0 00 a3 00 80 05 00 00 80 00
10: 00 00 00 00 00 f0 bf 9b 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:40:0b.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 10
	Bus: primary=40, secondary=44, subordinate=44, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 40 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 40 44 44 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:40:0c.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 10
	Bus: primary=40, secondary=43, subordinate=43, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 40 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 40 43 43 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:40:0d.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=40, secondary=42, subordinate=42, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 40 42 42 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:40:0e.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=40, secondary=41, subordinate=41, sec-latency=0
	Memory behind bridge: 97a00000-9bafffff
	Prefetchable memory behind bridge: 000000009bc00000-00000000bbb00000
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 40 41 41 00 f1 01 00 00
20: a0 97 a0 9b c1 9b b1 bb 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:41:00.0 VGA compatible controller: nVidia Corporation NV45GL [Quadro FX 3400] (rev a2) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 029b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 98000000 (32-bit, non-prefetchable) [disabled] [size=fffe0000]
	Region 1: Memory at a0000000 (32-bit, prefetchable) [disabled] [size=256M]
	Region 2: Memory at 99000000 (32-bit, non-prefetchable) [disabled] [size=16M]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0011]
00: de 10 f8 00 00 00 10 00 a2 00 00 03 00 00 00 00
10: 00 00 00 98 08 00 00 a0 00 00 00 99 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 9b 02
30: 00 00 fe ff 60 00 00 00 00 00 00 00 00 01 00 00

0000:80:00.0 Memory controller: nVidia Corporation: Unknown device 005e (rev a3)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #08 [01e0]
	Capabilities: [e0] #08 [a800]
00: de 10 5e 00 06 01 b0 00 a3 00 80 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00

0000:80:01.0 Memory controller: nVidia Corporation: Unknown device 00d3 (rev a3)
	Subsystem: nVidia Corporation: Unknown device cb84
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 1: Memory at bfefe000 (32-bit, non-prefetchable) [size=4K]
00: de 10 d3 00 0f 00 a0 00 a3 00 80 05 00 00 80 00
10: 00 00 00 00 00 e0 ef bf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:80:02.0 USB Controller: nVidia Corporation: Unknown device 005a (rev a2) (prog-if 10 [OHCI])
	Subsystem: nVidia Corporation: Unknown device cb84
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 71
	Region 0: Memory at bfeff000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 5a 00 07 00 b0 00 a2 10 03 0c 00 00 00 00
10: 00 f0 ef bf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01

0000:80:0b.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 10
	Bus: primary=80, secondary=84, subordinate=84, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 40 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 80 84 84 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:80:0c.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 10
	Bus: primary=80, secondary=83, subordinate=83, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 40 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 80 83 83 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:80:0d.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=80, secondary=82, subordinate=82, sec-latency=0
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 80 82 82 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:80:0e.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=80, secondary=81, subordinate=81, sec-latency=0
	Memory behind bridge: bbd00000-bfdfffff
	Prefetchable memory behind bridge: 00000000bff00000-00000000dfe00000
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]
00: de 10 5d 00 06 01 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 80 81 81 00 f1 01 00 00
20: d0 bb d0 bf f1 bf e1 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 07 00

0000:81:00.0 VGA compatible controller: nVidia Corporation NV45GL [Quadro FX 3400] (rev a2) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 029b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at bc000000 (32-bit, non-prefetchable) [disabled] [size=fffe0000]
	Region 1: Memory at c0000000 (32-bit, prefetchable) [disabled] [size=256M]
	Region 2: Memory at bd000000 (32-bit, non-prefetchable) [disabled] [size=16M]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0011]
00: de 10 f8 00 00 00 10 00 a2 00 00 03 00 00 00 00
10: 00 00 00 bc 08 00 00 c0 00 00 00 bd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 9b 02
30: 00 00 fe ff 60 00 00 00 00 00 00 00 00 01 00 00


--------------070005030003070401030202--
