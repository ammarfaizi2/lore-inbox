Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161288AbWASJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161288AbWASJqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbWASJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:46:06 -0500
Received: from pm-mx5.mgn.net ([195.46.220.209]:47262 "EHLO pm-mx5.mx.noos.fr")
	by vger.kernel.org with ESMTP id S1161288AbWASJqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:46:04 -0500
Date: Thu, 19 Jan 2006 10:42:05 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: Jeff Mahoney <jeffm@suse.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 + reiser* from -rc1-mm1 : BUG with reiserfs
Message-ID: <20060119094205.GA14907@localhost.localdomain>
References: <20060118122631.GA12363@localhost.localdomain> <43CEC61E.2040500@suse.com> <200601190004.36549.rjw@sisk.pl> <43CECC7D.1090200@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CECC7D.1090200@suse.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > Sigh. Ok. Back out the reiserfs patches
* Jeff Mahoney <jeffm@suse.com> [2006-01-18 18:17]:
> Just the on-demand bitmap stuff.

New test this morning with latest 2.6.16-rc1-git pulled with git, and
all reiserfs and reiser4 patches from -rc1-mm1, EXCEPT the three
on-demand bitmap for reiserfs. And when booting, the systems half
crashes with this error. So I guess the bad patches are not only the
ones for on-demand bitmap...

Jan 19 09:54:24 brouette kernel: klogd 1.4.1#17.1, log source = /proc/kmsg started.
Jan 19 09:54:24 brouette kernel: Inspecting /boot/System.map-2.6.16-rc1-git-19012006dw
Jan 19 09:54:24 brouette kernel: Loaded 23259 symbols from /boot/System.map-2.6.16-rc1-git-19012006dw.
Jan 19 09:54:24 brouette kernel: Symbols match kernel version 2.6.16.
Jan 19 09:54:24 brouette kernel: No module symbols loaded - kernel modules not enabled. 
Jan 19 09:54:24 brouette kernel: Linux version 2.6.16-rc1-git-19012006dw (root@brouette) (gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #1 SMP Thu Jan 19 09:44:32 CET 2006
Jan 19 09:54:24 brouette kernel: BIOS-provided physical RAM map:
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 0000000000100000 - 000000007ff74000 (usable)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 000000007ff74000 - 000000007ff76000 (ACPI NVS)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 000000007ff76000 - 000000007ff97000 (ACPI data)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 000000007ff97000 - 0000000080000000 (reserved)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Jan 19 09:54:24 brouette kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Jan 19 09:54:24 brouette kernel: 1151MB HIGHMEM available.
Jan 19 09:54:24 brouette kernel: 896MB LOWMEM available.
Jan 19 09:54:24 brouette kernel: found SMP MP-table at 000fe710
Jan 19 09:54:24 brouette kernel: On node 0 totalpages: 524148
Jan 19 09:54:24 brouette kernel:   DMA zone: 4096 pages, LIFO batch:0
Jan 19 09:54:24 brouette kernel:   DMA32 zone: 0 pages, LIFO batch:0
Jan 19 09:54:24 brouette kernel:   Normal zone: 225280 pages, LIFO batch:31
Jan 19 09:54:24 brouette kernel:   HighMem zone: 294772 pages, LIFO batch:31
Jan 19 09:54:24 brouette kernel: DMI 2.3 present.
Jan 19 09:54:24 brouette kernel: ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
Jan 19 09:54:24 brouette kernel: ACPI: RSDT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1ca
Jan 19 09:54:24 brouette kernel: ACPI: FADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1fe
Jan 19 09:54:24 brouette kernel: ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc929b
Jan 19 09:54:24 brouette kernel: ACPI: MADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd272
Jan 19 09:54:24 brouette kernel: ACPI: BOOT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd2de
Jan 19 09:54:24 brouette kernel: ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
Jan 19 09:54:24 brouette kernel: ACPI: PM-Timer IO Port: 0x808
Jan 19 09:54:24 brouette kernel: ACPI: Local APIC address 0xfee00000
Jan 19 09:54:24 brouette kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jan 19 09:54:24 brouette kernel: Processor #0 15:3 APIC version 20
Jan 19 09:54:24 brouette kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jan 19 09:54:24 brouette kernel: Processor #1 15:3 APIC version 20
Jan 19 09:54:24 brouette kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
Jan 19 09:54:24 brouette kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
Jan 19 09:54:24 brouette kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan 19 09:54:24 brouette kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jan 19 09:54:24 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan 19 09:54:24 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jan 19 09:54:24 brouette kernel: ACPI: IRQ0 used by override.
Jan 19 09:54:24 brouette kernel: ACPI: IRQ2 used by override.
Jan 19 09:54:24 brouette kernel: ACPI: IRQ9 used by override.
Jan 19 09:54:24 brouette kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jan 19 09:54:24 brouette kernel: Using ACPI (MADT) for SMP configuration information
Jan 19 09:54:24 brouette kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Jan 19 09:54:24 brouette kernel: Built 1 zonelists
Jan 19 09:54:24 brouette kernel: Kernel command line: root=/dev/sdb2 ro vga=0x31B selinux=0 elevator=cfq 
Jan 19 09:54:24 brouette kernel: mapped APIC to ffffd000 (fee00000)
Jan 19 09:54:24 brouette kernel: mapped IOAPIC to ffffc000 (fec00000)
Jan 19 09:54:24 brouette kernel: Enabling fast FPU save and restore... done.
Jan 19 09:54:24 brouette kernel: Enabling unmasked SIMD FPU exception support... done.
Jan 19 09:54:24 brouette kernel: Initializing CPU#0
Jan 19 09:54:24 brouette kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Jan 19 09:54:24 brouette kernel: Detected 2993.225 MHz processor.
Jan 19 09:54:24 brouette kernel: Using pmtmr for high-res timesource
Jan 19 09:54:24 brouette kernel: Console: colour dummy device 80x25
Jan 19 09:54:24 brouette kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan 19 09:54:24 brouette kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jan 19 09:54:24 brouette kernel: Memory: 2075004k/2096592k available (1938k kernel code, 20404k reserved, 703k data, 172k init, 1179088k highmem)
Jan 19 09:54:24 brouette kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan 19 09:54:24 brouette kernel: Calibrating delay using timer specific routine.. 5991.89 BogoMIPS (lpj=2995948)
Jan 19 09:54:24 brouette kernel: Mount-cache hash table entries: 512
Jan 19 09:54:24 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 19 09:54:24 brouette kernel: CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 19 09:54:24 brouette kernel: monitor/mwait feature present.
Jan 19 09:54:24 brouette kernel: using mwait in idle threads.
Jan 19 09:54:24 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jan 19 09:54:24 brouette kernel: CPU: L2 cache: 1024K
Jan 19 09:54:24 brouette kernel: CPU: Physical Processor ID: 0
Jan 19 09:54:24 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000041d 00000000 00000000
Jan 19 09:54:24 brouette kernel: Intel machine check architecture supported.
Jan 19 09:54:24 brouette kernel: Intel machine check reporting enabled on CPU#0.
Jan 19 09:54:24 brouette kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Jan 19 09:54:24 brouette kernel: CPU0: Thermal monitoring enabled
Jan 19 09:54:24 brouette kernel: mtrr: v2.0 (20020519)
Jan 19 09:54:24 brouette kernel: Checking 'hlt' instruction... OK.
Jan 19 09:54:24 brouette kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jan 19 09:54:24 brouette kernel: Booting processor 1/1 eip 2000
Jan 19 09:54:24 brouette kernel: Initializing CPU#1
Jan 19 09:54:24 brouette kernel: Calibrating delay using timer specific routine.. 5984.24 BogoMIPS (lpj=2992123)
Jan 19 09:54:24 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 19 09:54:24 brouette kernel: CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 19 09:54:24 brouette kernel: monitor/mwait feature present.
Jan 19 09:54:24 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jan 19 09:54:24 brouette kernel: CPU: L2 cache: 1024K
Jan 19 09:54:24 brouette kernel: CPU: Physical Processor ID: 0
Jan 19 09:54:24 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000041d 00000000 00000000
Jan 19 09:54:24 brouette kernel: Intel machine check architecture supported.
Jan 19 09:54:24 brouette kernel: Intel machine check reporting enabled on CPU#1.
Jan 19 09:54:24 brouette kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Jan 19 09:54:24 brouette kernel: CPU1: Thermal monitoring enabled
Jan 19 09:54:24 brouette kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jan 19 09:54:24 brouette kernel: Total of 2 processors activated (11976.14 BogoMIPS).
Jan 19 09:54:24 brouette kernel: ENABLING IO-APIC IRQs
Jan 19 09:54:24 brouette kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan 19 09:54:24 brouette kernel: checking TSC synchronization across 2 CPUs: passed.
Jan 19 09:54:24 brouette kernel: Brought up 2 CPUs
Jan 19 09:54:24 brouette kernel: migration_cost=1000
Jan 19 09:54:24 brouette kernel: NET: Registered protocol family 16
Jan 19 09:54:24 brouette kernel: ACPI: bus type pci registered
Jan 19 09:54:24 brouette kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=2
Jan 19 09:54:24 brouette kernel: PCI: Using configuration type 1
Jan 19 09:54:24 brouette kernel: ACPI: Subsystem revision 20050902
Jan 19 09:54:24 brouette kernel: ACPI: Interpreter enabled
Jan 19 09:54:24 brouette kernel: ACPI: Using IOAPIC for interrupt routing
Jan 19 09:54:24 brouette kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan 19 09:54:24 brouette kernel: PCI: Probing PCI hardware (bus 00)
Jan 19 09:54:24 brouette kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Jan 19 09:54:24 brouette kernel: PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
Jan 19 09:54:24 brouette kernel: PCI quirk: region 0880-08bf claimed by ICH4 GPIO
Jan 19 09:54:24 brouette kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jan 19 09:54:24 brouette kernel: Boot video device is 0000:01:00.0
Jan 19 09:54:24 brouette kernel: PCI: Transparent bridge - 0000:00:1e.0
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Jan 19 09:54:24 brouette kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan 19 09:54:24 brouette kernel: pnp: PnP ACPI init
Jan 19 09:54:24 brouette kernel: pnp: PnP ACPI: found 11 devices
Jan 19 09:54:24 brouette kernel: SCSI subsystem initialized
Jan 19 09:54:24 brouette kernel: PCI: Using ACPI for IRQ routing
Jan 19 09:54:24 brouette kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jan 19 09:54:24 brouette kernel: pnp: 00:0a: ioport range 0x800-0x85f could not be reserved
Jan 19 09:54:24 brouette kernel: pnp: 00:0a: ioport range 0xc00-0xc7f has been reserved
Jan 19 09:54:24 brouette kernel: pnp: 00:0a: ioport range 0x860-0x8ff could not be reserved
Jan 19 09:54:24 brouette kernel: PCI: Bridge: 0000:00:01.0
Jan 19 09:54:24 brouette kernel:   IO window: disabled.
Jan 19 09:54:24 brouette kernel:   MEM window: fd000000-feafffff
Jan 19 09:54:24 brouette kernel:   PREFETCH window: f0000000-f7ffffff
Jan 19 09:54:24 brouette kernel: PCI: Bridge: 0000:00:1e.0
Jan 19 09:54:24 brouette kernel:   IO window: d000-dfff
Jan 19 09:54:24 brouette kernel:   MEM window: fcf00000-fcffffff
Jan 19 09:54:24 brouette kernel:   PREFETCH window: disabled.
Jan 19 09:54:24 brouette kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Jan 19 09:54:24 brouette kernel: Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Jan 19 09:54:24 brouette kernel: Simple Boot Flag at 0x7a set to 0x1
Jan 19 09:54:24 brouette kernel: Machine check exception polling timer started.
Jan 19 09:54:24 brouette kernel: highmem bounce pool size: 64 pages
Jan 19 09:54:24 brouette kernel: Loading Reiser4. See www.namesys.com for a description of Reiser4.
Jan 19 09:54:24 brouette kernel: Initializing Cryptographic API
Jan 19 09:54:24 brouette kernel: io scheduler noop registered
Jan 19 09:54:24 brouette kernel: io scheduler anticipatory registered
Jan 19 09:54:24 brouette kernel: io scheduler deadline registered
Jan 19 09:54:24 brouette kernel: io scheduler cfq registered (default)
Jan 19 09:54:24 brouette kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, using 10240k, total 131072k
Jan 19 09:54:24 brouette kernel: vesafb: mode is 1280x1024x32, linelength=5120, pages=0
Jan 19 09:54:24 brouette kernel: vesafb: protected mode interface info at c000:f080
Jan 19 09:54:24 brouette kernel: vesafb: scrolling: redraw
Jan 19 09:54:24 brouette kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Jan 19 09:54:24 brouette kernel: Console: switching to colour frame buffer device 160x64
Jan 19 09:54:24 brouette kernel: fb0: VESA VGA frame buffer device
Jan 19 09:54:24 brouette kernel: Real Time Clock Driver v1.12ac
Jan 19 09:54:24 brouette kernel: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Jan 19 09:54:24 brouette kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 19 09:54:24 brouette kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 19 09:54:24 brouette kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Jan 19 09:54:24 brouette kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
Jan 19 09:54:24 brouette kernel: e100: Copyright(c) 1999-2005 Intel Corporation
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 169
Jan 19 09:54:24 brouette kernel: e100: eth0: e100_probe: addr 0xfcfff000, irq 169, MAC addr 00:0C:F1:B6:BA:54
Jan 19 09:54:24 brouette kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 19 09:54:24 brouette kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 19 09:54:24 brouette kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
Jan 19 09:54:24 brouette kernel: ICH5: chipset revision 2
Jan 19 09:54:24 brouette kernel: ICH5: not 100%% native mode: will probe irqs later
Jan 19 09:54:24 brouette kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Jan 19 09:54:24 brouette kernel: Probing IDE interface ide1...
Jan 19 09:54:24 brouette kernel: hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
Jan 19 09:54:24 brouette kernel: hdd: SAMSUNG CD-R/RW SW-252S, ATAPI CD/DVD-ROM drive
Jan 19 09:54:24 brouette kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 19 09:54:24 brouette kernel: Probing IDE interface ide0...
Jan 19 09:54:24 brouette kernel: hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Jan 19 09:54:24 brouette kernel: Uniform CD-ROM driver Revision: 3.20
Jan 19 09:54:24 brouette kernel: hdd: ATAPI 16X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Jan 19 09:54:24 brouette kernel: Driver 'ide-scsi' needs updating - please use bus_type methods
Jan 19 09:54:24 brouette kernel: libata version 1.20 loaded.
Jan 19 09:54:24 brouette kernel: ata_piix 0000:00:1f.2: version 1.05
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
Jan 19 09:54:24 brouette kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Jan 19 09:54:24 brouette kernel: ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 177
Jan 19 09:54:24 brouette kernel: ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 177
Jan 19 09:54:24 brouette kernel: ata1: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
Jan 19 09:54:24 brouette kernel: ata1: dev 0 ATA-6, max UDMA/133, 144531250 sectors: LBA48
Jan 19 09:54:24 brouette kernel: ata1(0): applying bridge limits
Jan 19 09:54:24 brouette kernel: ata1: dev 0 configured for UDMA/100
Jan 19 09:54:24 brouette kernel: scsi0 : ata_piix
Jan 19 09:54:24 brouette kernel: ata2: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
Jan 19 09:54:24 brouette kernel: ata2: dev 0 ATA-6, max UDMA/133, 144531250 sectors: LBA48
Jan 19 09:54:24 brouette kernel: ata2(0): applying bridge limits
Jan 19 09:54:24 brouette kernel: ata2: dev 0 configured for UDMA/100
Jan 19 09:54:24 brouette kernel: scsi1 : ata_piix
Jan 19 09:54:24 brouette kernel:   Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
Jan 19 09:54:24 brouette kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jan 19 09:54:24 brouette kernel:   Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
Jan 19 09:54:24 brouette kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jan 19 09:54:24 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Jan 19 09:54:24 brouette kernel: sda: Write Protect is off
Jan 19 09:54:24 brouette kernel: sda: Mode Sense: 00 3a 00 00
Jan 19 09:54:24 brouette kernel: SCSI device sda: drive cache: write back
Jan 19 09:54:24 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Jan 19 09:54:24 brouette kernel: sda: Write Protect is off
Jan 19 09:54:24 brouette kernel: sda: Mode Sense: 00 3a 00 00
Jan 19 09:54:24 brouette kernel: SCSI device sda: drive cache: write back
Jan 19 09:54:24 brouette kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Jan 19 09:54:24 brouette kernel: sd 0:0:0:0: Attached scsi disk sda
Jan 19 09:54:24 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Jan 19 09:54:24 brouette kernel: sdb: Write Protect is off
Jan 19 09:54:24 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Jan 19 09:54:24 brouette kernel: SCSI device sdb: drive cache: write back
Jan 19 09:54:24 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Jan 19 09:54:24 brouette kernel: sdb: Write Protect is off
Jan 19 09:54:24 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Jan 19 09:54:24 brouette kernel: SCSI device sdb: drive cache: write back
Jan 19 09:54:24 brouette kernel:  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 >
Jan 19 09:54:24 brouette kernel: sd 1:0:0:0: Attached scsi disk sdb
Jan 19 09:54:24 brouette kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan 19 09:54:24 brouette kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan 19 09:54:24 brouette kernel: mice: PS/2 mouse device common for all mice
Jan 19 09:54:24 brouette kernel: MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Jan 19 2006
Jan 19 09:54:24 brouette kernel: NET: Registered protocol family 2
Jan 19 09:54:24 brouette kernel: IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan 19 09:54:24 brouette kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Jan 19 09:54:24 brouette kernel: TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
Jan 19 09:54:24 brouette kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Jan 19 09:54:24 brouette kernel: TCP: Hash tables configured (established 524288 bind 65536)
Jan 19 09:54:24 brouette kernel: TCP reno registered
Jan 19 09:54:24 brouette kernel: TCP bic registered
Jan 19 09:54:24 brouette kernel: NET: Registered protocol family 1
Jan 19 09:54:24 brouette kernel: NET: Registered protocol family 17
Jan 19 09:54:24 brouette kernel: Starting balanced_irq
Jan 19 09:54:24 brouette kernel: Using IPI Shortcut mode
Jan 19 09:54:24 brouette kernel: kjournald starting.  Commit interval 5 seconds
Jan 19 09:54:24 brouette kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan 19 09:54:24 brouette kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jan 19 09:54:24 brouette kernel: Freeing unused kernel memory: 172k freed
Jan 19 09:54:24 brouette kernel: logips2pp: Detected unknown logitech mouse model 63
Jan 19 09:54:24 brouette kernel: input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
Jan 19 09:54:24 brouette kernel: usbcore: registered new driver usbfs
Jan 19 09:54:24 brouette kernel: usbcore: registered new driver hub
Jan 19 09:54:24 brouette kernel: USB Universal Host Controller Interface driver v2.3
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 185
Jan 19 09:54:24 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.0: irq 185, io base 0x0000ff80
Jan 19 09:54:24 brouette kernel: usb usb1: configuration #1 chosen from 1 choice
Jan 19 09:54:24 brouette kernel: hub 1-0:1.0: USB hub found
Jan 19 09:54:24 brouette kernel: hub 1-0:1.0: 2 ports detected
Jan 19 09:54:24 brouette kernel: input: PC Speaker as /class/input/input2
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
Jan 19 09:54:24 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jan 19 09:54:24 brouette kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jan 19 09:54:24 brouette kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jan 19 09:54:24 brouette kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jan 19 09:54:24 brouette kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
Jan 19 09:54:24 brouette kernel: ehci_hcd 0000:00:1d.7: irq 193, io mem 0xffa80800
Jan 19 09:54:24 brouette kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jan 19 09:54:24 brouette kernel: usb usb2: configuration #1 chosen from 1 choice
Jan 19 09:54:24 brouette kernel: hub 2-0:1.0: USB hub found
Jan 19 09:54:24 brouette kernel: hub 2-0:1.0: 8 ports detected
Jan 19 09:54:24 brouette kernel: parport: PnPBIOS parport detected.
Jan 19 09:54:24 brouette kernel: parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 201
Jan 19 09:54:24 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.1: irq 201, io base 0x0000ff60
Jan 19 09:54:24 brouette kernel: usb usb3: configuration #1 chosen from 1 choice
Jan 19 09:54:24 brouette kernel: hub 3-0:1.0: USB hub found
Jan 19 09:54:24 brouette kernel: hub 3-0:1.0: 2 ports detected
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 177
Jan 19 09:54:24 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.2: irq 177, io base 0x0000ff40
Jan 19 09:54:24 brouette kernel: usb usb4: configuration #1 chosen from 1 choice
Jan 19 09:54:24 brouette kernel: hub 4-0:1.0: USB hub found
Jan 19 09:54:24 brouette kernel: hub 4-0:1.0: 2 ports detected
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 185
Jan 19 09:54:24 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jan 19 09:54:24 brouette kernel: uhci_hcd 0000:00:1d.3: irq 185, io base 0x0000ff20
Jan 19 09:54:24 brouette kernel: usb 1-1: new full speed USB device using uhci_hcd and address 3
Jan 19 09:54:24 brouette kernel: usb usb5: configuration #1 chosen from 1 choice
Jan 19 09:54:24 brouette kernel: hub 5-0:1.0: USB hub found
Jan 19 09:54:24 brouette kernel: hub 5-0:1.0: 2 ports detected
Jan 19 09:54:24 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 209
Jan 19 09:54:24 brouette kernel: usb 1-1: configuration #1 chosen from 1 choice
Jan 19 09:54:24 brouette kernel: Adding 2048248k swap on /dev/sdb10.  Priority:-1 extents:1 across:2048248k
Jan 19 09:54:24 brouette kernel: EXT3 FS on sdb2, internal journal
Jan 19 09:54:24 brouette kernel: ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
Jan 19 09:54:24 brouette kernel: ReiserFS: sdb5: using ordered data mode
Jan 19 09:54:24 brouette kernel: ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jan 19 09:54:24 brouette kernel: ReiserFS: sdb5: checking transaction log (sdb5)
Jan 19 09:54:24 brouette kernel: ReiserFS: sdb5: Using r5 hash to sort names
Jan 19 09:54:24 brouette kernel: ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
Jan 19 09:54:24 brouette kernel: ------------[ cut here ]------------
Jan 19 09:54:24 brouette kernel: kernel BUG at fs/reiserfs/bitmap.c:1315!
Jan 19 09:54:24 brouette kernel: invalid opcode: 0000 [#1]
Jan 19 09:54:24 brouette kernel: SMP 
Jan 19 09:54:24 brouette kernel: Modules linked in: snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_device parport_pc snd_timer snd_page_alloc snd_util_mem snd_hwdep parport pcspkr ehci_hcd uhci_hcd snd soundcore usbcore
Jan 19 09:54:24 brouette kernel: CPU:    0
Jan 19 09:54:24 brouette kernel: EIP:    0060:[reiserfs_cache_bitmap_metadata+106/118]    Not tainted VLI
Jan 19 09:54:24 brouette kernel: EFLAGS: 00010246   (2.6.16-rc1-git-19012006dw) 
Jan 19 09:54:24 brouette kernel: EIP is at reiserfs_cache_bitmap_metadata+0x6a/0x76
Jan 19 09:54:24 brouette kernel: eax: 00000000   ebx: f558f000   ecx: ffffffff   edx: 00000000
Jan 19 09:54:24 brouette kernel: esi: f93b1060   edi: 00000000   ebp: 00000076   esp: f769fc88
Jan 19 09:54:24 brouette kernel: ds: 007b   es: 007b   ss: 0068
Jan 19 09:54:24 brouette kernel: Process mount (pid: 1232, threadinfo=f769e000 task=f7cb3030)
Jan 19 09:54:24 brouette kernel: Stack: <0>f93b1000 0000000c f93b1060 c017c5a4 f70bf600 f5538d38 f93b1060 a9627200 
Jan 19 09:54:24 brouette kernel:        00000003 f55ba25c f70bf600 c018db6f f70bf600 f769fce4 00000000 f5594000 
Jan 19 09:54:24 brouette kernel:        f55ba000 f769fd70 00000000 00000084 f769fce4 00000000 0000008c 00000000 
Jan 19 09:54:24 brouette kernel: Call Trace:
Jan 19 09:54:24 brouette kernel:  [reiserfs_init_bitmap_cache+309/347] reiserfs_init_bitmap_cache+0x135/0x15b
Jan 19 09:54:24 brouette kernel:  [reiserfs_fill_super+570/2875] reiserfs_fill_super+0x23a/0xb3b
Jan 19 09:54:24 brouette kernel:  [vsnprintf+1057/1121] vsnprintf+0x421/0x461
Jan 19 09:54:24 brouette kernel:  [snprintf+26/30] snprintf+0x1a/0x1e
Jan 19 09:54:24 brouette kernel:  [disk_name+92/102] disk_name+0x5c/0x66
Jan 19 09:54:24 brouette kernel:  [get_sb_bdev+205/268] get_sb_bdev+0xcd/0x10c
Jan 19 09:54:24 brouette kernel:  [__alloc_pages+86/611] __alloc_pages+0x56/0x263
Jan 19 09:54:24 brouette kernel:  [get_super_block+26/30] get_super_block+0x1a/0x1e
Jan 19 09:54:24 brouette kernel:  [reiserfs_fill_super+0/2875] reiserfs_fill_super+0x0/0xb3b
Jan 19 09:54:24 brouette kernel:  [do_kern_mount+60/160] do_kern_mount+0x3c/0xa0
Jan 19 09:54:24 brouette kernel:  [do_mount+1506/1586] do_mount+0x5e2/0x632
Jan 19 09:54:24 brouette kernel:  [do_path_lookup+473/484] do_path_lookup+0x1d9/0x1e4
Jan 19 09:54:24 brouette kernel:  [get_page_from_freelist+126/721] get_page_from_freelist+0x7e/0x2d1
Jan 19 09:54:24 brouette kernel:  [__alloc_pages+86/611] __alloc_pages+0x56/0x263
Jan 19 09:54:24 brouette kernel:  [__get_free_pages+47/52] __get_free_pages+0x2f/0x34
Jan 19 09:54:24 brouette kernel:  [copy_mount_options+40/270] copy_mount_options+0x28/0x10e
Jan 19 09:54:24 brouette kernel:  [sys_mount+119/183] sys_mount+0x77/0xb7
Jan 19 09:54:24 brouette kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Jan 19 09:54:24 brouette kernel: Code: 00 0f a3 0b 19 c0 85 c0 75 0a 8d 04 0f 66 89 06 66 ff 46 02 49 83 f9 ff 75 e7 4a 83 ef 08 83 c3 04 85 d2 7f bd 66 83 3e 00 75 08 <0f> 0b 23 05 99 d4 2f c0 5b 5e 5f c3 8b 54 24 04 8b 82 80 01 00 
Jan 19 09:54:24 brouette kernel:  <6>e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

(this ends there, I had to reboot on a safe kernel)

-- 
Damien Wyart
