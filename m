Return-Path: <linux-kernel-owner+w=401wt.eu-S964990AbWLOVGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWLOVGW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWLOVGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:06:22 -0500
Received: from fb2.tech.numericable.fr ([82.216.111.50]:59757 "EHLO
	fb2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964991AbWLOVGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:06:17 -0500
X-Greylist: delayed 1593 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 16:06:16 EST
Date: Fri, 15 Dec 2006 21:39:36 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com
Subject: Re: 2.6.20-rc1-mm1
Message-ID: <20061215203936.GA2202@localhost.localdomain>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With this new kernel, I notice two messages I do not have with
2.6.19-rc6-mm2 :

Dec 15 20:00:47 brouette kernel: Filesystem "sdb9": Disabling barriers,trial barrier write failed
Dec 15 20:00:47 brouette kernel: Filesystem "sda5": Disabling barriers,trial barrier write failed

Nothing changed in the config between the two, and going back to
2.6.19-rc6-mm2 do not give the messages.

Also, I got panics when unmounting reiser4 filesystems with
2.6.20-rc1-mm1 but I guess this is related to your waring about reiser4
being broken in 2.6.19-mm1 (even if it is not listed in notes for
2.6.20-rc1-mm1)... I attach dmesg and config, but the reiser4 panics did
not get logged and I am not able to reboot on 2.6.20-rc1-mm1 right now.
For the moment, I mainly wanted to report the xfs messages which seems
a bit suspect.

-- 
Damien Wyart

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Dec 15 20:00:47 brouette kernel: Linux version 2.6.20-rc1-mm1-15122006dw (root@brouette) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #0 SMP Fri Dec 15 19:08:40 CET 2006
Dec 15 20:00:47 brouette kernel: BIOS-provided physical RAM map:
Dec 15 20:00:47 brouette kernel: sanitize start
Dec 15 20:00:47 brouette kernel: sanitize end
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 00000000000a0000 type: 1
Dec 15 20:00:47 brouette kernel: copy_e820_map() type is E820_RAM
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 0000000000100000 size: 000000007fe74000 end: 000000007ff74000 type: 1
Dec 15 20:00:47 brouette kernel: copy_e820_map() type is E820_RAM
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 000000007ff74000 size: 0000000000002000 end: 000000007ff76000 type: 4
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 000000007ff76000 size: 0000000000021000 end: 000000007ff97000 type: 3
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 000000007ff97000 size: 0000000000069000 end: 0000000080000000 type: 2
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 00000000fecf0000 size: 0000000000001000 end: 00000000fecf1000 type: 2
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 00000000fed20000 size: 0000000000070000 end: 00000000fed90000 type: 2
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 00000000fee00000 size: 0000000000010000 end: 00000000fee10000 type: 2
Dec 15 20:00:47 brouette kernel: copy_e820_map() start: 00000000ffb00000 size: 0000000000500000 end: 0000000100000000 type: 2
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 0000000000100000 - 000000007ff74000 (usable)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 000000007ff74000 - 000000007ff76000 (ACPI NVS)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 000000007ff76000 - 000000007ff97000 (ACPI data)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 000000007ff97000 - 0000000080000000 (reserved)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Dec 15 20:00:47 brouette kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Dec 15 20:00:47 brouette kernel: 1151MB HIGHMEM available.
Dec 15 20:00:47 brouette kernel: 896MB LOWMEM available.
Dec 15 20:00:47 brouette kernel: found SMP MP-table at 000fe710
Dec 15 20:00:47 brouette kernel: Entering add_active_range(0, 0, 524148) 0 entries of 256 used
Dec 15 20:00:47 brouette kernel: sizeof(struct page) = 32
Dec 15 20:00:47 brouette kernel: Zone PFN ranges:
Dec 15 20:00:47 brouette kernel:   DMA             0 ->     4096
Dec 15 20:00:47 brouette kernel:   Normal       4096 ->   229376
Dec 15 20:00:47 brouette kernel:   HighMem    229376 ->   524148
Dec 15 20:00:47 brouette kernel: early_node_map[1] active PFN ranges
Dec 15 20:00:47 brouette kernel:     0:        0 ->   524148
Dec 15 20:00:47 brouette kernel: On node 0 totalpages: 524148
Dec 15 20:00:47 brouette kernel: Node 0 memmap at 0xc1000000 size 16777216 first pfn 0xc1000000
Dec 15 20:00:47 brouette kernel:   DMA zone: 32 pages used for memmap
Dec 15 20:00:47 brouette kernel:   DMA zone: 0 pages reserved
Dec 15 20:00:47 brouette kernel:   DMA zone: 4064 pages, LIFO batch:0
Dec 15 20:00:47 brouette kernel:   Normal zone: 1760 pages used for memmap
Dec 15 20:00:47 brouette kernel:   Normal zone: 223520 pages, LIFO batch:31
Dec 15 20:00:47 brouette kernel:   HighMem zone: 2302 pages used for memmap
Dec 15 20:00:47 brouette kernel:   HighMem zone: 292470 pages, LIFO batch:31
Dec 15 20:00:47 brouette kernel: DMI 2.3 present.
Dec 15 20:00:47 brouette kernel: ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
Dec 15 20:00:47 brouette kernel: ACPI: RSDT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1ca
Dec 15 20:00:47 brouette kernel: ACPI: FADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1fe
Dec 15 20:00:47 brouette kernel: ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc929b
Dec 15 20:00:47 brouette kernel: ACPI: MADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd272
Dec 15 20:00:47 brouette kernel: ACPI: BOOT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd2de
Dec 15 20:00:47 brouette kernel: ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
Dec 15 20:00:47 brouette kernel: ACPI: PM-Timer IO Port: 0x808
Dec 15 20:00:47 brouette kernel: ACPI: Local APIC address 0xfee00000
Dec 15 20:00:47 brouette kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Dec 15 20:00:47 brouette kernel: Processor #0 15:3 APIC version 20
Dec 15 20:00:47 brouette kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Dec 15 20:00:47 brouette kernel: Processor #1 15:3 APIC version 20
Dec 15 20:00:47 brouette kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
Dec 15 20:00:47 brouette kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
Dec 15 20:00:47 brouette kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Dec 15 20:00:47 brouette kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Dec 15 20:00:47 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 15 20:00:47 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Dec 15 20:00:47 brouette kernel: ACPI: IRQ0 used by override.
Dec 15 20:00:47 brouette kernel: ACPI: IRQ2 used by override.
Dec 15 20:00:47 brouette kernel: ACPI: IRQ9 used by override.
Dec 15 20:00:47 brouette kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Dec 15 20:00:47 brouette kernel: Using ACPI (MADT) for SMP configuration information
Dec 15 20:00:47 brouette kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Dec 15 20:00:47 brouette kernel: Detected 2992.645 MHz processor.
Dec 15 20:00:47 brouette kernel: Built 1 zonelists.  Total pages: 520054
Dec 15 20:00:47 brouette kernel: Kernel command line: root=/dev/sdb2 ro vga=0x31B selinux=0 elevator=cfq video=vesafb:mtrr:3 
Dec 15 20:00:47 brouette kernel: mapped APIC to ffffd000 (fee00000)
Dec 15 20:00:47 brouette kernel: mapped IOAPIC to ffffc000 (fec00000)
Dec 15 20:00:47 brouette kernel: Enabling fast FPU save and restore... done.
Dec 15 20:00:47 brouette kernel: Enabling unmasked SIMD FPU exception support... done.
Dec 15 20:00:47 brouette kernel: Initializing CPU#0
Dec 15 20:00:47 brouette kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Dec 15 20:00:47 brouette kernel: Console: colour dummy device 80x25
Dec 15 20:00:47 brouette kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 15 20:00:47 brouette kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 15 20:00:47 brouette kernel: Memory: 2073432k/2096592k available (3181k kernel code, 21936k reserved, 986k data, 200k init, 1179088k highmem)
Dec 15 20:00:47 brouette kernel: virtual kernel memory layout:
Dec 15 20:00:47 brouette kernel:     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
Dec 15 20:00:47 brouette kernel:     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
Dec 15 20:00:47 brouette kernel:     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
Dec 15 20:00:47 brouette kernel:     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
Dec 15 20:00:47 brouette kernel:       .init : 0xc051b000 - 0xc054d000   ( 200 kB)
Dec 15 20:00:47 brouette kernel:       .data : 0xc041b6dd - 0xc051208c   ( 986 kB)
Dec 15 20:00:47 brouette kernel:       .text : 0xc0100000 - 0xc041b6dd   (3181 kB)
Dec 15 20:00:47 brouette kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dec 15 20:00:47 brouette kernel: Clock event device pit configured with caps set: 07
Dec 15 20:00:47 brouette kernel: Calibrating delay using timer specific routine.. 5987.36 BogoMIPS (lpj=2993684)
Dec 15 20:00:47 brouette kernel: Mount-cache hash table entries: 512
Dec 15 20:00:47 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Dec 15 20:00:47 brouette kernel: monitor/mwait feature present.
Dec 15 20:00:47 brouette kernel: using mwait in idle threads.
Dec 15 20:00:47 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Dec 15 20:00:47 brouette kernel: CPU: L2 cache: 1024K
Dec 15 20:00:47 brouette kernel: CPU: Physical Processor ID: 0
Dec 15 20:00:47 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00003180 0000041d 00000000 00000000
Dec 15 20:00:47 brouette kernel: Intel machine check architecture supported.
Dec 15 20:00:47 brouette kernel: Intel machine check reporting enabled on CPU#0.
Dec 15 20:00:47 brouette kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Dec 15 20:00:47 brouette kernel: CPU0: Thermal monitoring enabled
Dec 15 20:00:47 brouette kernel: Checking 'hlt' instruction... OK.
Dec 15 20:00:47 brouette kernel: Freeing SMP alternatives: 16k freed
Dec 15 20:00:47 brouette kernel: ACPI: Core revision 20060707
Dec 15 20:00:47 brouette kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Dec 15 20:00:47 brouette kernel: Booting processor 1/1 eip 2000
Dec 15 20:00:47 brouette kernel: Initializing CPU#1
Dec 15 20:00:47 brouette kernel: Calibrating delay using timer specific routine.. 5984.19 BogoMIPS (lpj=2992098)
Dec 15 20:00:47 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Dec 15 20:00:47 brouette kernel: monitor/mwait feature present.
Dec 15 20:00:47 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Dec 15 20:00:47 brouette kernel: CPU: L2 cache: 1024K
Dec 15 20:00:47 brouette kernel: CPU: Physical Processor ID: 0
Dec 15 20:00:47 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00003180 0000041d 00000000 00000000
Dec 15 20:00:47 brouette kernel: Intel machine check architecture supported.
Dec 15 20:00:47 brouette kernel: Intel machine check reporting enabled on CPU#1.
Dec 15 20:00:47 brouette kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Dec 15 20:00:47 brouette kernel: CPU1: Thermal monitoring enabled
Dec 15 20:00:47 brouette kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Dec 15 20:00:47 brouette kernel: Total of 2 processors activated (11971.56 BogoMIPS).
Dec 15 20:00:47 brouette kernel: ENABLING IO-APIC IRQs
Dec 15 20:00:47 brouette kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Dec 15 20:00:47 brouette kernel: Clock event device pit new caps set: 01
Dec 15 20:00:47 brouette kernel: Clock event device lapic configured with caps set: 06
Dec 15 20:00:47 brouette kernel: checking TSC synchronization across 2 CPUs: passed.
Dec 15 20:00:47 brouette kernel: Clock event device pit new caps set: 01
Dec 15 20:00:47 brouette kernel: Clock event device lapic configured with caps set: 06
Dec 15 20:00:47 brouette kernel: Brought up 2 CPUs
Dec 15 20:00:47 brouette kernel: migration_cost=16
Dec 15 20:00:47 brouette kernel: NET: Registered protocol family 16
Dec 15 20:00:47 brouette kernel: ACPI: bus type pci registered
Dec 15 20:00:47 brouette kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=2
Dec 15 20:00:47 brouette kernel: PCI: Using configuration type 1
Dec 15 20:00:47 brouette kernel: Setting up standard PCI resources
Dec 15 20:00:47 brouette kernel: ACPI: Interpreter enabled
Dec 15 20:00:47 brouette kernel: ACPI: Using IOAPIC for interrupt routing
Dec 15 20:00:47 brouette kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Dec 15 20:00:47 brouette kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Dec 15 20:00:47 brouette kernel: PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
Dec 15 20:00:47 brouette kernel: PCI quirk: region 0880-08bf claimed by ICH4 GPIO
Dec 15 20:00:47 brouette kernel: Boot video device is 0000:01:00.0
Dec 15 20:00:47 brouette kernel: PCI: Firmware left 0000:02:08.0 e100 interrupts enabled, disabling
Dec 15 20:00:47 brouette kernel: PCI: Transparent bridge - 0000:00:1e.0
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Dec 15 20:00:47 brouette kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Dec 15 20:00:47 brouette kernel: pnp: PnP ACPI init
Dec 15 20:00:47 brouette kernel: pnp: PnP ACPI: found 12 devices
Dec 15 20:00:47 brouette kernel: SCSI subsystem initialized
Dec 15 20:00:47 brouette kernel: libata version 2.00 loaded.
Dec 15 20:00:47 brouette kernel: usbcore: registered new interface driver usbfs
Dec 15 20:00:47 brouette kernel: usbcore: registered new interface driver hub
Dec 15 20:00:47 brouette kernel: usbcore: registered new device driver usb
Dec 15 20:00:47 brouette kernel: PCI: Using ACPI for IRQ routing
Dec 15 20:00:47 brouette kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Dec 15 20:00:47 brouette kernel: pnp: 00:0b: ioport range 0x800-0x85f could not be reserved
Dec 15 20:00:47 brouette kernel: pnp: 00:0b: ioport range 0xc00-0xc7f has been reserved
Dec 15 20:00:47 brouette kernel: pnp: 00:0b: ioport range 0x860-0x8ff could not be reserved
Dec 15 20:00:47 brouette kernel: PCI: Bridge: 0000:00:01.0
Dec 15 20:00:47 brouette kernel:   IO window: disabled.
Dec 15 20:00:47 brouette kernel:   MEM window: fd000000-feafffff
Dec 15 20:00:47 brouette kernel:   PREFETCH window: f0000000-f7ffffff
Dec 15 20:00:47 brouette kernel: PCI: Bridge: 0000:00:1e.0
Dec 15 20:00:47 brouette kernel:   IO window: d000-dfff
Dec 15 20:00:47 brouette kernel:   MEM window: fcf00000-fcffffff
Dec 15 20:00:47 brouette kernel:   PREFETCH window: disabled.
Dec 15 20:00:47 brouette kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Dec 15 20:00:47 brouette kernel: NET: Registered protocol family 2
Dec 15 20:00:47 brouette kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec 15 20:00:47 brouette kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Dec 15 20:00:47 brouette kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Dec 15 20:00:47 brouette kernel: TCP: Hash tables configured (established 131072 bind 65536)
Dec 15 20:00:47 brouette kernel: TCP reno registered
Dec 15 20:00:47 brouette kernel: Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Dec 15 20:00:47 brouette kernel: Simple Boot Flag at 0x7a set to 0x1
Dec 15 20:00:47 brouette kernel: Machine check exception polling timer started.
Dec 15 20:00:47 brouette kernel: highmem bounce pool size: 64 pages
Dec 15 20:00:47 brouette kernel: Loading Reiser4. See www.namesys.com for a description of Reiser4.
Dec 15 20:00:47 brouette kernel: JFS: nTxBlock = 8192, nTxLock = 65536
Dec 15 20:00:47 brouette kernel: SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
Dec 15 20:00:47 brouette kernel: io scheduler noop registered
Dec 15 20:00:47 brouette kernel: io scheduler cfq registered (default)
Dec 15 20:00:47 brouette kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xf8d00000, using 10240k, total 131072k
Dec 15 20:00:47 brouette kernel: vesafb: mode is 1280x1024x32, linelength=5120, pages=0
Dec 15 20:00:47 brouette kernel: vesafb: protected mode interface info at c000:f080
Dec 15 20:00:47 brouette kernel: vesafb: pmi: set display start = c00cf0b6, set palette = c00cf120
Dec 15 20:00:47 brouette kernel: vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
Dec 15 20:00:47 brouette kernel: vesafb: scrolling: redraw
Dec 15 20:00:47 brouette kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Dec 15 20:00:47 brouette kernel: Console: switching to colour frame buffer device 160x64
Dec 15 20:00:47 brouette kernel: fb0: VESA VGA frame buffer device
Dec 15 20:00:47 brouette kernel: input: Power Button (FF) as /class/input/input0
Dec 15 20:00:47 brouette kernel: ACPI: Power Button (FF) [PWRF]
Dec 15 20:00:47 brouette kernel: input: Power Button (CM) as /class/input/input1
Dec 15 20:00:47 brouette kernel: ACPI: Power Button (CM) [VBTN]
Dec 15 20:00:47 brouette kernel: Real Time Clock Driver v1.12ac
Dec 15 20:00:47 brouette kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
Dec 15 20:00:47 brouette kernel: e100: Copyright(c) 1999-2006 Intel Corporation
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 16
Dec 15 20:00:47 brouette kernel: e100: eth0: e100_probe: addr 0xfcfff000, irq 16, MAC addr 00:0C:F1:B6:BA:54
Dec 15 20:00:47 brouette kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec 15 20:00:47 brouette kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec 15 20:00:47 brouette kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
Dec 15 20:00:47 brouette kernel: ICH5: chipset revision 2
Dec 15 20:00:47 brouette kernel: ICH5: not 100%% native mode: will probe irqs later
Dec 15 20:00:47 brouette kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Dec 15 20:00:47 brouette kernel: Probing IDE interface ide1...
Dec 15 20:00:47 brouette kernel: hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
Dec 15 20:00:47 brouette kernel: hdd: SAMSUNG CD-R/RW SW-252S, ATAPI CD/DVD-ROM drive
Dec 15 20:00:47 brouette kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 15 20:00:47 brouette kernel: hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Dec 15 20:00:47 brouette kernel: Uniform CD-ROM driver Revision: 3.20
Dec 15 20:00:47 brouette kernel: hdd: ATAPI 16X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Dec 15 20:00:47 brouette kernel: ata_piix 0000:00:1f.2: version 2.00ac7
Dec 15 20:00:47 brouette kernel: ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
Dec 15 20:00:47 brouette kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Dec 15 20:00:47 brouette kernel: ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
Dec 15 20:00:47 brouette kernel: ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
Dec 15 20:00:47 brouette kernel: scsi0 : ata_piix
Dec 15 20:00:47 brouette kernel: ata1.00: ATA-6, max UDMA/133, 144531250 sectors: LBA48 
Dec 15 20:00:47 brouette kernel: ata1.00: ata1: dev 0 multi count 8
Dec 15 20:00:47 brouette kernel: ata1.00: applying bridge limits
Dec 15 20:00:47 brouette kernel: ata1.00: configured for UDMA/100
Dec 15 20:00:47 brouette kernel: scsi1 : ata_piix
Dec 15 20:00:47 brouette kernel: ata2.00: ATA-6, max UDMA/133, 144531250 sectors: LBA48 
Dec 15 20:00:47 brouette kernel: ata2.00: ata2: dev 0 multi count 8
Dec 15 20:00:47 brouette kernel: ata2.00: applying bridge limits
Dec 15 20:00:47 brouette kernel: ata2.00: configured for UDMA/100
Dec 15 20:00:47 brouette kernel: scsi 0:0:0:0: Direct-Access     ATA      WDC WD740GD-75FL 21.0 PQ: 0 ANSI: 5
Dec 15 20:00:47 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Dec 15 20:00:47 brouette kernel: sda: Write Protect is off
Dec 15 20:00:47 brouette kernel: sda: Mode Sense: 00 3a 00 00
Dec 15 20:00:47 brouette kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 15 20:00:47 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Dec 15 20:00:47 brouette kernel: sda: Write Protect is off
Dec 15 20:00:47 brouette kernel: sda: Mode Sense: 00 3a 00 00
Dec 15 20:00:47 brouette kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 15 20:00:47 brouette kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Dec 15 20:00:47 brouette kernel: sd 0:0:0:0: Attached scsi disk sda
Dec 15 20:00:47 brouette kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Dec 15 20:00:47 brouette kernel: scsi 1:0:0:0: Direct-Access     ATA      WDC WD740GD-75FL 21.0 PQ: 0 ANSI: 5
Dec 15 20:00:47 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Dec 15 20:00:47 brouette kernel: sdb: Write Protect is off
Dec 15 20:00:47 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Dec 15 20:00:47 brouette kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 15 20:00:47 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Dec 15 20:00:47 brouette kernel: sdb: Write Protect is off
Dec 15 20:00:47 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Dec 15 20:00:47 brouette kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 15 20:00:47 brouette kernel:  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 >
Dec 15 20:00:47 brouette kernel: sd 1:0:0:0: Attached scsi disk sdb
Dec 15 20:00:47 brouette kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
Dec 15 20:00:47 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Dec 15 20:00:47 brouette kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Dec 15 20:00:47 brouette kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Dec 15 20:00:47 brouette kernel: ehci_hcd 0000:00:1d.7: debug port 1
Dec 15 20:00:47 brouette kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Dec 15 20:00:47 brouette kernel: ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffa80800
Dec 15 20:00:47 brouette kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Dec 15 20:00:47 brouette kernel: usb usb1: new device found, idVendor=0000, idProduct=0000
Dec 15 20:00:47 brouette kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Dec 15 20:00:47 brouette kernel: usb usb1: Product: EHCI Host Controller
Dec 15 20:00:47 brouette kernel: usb usb1: Manufacturer: Linux 2.6.20-rc1-mm1-15122006dw ehci_hcd
Dec 15 20:00:47 brouette kernel: usb usb1: SerialNumber: 0000:00:1d.7
Dec 15 20:00:47 brouette kernel: usb usb1: configuration #1 chosen from 1 choice
Dec 15 20:00:47 brouette kernel: hub 1-0:1.0: USB hub found
Dec 15 20:00:47 brouette kernel: hub 1-0:1.0: 8 ports detected
Dec 15 20:00:47 brouette kernel: USB Universal Host Controller Interface driver v3.0
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 19
Dec 15 20:00:47 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.0: irq 19, io base 0x0000ff80
Dec 15 20:00:47 brouette kernel: usb usb2: new device found, idVendor=0000, idProduct=0000
Dec 15 20:00:47 brouette kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Dec 15 20:00:47 brouette kernel: usb usb2: Product: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: usb usb2: Manufacturer: Linux 2.6.20-rc1-mm1-15122006dw uhci_hcd
Dec 15 20:00:47 brouette kernel: usb usb2: SerialNumber: 0000:00:1d.0
Dec 15 20:00:47 brouette kernel: usb usb2: configuration #1 chosen from 1 choice
Dec 15 20:00:47 brouette kernel: hub 2-0:1.0: USB hub found
Dec 15 20:00:47 brouette kernel: hub 2-0:1.0: 2 ports detected
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
Dec 15 20:00:47 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.1: irq 20, io base 0x0000ff60
Dec 15 20:00:47 brouette kernel: usb usb3: new device found, idVendor=0000, idProduct=0000
Dec 15 20:00:47 brouette kernel: usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
Dec 15 20:00:47 brouette kernel: usb usb3: Product: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: usb usb3: Manufacturer: Linux 2.6.20-rc1-mm1-15122006dw uhci_hcd
Dec 15 20:00:47 brouette kernel: usb usb3: SerialNumber: 0000:00:1d.1
Dec 15 20:00:47 brouette kernel: usb usb3: configuration #1 chosen from 1 choice
Dec 15 20:00:47 brouette kernel: hub 3-0:1.0: USB hub found
Dec 15 20:00:47 brouette kernel: hub 3-0:1.0: 2 ports detected
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
Dec 15 20:00:47 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.2: irq 17, io base 0x0000ff40
Dec 15 20:00:47 brouette kernel: usb usb4: new device found, idVendor=0000, idProduct=0000
Dec 15 20:00:47 brouette kernel: usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
Dec 15 20:00:47 brouette kernel: usb usb4: Product: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: usb usb4: Manufacturer: Linux 2.6.20-rc1-mm1-15122006dw uhci_hcd
Dec 15 20:00:47 brouette kernel: usb usb4: SerialNumber: 0000:00:1d.2
Dec 15 20:00:47 brouette kernel: usb usb4: configuration #1 chosen from 1 choice
Dec 15 20:00:47 brouette kernel: hub 4-0:1.0: USB hub found
Dec 15 20:00:47 brouette kernel: hub 4-0:1.0: 2 ports detected
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 19
Dec 15 20:00:47 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Dec 15 20:00:47 brouette kernel: uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ff20
Dec 15 20:00:47 brouette kernel: usb usb5: new device found, idVendor=0000, idProduct=0000
Dec 15 20:00:47 brouette kernel: usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
Dec 15 20:00:47 brouette kernel: usb usb5: Product: UHCI Host Controller
Dec 15 20:00:47 brouette kernel: usb usb5: Manufacturer: Linux 2.6.20-rc1-mm1-15122006dw uhci_hcd
Dec 15 20:00:47 brouette kernel: usb usb5: SerialNumber: 0000:00:1d.3
Dec 15 20:00:47 brouette kernel: usb usb5: configuration #1 chosen from 1 choice
Dec 15 20:00:47 brouette kernel: hub 5-0:1.0: USB hub found
Dec 15 20:00:47 brouette kernel: hub 5-0:1.0: 2 ports detected
Dec 15 20:00:47 brouette kernel: usb 2-1: new full speed USB device using uhci_hcd and address 2
Dec 15 20:00:47 brouette kernel: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Dec 15 20:00:47 brouette kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 15 20:00:47 brouette kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Dec 15 20:00:47 brouette kernel: mice: PS/2 mouse device common for all mice
Dec 15 20:00:47 brouette kernel: input: AT Translated Set 2 keyboard as /class/input/input2
Dec 15 20:00:47 brouette kernel: EDAC MC: Ver: 2.0.1 Dec 15 2006
Dec 15 20:00:47 brouette kernel: Advanced Linux Sound Architecture Driver Version 1.0.13 (Tue Nov 28 14:07:24 2006 UTC).
Dec 15 20:00:47 brouette kernel: usb 2-1: new device found, idVendor=056d, idProduct=0002
Dec 15 20:00:47 brouette kernel: usb 2-1: new device strings: Mfr=4, Product=14, SerialNumber=0
Dec 15 20:00:47 brouette kernel: usb 2-1: Product: EIZO USB HID Monitor
Dec 15 20:00:47 brouette kernel: usb 2-1: Manufacturer: EIZO
Dec 15 20:00:47 brouette kernel: usb 2-1: configuration #1 chosen from 1 choice
Dec 15 20:00:47 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 21
Dec 15 20:00:47 brouette kernel: ALSA device list:
Dec 15 20:00:47 brouette kernel:   #0: SB Live [Unknown] (rev.10, serial:0x80671102) at 0xdf20, irq 21
Dec 15 20:00:47 brouette kernel: TCP cubic registered
Dec 15 20:00:47 brouette kernel: NET: Registered protocol family 1
Dec 15 20:00:47 brouette kernel: NET: Registered protocol family 17
Dec 15 20:00:47 brouette kernel: Using IPI Shortcut mode
Dec 15 20:00:47 brouette kernel: Time: tsc clocksource has been installed.
Dec 15 20:00:47 brouette kernel: logips2pp: Detected unknown logitech mouse model 63
Dec 15 20:00:47 brouette kernel: input: ImExPS/2 Logitech Explorer Mouse as /class/input/input3
Dec 15 20:00:47 brouette kernel: kjournald starting.  Commit interval 5 seconds
Dec 15 20:00:47 brouette kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 15 20:00:47 brouette kernel: VFS: Mounted root (ext3 filesystem) readonly.
Dec 15 20:00:47 brouette kernel: Freeing unused kernel memory: 200k freed
Dec 15 20:00:47 brouette kernel: parport: PnPBIOS parport detected.
Dec 15 20:00:47 brouette kernel: parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Dec 15 20:00:47 brouette kernel: Adding 2048248k swap on /dev/sdb10.  Priority:-1 extents:1 across:2048248k
Dec 15 20:00:47 brouette kernel: EXT3 FS on sdb2, internal journal
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb5: using ordered data mode
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb5: checking transaction log (sdb5)
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb5: Using r5 hash to sort names
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb6: using ordered data mode
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb6: journal params: device sdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb6: checking transaction log (sdb6)
Dec 15 20:00:47 brouette kernel: ReiserFS: sdb6: Using r5 hash to sort names
Dec 15 20:00:47 brouette kernel: Filesystem "sdb9": Disabling barriers, trial barrier write failed
Dec 15 20:00:47 brouette kernel: XFS mounting filesystem sdb9
Dec 15 20:00:47 brouette kernel: Ending clean XFS mount for filesystem: sdb9
Dec 15 20:00:47 brouette kernel: reiser4: sdb11: found disk format 4.0.0.
Dec 15 20:00:47 brouette kernel: reiser4: sdb7: found disk format 4.0.0.
Dec 15 20:00:47 brouette kernel: Filesystem "sda5": Disabling barriers, trial barrier write failed
Dec 15 20:00:47 brouette kernel: XFS mounting filesystem sda5
Dec 15 20:00:47 brouette kernel: Ending clean XFS mount for filesystem: sda5
Dec 15 20:00:47 brouette kernel: reiser4: sda7: found disk format 4.0.0.
Dec 15 20:00:47 brouette kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Dec 15 20:00:47 brouette kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Dec 15 20:00:50 brouette kernel: lp0: using parport0 (interrupt-driven).

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.20-rc1-mm1-15122006dw
# Fri Dec 15 19:07:57 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
# CONFIG_SWAP_PREFETCH is not set
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_BLOCK=y
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=m
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor type and features
#
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_SMP=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_PARAVIRT is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MCORE2 is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
# CONFIG_ADAPTIVE_READAHEAD is not set
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_IRQBALANCE is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x100000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
# CONFIG_NF_CONNTRACK_ENABLED is not set
# CONFIG_NF_CONNTRACK_SUPPORT is not set
# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_ARPTABLES is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_NET_SCH_CLK_JIFFIES is not set
CONFIG_NET_SCH_CLK_GETTIMEOFDAY=y
# CONFIG_NET_SCH_CLK_CPU is not set

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
# CONFIG_NET_CLS_POLICE is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_ESTIMATOR=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
CONFIG_ATA=y
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=y
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
CONFIG_SATA_INTEL_COMBINED=y
CONFIG_SATA_ACPI=y
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SC92031 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
CONFIG_SHAPER=m
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB_DDC is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frambuffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
CONFIG_SND_EMU10K1=y
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AC97_POWER_SAVE is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# SoC audio support
#
# CONFIG_SND_SOC is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=y

#
# HID Devices
#
# CONFIG_HID is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_MULTITHREAD_PROBE is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GOTEMP is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_K8 is not set
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_POLL=y

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Auxiliary Display support
#
# CONFIG_KS0108 is not set

#
# Virtualization
#
# CONFIG_KVM is not set

#
# Userspace I/O
#
# CONFIG_UIO is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=y
# CONFIG_REISER4_DEBUG is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_UNWIND_INFO is not set
# CONFIG_PROFILE_LIKELY is not set
# CONFIG_FORCED_INLINING is not set
# CONFIG_DEBUG_SYNCHRO_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_INTEGRITY is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FS_CAPABILITIES is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=m
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_MANAGER=m
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_ECB is not set
CONFIG_CRYPTO_CBC=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y
CONFIG_IOMAP_COPY=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y

--PEIAKu/WMn1b1Hv9--
