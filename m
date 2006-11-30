Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967883AbWK3TC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967883AbWK3TC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967884AbWK3TC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:02:29 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:49832 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S967883AbWK3TC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:02:27 -0500
Date: Thu, 30 Nov 2006 14:02:22 -0500
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Cc: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: 2.6.19 SMP x86-64 crashes continue
Message-ID: <20061130190222.GC29136@jukie.net>
References: <20061129170253.GH2418@jukie.net> <200611291812.08408.prakash@punnoor.de> <loom.20061129T220542-977@post.gmane.org> <20061129170253.GH2418@jukie.net> <200611291812.08408.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20061129T220542-977@post.gmane.org> <200611291812.08408.prakash@punnoor.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been getting odd crashes in 2.6.18 and .19-rc's with a dual core
opteron on an nforce chipset.  I've been running with a serial console
capturing things.

Prakash suggested I try the git tree yesterday afternoon, and I've been
running v2.6.19-rc6-g1275361  ...that ended up being very close to the
2.6.19 release, which is perfect :)

2.6.19 seems to be a lot more stable with this configuration.  2.6.18.y
used to die after 5 minutes (make -j3 of the kernel), my new kernel ran
for about 24 hours.

Below I marked a few spots where I remember what I did.  See EVENT1,
EVENT2, EVENT3, and EVENT4.

I am building the "real" 2.6.19 as I speak and will report if it
happens again.

-Bart

[    0.000000] Command line: BOOT_IMAGE=dbg-v2.6.19-rc6 ro root=900 console=ttyS0,115200n8 console=tty0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
[    0.000000]  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
[    0.000000]  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.2 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   262128
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000f0000
[    0.000000] Nosave address range: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] PERCPU: Allocating 33472 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 258439
[    0.000000] Kernel command line: BOOT_IMAGE=dbg-v2.6.19-rc6 ro root=900 console=ttyS0,115200n8 console=tty0
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   25.933238] Console: colour VGA+ 80x50
[   26.210190] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   26.217960] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   26.224976] Checking aperture...
[   26.228249] CPU 0: aperture @ 4000000 size 32 MB
[   26.232906] Aperture too small (32 MB)
[   26.241859] No AGP bridge found
[   26.256938] Memory: 1025888k/1048512k available (3496k kernel code, 21972k reserved, 1517k data, 256k init)
[   26.326412] Calibrating delay using timer specific routine.. 4021.81 BogoMIPS (lpj=2010905)
[   26.334896] Security Framework v1.0.0 initialized
[   26.339648] SELinux:  Disabled at boot.
[   26.343538] Mount-cache hash table entries: 256
[   26.348246] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   26.355416] CPU: L2 Cache: 1024K (64 bytes/line)
[   26.360075] CPU: Physical Processor ID: 0
[   26.364127] CPU: Processor Core ID: 0
[   26.367850] Freeing SMP alternatives: 32k freed
[   26.372450] ACPI: Core revision 20060707
[   26.392499] Using local APIC timer interrupts.
[   26.446689] result 12564482
[   26.449523] Detected 12.564 MHz APIC timer.
[   26.454403] Booting processor 1/2 APIC 0x1
[   26.468543] Initializing CPU#1
[   26.528945] Calibrating delay using timer specific routine.. 4020.06 BogoMIPS (lpj=2010033)
[   26.528951] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   26.528953] CPU: L2 Cache: 1024K (64 bytes/line)
[   26.528956] CPU: Physical Processor ID: 0
[   26.528957] CPU: Processor Core ID: 1
[   26.529074] Dual Core AMD Opteron(tm) Processor 170    stepping 02
[   26.529951] CPU 1: Syncing TSC to CPU 0.
[   26.530321] CPU 1: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 466 cycles)
[   26.530330] Brought up 2 CPUs
[   26.582655] testing NMI watchdog ... OK.
[   26.596663] Disabling vsyscall due to use of PM timer
[   26.601756] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[   26.607540] time.c: Detected 2010.314 MHz processor.
[   27.745837] migration_cost=452
[   27.749382] NET: Registered protocol family 16
[   27.753937] ACPI: bus type pci registered
[   27.761377] PCI: Using MMCONFIG at e0000000
[   27.765623] PCI: No mmconfig possible on device 00:18
[   27.777974] ACPI: Interpreter enabled
[   27.781680] ACPI: Using IOAPIC for interrupt routing
[   27.787133] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   27.795708] PCI: Transparent bridge - 0000:00:09.0
[   27.867353] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   27.876473] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   27.885575] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 *12 14 15)
[   27.893447] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 *7 9 10 11 12 14 15)
[   27.901295] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   27.910385] ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 7 9 10 11 12 14 15)
[   27.918265] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   27.927350] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[   27.935207] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   27.944300] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   27.953403] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
[   27.961257] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   27.969119] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   27.978223] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   27.986087] ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 *10 11 12 14 15)
[   27.993954] ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   28.003092] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[   28.009930] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[   28.016753] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   28.023569] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[   28.031516] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   28.038154] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
[   28.045907] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
[   28.053640] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
[   28.061395] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
[   28.069144] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
[   28.076886] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
[   28.084627] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
[   28.092370] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
[   28.100124] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
[   28.107880] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
[   28.115624] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
[   28.125412] Linux Plug and Play Support v0.97 (c) Adam Belay
[   28.131118] pnp: PnP ACPI init
[   28.138667] pnp: PnP ACPI: found 11 devices
[   28.142926] Generic PHY: Registered new driver
[   28.147524] SCSI subsystem initialized
[   28.151418] usbcore: registered new interface driver usbfs
[   28.156974] usbcore: registered new interface driver hub
[   28.162359] usbcore: registered new device driver usb
[   28.167485] PCI: Using ACPI for IRQ routing
[   28.171716] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   28.180090] NetLabel: Initializing
[   28.183533] NetLabel:  domain hash size = 128
[   28.187932] NetLabel:  protocols = UNLABELED CIPSOv4
[   28.192952] NetLabel:  unlabeled traffic allowed by default
[   28.198596] PCI-DMA: Disabling IOMMU.
[   28.202705] pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
[   28.209447] pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
[   28.215836] pnp: 00:01: ioport range 0x4400-0x447f has been reserved
[   28.222229] pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
[   28.228966] pnp: 00:01: ioport range 0x4800-0x487f has been reserved
[   28.235357] pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
[   28.242013] PCI: Bridge: 0000:00:09.0
[   28.245716]   IO window: a000-afff
[   28.249162]   MEM window: d8100000-d81fffff
[   28.253386]   PREFETCH window: disabled.
[   28.257354] PCI: Bridge: 0000:00:0b.0
[   28.261059]   IO window: disabled.
[   28.264506]   MEM window: disabled.
[   28.268041]   PREFETCH window: disabled.
[   28.272007] PCI: Bridge: 0000:00:0c.0
[   28.275713]   IO window: disabled.
[   28.279160]   MEM window: disabled.
[   28.282693]   PREFETCH window: disabled.
[   28.286659] PCI: Bridge: 0000:00:0d.0
[   28.290366]   IO window: disabled.
[   28.293814]   MEM window: disabled.
[   28.297347]   PREFETCH window: disabled.
[   28.301316] PCI: Bridge: 0000:00:0e.0
[   28.305019]   IO window: 9000-9fff
[   28.308467]   MEM window: d8000000-d80fffff
[   28.312692]   PREFETCH window: d0000000-d7ffffff
[   28.317396] NET: Registered protocol family 2
[   28.330931] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   28.338372] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   28.347355] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   28.354863] TCP: Hash tables configured (established 131072 bind 65536)
[   28.361512] TCP reno registered
[   28.365379] audit: initializing netlink socket (disabled)
[   28.370837] audit(1164831161.976:1): initialized
[   28.375626] VFS: Disk quotas dquot_6.5.1
[   28.379602] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   28.386123] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[   28.395898] SGI XFS Quota Management subsystem
[   28.400410] io scheduler noop registered
[   28.404416] io scheduler anticipatory registered (default)
[   28.410019] io scheduler deadline registered
[   28.414385] io scheduler cfq registered
[   28.432167] PCI: Linking AER extended capability on 0000:00:0b.0
[   28.438223] PCI: Found HT MSI mapping on 0000:00:0b.0 with capability disabled
[   28.445511] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   28.452687] PCI: Linking AER extended capability on 0000:00:0c.0
[   28.458734] PCI: Found HT MSI mapping on 0000:00:0c.0 with capability disabled
[   28.466017] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   28.473186] PCI: Linking AER extended capability on 0000:00:0d.0
[   28.479230] PCI: Found HT MSI mapping on 0000:00:0d.0 with capability disabled
[   28.486516] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   28.493684] PCI: Linking AER extended capability on 0000:00:0e.0
[   28.499729] PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
[   28.507016] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   28.514369] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   28.521920] assign_interrupt_mode Found MSI capability
[   28.527207] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   28.534761] assign_interrupt_mode Found MSI capability
[   28.540022] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   28.547568] assign_interrupt_mode Found MSI capability
[   28.552832] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   28.560384] assign_interrupt_mode Found MSI capability
[   28.565685] ACPI: Power Button (FF) [PWRF]
[   28.569832] ACPI: Power Button (CM) [PWRB]
[   28.573990] ACPI: Fan [FAN] (on)
[   28.577322] Using specific hotkey driver
[   28.581947] ACPI: Thermal Zone [THRM] (40 C)
[   28.606679] DoubleTalk PC - not found
[   28.610457] Linux agpgart interface v0.101 (c) Dave Jones
[   28.615936] [drm] Initialized drm 1.0.1 20051102
[   28.620946] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   28.626762] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
[   28.635756] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[   28.641740] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   28.650774] Hangcheck: Using monotonic_clock().
[   28.655364] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   28.663274] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   28.669852] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   28.675984] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   28.683694] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
[   28.691609] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
[   28.697404] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
[   28.706249] forcedeth: using HIGHDMA
[   29.222393] eth0: forcedeth.c: subsystem: 01297:5036 bound to 0000:00:0a.0
[   29.229308] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   29.235702] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   30.037669] hda: PLEXTOR DVDR PX-716AL, ATAPI CD/DVD-ROM drive
[   30.861935] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   30.867073] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
[   30.872860] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> IRQ 22
[   30.882137] ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 22
[   30.889162] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 22
[   30.896174] scsi0 : sata_nv
[   31.352558] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   31.359346] ata1.00: ATA-7, max UDMA/133, 320170943 sectors: LBA48
[   31.365653] ata1.00: ata1: dev 0 multi count 16
[   31.370916] ata1.00: configured for UDMA/133
[   31.375247] scsi1 : sata_nv
[   31.832189] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   31.838970] ata2.00: ATA-7, max UDMA/133, 320173056 sectors: LBA48
[   31.845275] ata2.00: ata2: dev 0 multi count 16
[   31.850540] ata2.00: configured for UDMA/133
[   31.854922] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y160M0   YAR5 PQ: 0 ANSI: 5
[   31.863151] SCSI device sda: 320170943 512-byte hdwr sectors (163928 MB)
[   31.869891] sda: Write Protect is off
[   31.873605] SCSI device sda: drive cache: write back
[   31.878641] SCSI device sda: 320170943 512-byte hdwr sectors (163928 MB)
[   31.885384] sda: Write Protect is off
[   31.890300] SCSI device sda: drive cache: write back
[   31.895305]  sda: sda1 sda2 sda3
[   31.936730] sd 0:0:0:0: Attached scsi disk sda
[   31.941282] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   31.946704] scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y160M0   YAR5 PQ: 0 ANSI: 5
[   31.954926] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   31.961667] sdb: Write Protect is off
[   31.965386] SCSI device sdb: drive cache: write back
[   31.970423] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   31.977167] sdb: Write Protect is off
[   31.980882] SCSI device sdb: drive cache: write back
[   31.985884]  sdb: sdb1 sdb2 sdb3
[   32.009037] sd 1:0:0:0: Attached scsi disk sdb
[   32.013571] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   32.019399] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
[   32.025188] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> IRQ 21
[   32.034342] ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
[   32.041377] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
[   32.048385] scsi2 : sata_nv
[   32.354775] ata3: SATA link down (SStatus 0 SControl 300)
[   32.360220] scsi3 : sata_nv
[   32.666533] ata4: SATA link down (SStatus 0 SControl 300)
[   32.672009] ieee1394: raw1394: /dev/raw1394 device initialized
[   32.677905] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   32.684903] ieee1394: sbp2: Try serialize_io=0 for better performance
[   32.691441] usbmon: debugfs is not available
[   32.696138] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
[   32.701925] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
[   32.710981] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   32.716378] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
[   32.723854] ehci_hcd 0000:00:02.1: debug port 1
[   32.728431] ehci_hcd 0000:00:02.1: irq 20, io mem 0xd8205000
[   32.734131] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   32.741784] usb usb1: configuration #1 chosen from 1 choice
[   32.747433] hub 1-0:1.0: USB hub found
[   32.751228] hub 1-0:1.0: 10 ports detected
[   32.856838] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
[   32.862623] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
[   32.871672] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   32.877061] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
[   32.884527] ohci_hcd 0000:00:02.0: irq 23, io mem 0xd8204000
[   32.943408] usb usb2: configuration #1 chosen from 1 choice
[   32.949051] hub 2-0:1.0: USB hub found
[   32.952847] hub 2-0:1.0: 10 ports detected
[   33.058307] USB Universal Host Controller Interface driver v3.0
[   33.072209] usb 1-2: new high speed USB device using ehci_hcd and address 2
[   33.197865] usb 1-2: configuration #1 chosen from 1 choice
[   33.721708] usb 1-6: new high speed USB device using ehci_hcd and address 5
[   33.858249] usb 1-6: configuration #1 chosen from 1 choice
[   34.081430] usb 2-3: new low speed USB device using ohci_hcd and address 2
[   34.234419] usb 2-3: configuration #1 chosen from 1 choice
[   34.459139] usb 2-4: new full speed USB device using ohci_hcd and address 3
[   34.610142] usb 2-4: configuration #1 chosen from 1 choice
[   34.617098] hub 2-4:1.0: USB hub found
[   34.622065] hub 2-4:1.0: 3 ports detected
[   34.923841] usb 2-4.1: new full speed USB device using ohci_hcd and address 4
[   35.027835] usb 2-4.1: configuration #1 chosen from 1 choice
[   35.044754] usbcore: registered new interface driver libusual
[   35.050582] usbcore: registered new interface driver hiddev
[   35.063825] input: Logitech Trackball as /class/input/input0
[   35.069526] input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:02.0-3
[   35.081819] input: Chicony  PFU-65 USB Keyboard as /class/input/input1
[   35.088391] input: USB HID v1.00 Keyboard [Chicony  PFU-65 USB Keyboard] on usb-0000:00:02.0-4.1
[   35.097326] usbcore: registered new interface driver usbhid
[   35.102936] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   35.109260] PNP: No PS/2 controller found. Probing ports directly.
[   35.366820] serio: i8042 KBD port at 0x60,0x64 irq 1
[   35.371945] mice: PS/2 mouse device common for all mice
[   35.377275] md: raid0 personality registered for level 0
[   35.382626] md: raid1 personality registered for level 1
[   35.388021] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[   35.396550] Advanced Linux Sound Architecture Driver Version 1.0.13 (Tue Nov 28 14:07:24 2006 UTC).
[   35.405711] ALSA device list:
[   35.408728]   No soundcards found.
[   35.412223] TCP cubic registered
[   35.415505] NET: Registered protocol family 1
[   35.722234] md: Autodetecting RAID arrays.
[   35.769138] md: autorun ...
[   35.771981] md: considering sdb3 ...
[   35.775604] md:  adding sdb3 ...
[   35.778874] md: sdb1 has different UUID to sdb3
[   35.783448] md:  adding sda3 ...
[   35.786720] md: sda1 has different UUID to sdb3
[   35.791326] md: created md1
[   35.794170] md: bind<sda3>
[   35.796931] md: bind<sdb3>
[   35.799687] md: running: <sdb3><sda3>
[   35.803596] raid1: raid set md1 active with 2 out of 2 mirrors
[   35.809508] md: considering sdb1 ...
[   35.813127] md:  adding sdb1 ...
[   35.816400] md:  adding sda1 ...
[   35.819672] md: created md0
[   35.822512] md: bind<sda1>
[   35.825274] md: bind<sdb1>
[   35.828034] md: running: <sdb1><sda1>
[   35.831938] raid1: raid set md0 active with 2 out of 2 mirrors
[   35.837836] md: ... autorun DONE.
[   35.861366] Filesystem "md0": Disabling barriers, not supported by the underlying device
[   35.869723] XFS mounting filesystem md0
[   35.974203] VFS: Mounted root (xfs filesystem) readonly.
[   35.979614] Freeing unused kernel memory: 256k freed
[   46.500699] lp: driver loaded but no devices found
[   46.523974] Real Time Clock Driver v1.12ac

[ 3038.048201] sdc: assuming drive cache: write through
[ 3038.056198] sdc: assuming drive cache: write through
[10222.410786] sdc: assuming drive cache: write through
[10222.421776] sdc: assuming drive cache: write through

EVENT1... I think at this time I was plugging in my USB key trying to
figure out why /dev/disk was gone.

[10938.054484] NMI Watchdog detected LOCKUP on CPU 1
[10938.059184] CPU 1
[10938.061210] Modules linked in: usb_storage snd_via82xx snd_ens1371 snd_ens1370 gameport snd_ak4531_codec snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_seq_device snd_emu10k1x snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[10938.101118] Pid: 233, comm: kswapd0 Not tainted 2.6.19-rc6-xenon64-smp.10 #1
[10938.108157] RIP: 0010:[<ffffffff810650c9>]  [<ffffffff810650c9>] __write_lock_failed+0x9/0x20
[10938.116688] RSP: 0018:ffff81003f501b80  EFLAGS: 00000083
[10938.121997] RAX: 0000000000000000 RBX: ffff810001eb5870 RCX: 0000000000000036
[10938.129125] RDX: ffff8100050cf938 RSI: ffff810001eb5870 RDI: ffff8100050cf950
[10938.136252] RBP: ffff810001eb5870 R08: 0000000000000001 R09: ffffffff81444d80
[10938.143379] R10: 0000000000000006 R11: 0000000000000001 R12: ffff8100050cf938
[10938.150506] R13: ffff81003f501e90 R14: ffff81003f501d80 R15: ffff8100050cf938
[10938.157634] FS:  00002b385de2c6d0(0000) GS:ffff8100025795c0(0000) knlGS:00000000f7324bb0
[10938.165713] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[10938.171446] CR2: 00002afb375beff0 CR3: 0000000017ad3000 CR4: 00000000000006e0
[10938.178565] Process kswapd0 (pid: 233, threadinfo ffff81003f500000, task ffff81003f494040)
[10938.186816] Stack:  ffffffff81067bbf ffffffff810123ea ffff810001eb5870 ffffffff81444d80
[10938.194890]  ffff810001eb5898 ffffffff810b94d7 0000000000000000 ffff81003f501d70
[10938.202336]  0000000000000001 fffffffffffffffe ffffffff81445308 ffffffff815457e0
[10938.209594] Call Trace:
[10938.212230]  [<ffffffff81067bbf>] _write_lock_irq+0xf/0x10
[10938.217712]  [<ffffffff810123ea>] remove_mapping+0x5a/0xf0
[10938.223194]  [<ffffffff810b94d7>] shrink_inactive_list+0x557/0x850
[10938.229381]  [<ffffffff81012ad4>] shrink_zone+0xe4/0x110
[10938.234687]  [<ffffffff8105b7fe>] kswapd+0x31e/0x470
[10938.239650]  [<ffffffff8109cc30>] autoremove_wake_function+0x0/0x30
[10938.245909]  [<ffffffff8109c9f0>] keventd_create_kthread+0x0/0x80
[10938.251997]  [<ffffffff8105b4e0>] kswapd+0x0/0x470
[10938.256785]  [<ffffffff8109c9f0>] keventd_create_kthread+0x0/0x80
[10938.262874]  [<ffffffff81033859>] kthread+0xd9/0x120
[10938.267839]  [<ffffffff81062ed8>] child_rip+0xa/0x12
[10938.272799]  [<ffffffff8109c9f0>] keventd_create_kthread+0x0/0x80
[10938.278890]  [<ffffffff81033780>] kthread+0x0/0x120
[10938.283762]  [<ffffffff81062ece>] child_rip+0x0/0x12
[10938.288724]
[10938.290211]
[10938.290212] Code: 81 3f 00 00 00 01 75 f6 f0 81 2f 00 00 00 01 0f 85 e2 ff ff
[10938.299273]  <5>statd: server localhost not responding, timed out
[11978.316564] lockd: cannot monitor meson
[11978.320402] lockd: failed to monitor meson
[11982.620868] statd: server localhost not responding, timed out
[11982.626629] lockd: cannot monitor meson
[11982.630462] lockd: failed to monitor meson
[12048.136656] statd: server localhost not responding, timed out
[12048.142419] lockd: cannot monitor meson
[12048.146259] lockd: failed to monitor meson
[12059.702760] statd: server localhost not responding, timed out
[12059.708522] lockd: cannot monitor meson
[12059.712358] lockd: failed to monitor meson
[12096.141632] statd: server localhost not responding, timed out
[12096.147396] lockd: cannot monitor meson
[12096.151231] lockd: failed to monitor meson
[12109.631149] statd: server localhost not responding, timed out
[12109.636910] lockd: cannot monitor meson
[12109.640744] lockd: failed to monitor meson
[12111.292901] statd: server localhost not responding, timed out
[12111.298664] lockd: cannot monitor meson
[12111.302495] lockd: failed to monitor meson
[12112.827687] statd: server localhost not responding, timed out
[12112.833444] lockd: cannot monitor meson
[12112.837283] lockd: failed to monitor meson
[14751.454577] apt-index-watch[18388]: segfault at 00000000a06c7d78 rip 0000000000459cbd rsp 00007fffb6d31fd0 error 4
[19152.300080] statd: server localhost not responding, timed out
[19152.305841] lockd: cannot monitor meson
[19152.309683] lockd: failed to monitor meson
[20284.049066] statd: server localhost not responding, timed out
[20284.054824] lockd: cannot monitor meson
[20284.058658] lockd: failed to monitor meson
[20314.039915] statd: server localhost not responding, timed out
[20314.045675] lockd: cannot monitor meson
[20314.049510] lockd: failed to monitor meson
[20344.098400] statd: server localhost not responding, timed out
[20344.104165] lockd: cannot monitor meson
[20344.108001] lockd: failed to monitor meson
[20345.881462] hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache
[20345.887988] Uniform CD-ROM driver Revision: 3.20
[20402.667944] usb 1-7: USB disconnect, address 7

[23856.264428] statd: server localhost not responding, timed out
[23856.270184] lockd: cannot monitor meson
[23856.274029] lockd: failed to monitor meson
[27246.948121] statd: server localhost not responding, timed out
[27246.953876] lockd: cannot monitor meson
[27246.957708] lockd: failed to monitor meson
[27256.123056] statd: server localhost not responding, timed out
[27256.128819] lockd: cannot monitor meson
[27256.132649] lockd: failed to monitor meson
[27277.053697] statd: server localhost not responding, timed out
[27277.059463] lockd: cannot monitor meson
[27277.063298] lockd: failed to monitor meson
[27307.100407] statd: server localhost not responding, timed out
[27307.106205] lockd: cannot monitor meson
[27307.110043] lockd: failed to monitor meson
[64466.900781] usb 1-2: USB disconnect, address 2
[64493.084575] usb 1-2: new high speed USB device using ehci_hcd and address 8
[64493.208324] usb 1-2: configuration #1 chosen from 1 choice
[65315.654790] usb 1-2: USB disconnect, address 8
[65341.340831] usb 1-2: new high speed USB device using ehci_hcd and address 9
[65341.464578] usb 1-2: configuration #1 chosen from 1 choice

... this is where I noticed that I had no swap.

[72670.632135] Adding 1951888k swap on /dev/sda2.  Priority:-1 extents:1 across:1951888k
[72673.798467] Adding 1951888k swap on /dev/sdb2.  Priority:-2 extents:1 across:1951888k

EVENT2... while switching to a gitk window.

[79869.398641] wish[469]: segfault at 000000000fb1303f rip 00000000f7e3dc49 rsp 00000000ffa93c50 error 4
[79869.708547] Bad page state in process 'ruby'
[79869.708549] page:ffff810001e73f18 flags:0x4000000000080010 mapping:0000000000000000 mapcount:0 count:0
[79869.708551] Trying to fix it up, but a reboot is needed
[79869.708553] Backtrace:
[79869.729680]
[79869.729681] Call Trace:
[79869.733637]  [<ffffffff810b6ec7>] bad_page+0x57/0x90
[79869.738600]  [<ffffffff8100ad32>] free_hot_cold_page+0x82/0x130
[79869.744516]  [<ffffffff81024093>] __pagevec_free+0x23/0x30
[79869.749997]  [<ffffffff8100a766>] release_pages+0x156/0x170
[79869.755567]  [<ffffffff810226c1>] __up_read+0x21/0xb0
[79869.760615]  [<ffffffff8115427a>] xfs_iunlock+0x3a/0xa0
[79869.765838]  [<ffffffff810bf825>] swap_info_get+0x75/0xf0
[79869.771232]  [<ffffffff8100d8ff>] free_pages_and_swap_cache+0x7f/0xa0
[79869.777668]  [<ffffffff81007b8e>] unmap_vmas+0x57e/0x790
[79869.782983]  [<ffffffff8103b8a7>] exit_mmap+0x77/0x100
[79869.788119]  [<ffffffff8103dfbc>] mmput+0x3c/0xd0
[79869.792822]  [<ffffffff8102d0b4>] flush_old_exec+0x6e4/0xa00
[79869.798478]  [<ffffffff8100ac5f>] vfs_read+0x14f/0x1a0
[79869.803614]  [<ffffffff81018003>] load_elf_binary+0x503/0x1cf0
[79869.809442]  [<ffffffff8100c15f>] do_sync_read+0xcf/0x120
[79869.814840]  [<ffffffff81057b8c>] strrchr+0xc/0x30
[79869.819627]  [<ffffffff881077f5>] :binfmt_misc:load_misc_binary+0x75/0x420
[79869.826492]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[79869.831976]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[79869.837458]  [<ffffffff81017639>] copy_strings+0x1b9/0x230
[79869.842940]  [<ffffffff810424aa>] search_binary_handler+0xaa/0x270
[79869.849113]  [<ffffffff81041980>] do_execve+0x1a0/0x270
[79869.854338]  [<ffffffff81057a84>] sys_execve+0x44/0xb0
[79869.859473]  [<ffffffff810624f7>] stub_execve+0x67/0xb0
[79869.864695]
[79870.772381] Eeek! page_mapcount(page) went negative! (-1)
[79870.777784]   page->flags = 4000000000000000
[79870.782055]   page->count = 1
[79870.785023]   page->mapping = 0000000000000000

[79870.789473] ----------- [cut here ] --------- [please bite here ] ---------
[79870.796423] Kernel BUG at mm/rmap.c:578
[79870.800252] invalid opcode: 0000 [1] SMP
[79870.804295] CPU 1
[79870.806321] Modules linked in: ide_cd cdrom usb_storage snd_via82xx snd_ens1371 snd_ens1370 gameport snd_ak4531_codec snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_seq_device snd_emu10k1x snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[79870.847390] Pid: 3059, comm: ruby Tainted: G    B 2.6.19-rc6-xenon64-smp.10 #1
[79870.854604] RIP: 0010:[<ffffffff8100a5ec>]  [<ffffffff8100a5ec>] page_remove_rmap+0x6c/0x90
[79870.862968] RSP: 0000:ffff81002a4b1d48  EFLAGS: 00010292
[79870.868270] RAX: 0000000000000035 RBX: ffff810001e73f18 RCX: ffffffff8143fba8
[79870.875396] RDX: ffffffff8143fba8 RSI: 0000000000000082 RDI: ffffffff8143fba0
[79870.882516] RBP: ffff810001e73f18 R08: 0000000000000000 R09: 0000000000000001
[79870.889644] R10: ffffffff815438a0 R11: ffffffff8107ad70 R12: ffff81002ca87c60
[79870.896772] R13: ffff810001b05a60 R14: ffff81002e46ff00 R15: ffff810001f7ed98
[79870.903898] FS:  00002b111d12dc90(0000) GS:ffff8100025795c0(0000) knlGS:00000000f74716c0
[79870.911978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[79870.917719] CR2: 00002b111d18cf78 CR3: 000000002a188000 CR4: 00000000000006e0
[79870.924847] Process ruby (pid: 3059, threadinfo ffff81002a4b0000, task ffff81003b7ae750)
[79870.932926] Stack:  0000000000000002 ffffffff81010ae8 0000000000000000 ffff81002a897740
[79870.940998]  00002b111d18cf78 ffff81003fd66bc0 00002b111d129520 ffff81002d7d7220
[79870.948445]  8000000027e45065 ffff810001f7ed98 ffffffff815457e0 ffff81002ca87c60
[79870.955702] Call Trace:
[79870.958338]  [<ffffffff81010ae8>] do_wp_page+0x3a8/0x4d0
[79870.963648]  [<ffffffff81008e78>] __handle_mm_fault+0xa98/0xb50
[79870.969566]  [<ffffffff8106a007>] do_page_fault+0x4b7/0x8d0
[79870.975134]  [<ffffffff81023f86>] sys_newstat+0x36/0x50
[79870.980353]  [<ffffffff8106807d>] error_exit+0x0/0x84
[79870.985402]
[79870.986896]
[79870.986896] Code: 0f 0b 68 38 8c 3a 81 c2 42 02 8b 73 18 48 89 df 5b 83 f6 01
[79870.995955] RIP  [<ffffffff8100a5ec>] page_remove_rmap+0x6c/0x90
[79871.001965]  RSP <ffff81002a4b1d48>
[79871.005447]  <0>Bad page state in process 'modprobe'
[79872.097306] page:ffff810001e73f18 flags:0x4000000000000000 mapping:0000000000000000 mapcount:-1 count:1
[79872.097308] Trying to fix it up, but a reboot is needed
[79872.097309] Backtrace:
[79872.117823]
[79872.117824] Call Trace:
[79872.121779]  [<ffffffff810b6ec7>] bad_page+0x57/0x90
[79872.126745]  [<ffffffff8100a0d8>] get_page_from_freelist+0x268/0x360
[79872.133095]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[79872.138575]  [<ffffffff810226c1>] __up_read+0x21/0xb0
[79872.143624]  [<ffffffff81008903>] __handle_mm_fault+0x523/0xb50
[79872.149540]  [<ffffffff81011c5d>] may_open+0x6d/0x270
[79872.154589]  [<ffffffff8106a007>] do_page_fault+0x4b7/0x8d0
[79872.160154]  [<ffffffff8101ec85>] __dentry_open+0x115/0x220
[79872.165725]  [<ffffffff8102849d>] do_filp_open+0x2d/0x40
[79872.171037]  [<ffffffff8106807d>] error_exit+0x0/0x84
[79872.176094]

EVENT3... I try to restart gitk, not knowing about the above.

[79915.285166] Bad page state in process 'wish'
[79915.285168] page:ffffffff81444da8 flags:0x0000000000000000 mapping:000000ba0000002d mapcount:1 count:0
[79915.285170] Trying to fix it up, but a reboot is needed
[79915.285171] Backtrace:
[79915.306299]
[79915.306300] Call Trace:
[79915.310254]  [<ffffffff810b6ec7>] bad_page+0x57/0x90
[79915.315216]  [<ffffffff8100a0d8>] get_page_from_freelist+0x268/0x360
[79915.321567]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[79915.327048]  [<ffffffff81008903>] __handle_mm_fault+0x523/0xb50
[79915.332964]  [<ffffffff8106a007>] do_page_fault+0x4b7/0x8d0
[79915.338537]  [<ffffffff8106807d>] error_exit+0x0/0x84
[79915.343587]  [<ffffffff8100c480>] file_read_actor+0x0/0x150
[79915.349154]
[79915.350655] general protection fault: 0000 [2] SMP
[79915.355558] CPU 0
[79915.357584] Modules linked in: ide_cd cdrom usb_storage snd_via82xx snd_ens1371 snd_ens1370 gameport snd_ak4531_codec snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_seq_device snd_emu10k1x snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[79915.398655] Pid: 29139, comm: wish Tainted: G    B 2.6.19-rc6-xenon64-smp.10 #1
[79915.405953] RIP: 0010:[<ffffffff81064a47>]  [<ffffffff81064a47>] clear_page_c+0x7/0x10
[79915.413878] RSP: 0000:ffff81003df67cc0  EFLAGS: 00010246
[79915.419187] RAX: 0000000000000000 RBX: ffffffff81444da8 RCX: 0000000000000200
[79915.426315] RDX: ffffffff8143fba8 RSI: 0000000000000086 RDI: 0023c9fff9563000
[79915.433440] RBP: ffffffff81444de0 R08: 0000000000000000 R09: 0000000000000000
[79915.440561] R10: ffffffff815438a0 R11: ffffffff8107ad70 R12: 0000000000000001
[79915.447689] R13: ffff810000000000 R14: 6db6db6db6db6db7 R15: ffff81003df67f58
[79915.454815] FS:  00002b4256b3b040(0000) GS:ffffffff814e6000(0063) knlGS:00000000f7b0b6c0
[79915.462894] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
[79915.468627] CR2: 0000000008256a24 CR3: 0000000029ef1000 CR4: 00000000000006e0
[79915.475746] Process wish (pid: 29139, threadinfo ffff81003df66000, task ffff81001d4520c0)
[79915.483912] Stack:  ffffffff8100a148 000000013df67ea8 0000004400000000 000280d200000000
[79915.491984]  ffffffff81445ac0 0000000100000292 0000000000000256 ffffffff815457e0
[79915.499431]  00000040289f86c0 0000000000000001 ffffffff81445ac0 ffff81001d4520c0
[79915.506689] Call Trace:
[79915.509323]  [<ffffffff8100a148>] get_page_from_freelist+0x2d8/0x360
[79915.515673]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[79915.521156]  [<ffffffff81008903>] __handle_mm_fault+0x523/0xb50
[79915.527073]  [<ffffffff8106a007>] do_page_fault+0x4b7/0x8d0
[79915.532642]  [<ffffffff8106807d>] error_exit+0x0/0x84
[79915.537687]  [<ffffffff8100c480>] file_read_actor+0x0/0x150
[79915.543254]
[79915.544743]
[79915.544744] Code: f3 48 ab c3 66 66 90 66 90 eb ee 66 66 66 90 66 66 66 90 66
[79915.553800] RIP  [<ffffffff81064a47>] clear_page_c+0x7/0x10
[79915.559386]  RSP <ffff81003df67cc0>
[79915.562868]  <1>Unable to handle kernel paging request at 0000000000200200 RIP:
[79915.568811]  [<ffffffff81009fde>] get_page_from_freelist+0x16e/0x360
[79915.577625] PGD 3a973067 PUD 3ab5d067 PMD 0
[79915.581938] Oops: 0002 [3] SMP
[79915.585108] CPU 0
[79915.587134] Modules linked in: ide_cd cdrom usb_storage snd_via82xx snd_ens1371 snd_ens1370 gameport snd_ak4531_codec snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_seq_device snd_emu10k1x snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[79915.628203] Pid: 2094, comm: klogd Tainted: G    B 2.6.19-rc6-xenon64-smp.10 #1
[79915.635502] RIP: 0010:[<ffffffff81009fde>]  [<ffffffff81009fde>] get_page_from_freelist+0x16e/0x360
[79915.644544] RSP: 0018:ffff81003ab4dd28  EFLAGS: 00010097
[79915.649844] RAX: ffff810001b23f10 RBX: ffffffff81444dd0 RCX: ffff810001b23ee8
[79915.656970] RDX: 0000000000200200 RSI: 0000000000000000 RDI: ffffffff81444d80
[79915.664090] RBP: 0000000000000001 R08: ffffffff814451c8 R09: ffff810001b5a5e8
[79915.671209] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[79915.678337] R13: ffffffff81444dc0 R14: ffffffff81444d80 R15: 000000000000001f
[79915.685464] FS:  00002b22c4b4f6d0(0000) GS:ffffffff814e6000(0000) knlGS:00000000f7b0b6c0
[79915.693542] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[79915.699277] CR2: 0000000000200200 CR3: 000000003ab8c000 CR4: 00000000000006e0
[79915.706406] Process klogd (pid: 2094, threadinfo ffff81003ab4c000, task ffff81000268c7d0)
[79915.714570] Stack:  0000000100000000 0000004400000000 000200d000000000 ffffffff81445ac0
[79915.722641]  000000013bf81820 0000000000000256 ffffffff815457e0 000000403ab4ded9
[79915.730088]  0000000000000001 ffffffff81445ac0 ffff81000268c7d0 00000000000000d0
[79915.737347] Call Trace:
[79915.739983]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[79915.745467]  [<ffffffff81060f90>] cache_alloc_refill+0x2b0/0x530
[79915.751467]  [<ffffffff8100a229>] kmem_cache_alloc+0x59/0x80
[79915.757120]  [<ffffffff81022dd7>] d_alloc+0x37/0x200
[79915.762085]  [<ffffffff81309964>] sock_attach_fd+0x64/0x120
[79915.767652]  [<ffffffff810120bd>] get_empty_filp+0x8d/0x160
[79915.773221]  [<ffffffff8104f145>] sock_map_fd+0x35/0x80
[79915.778441]  [<ffffffff8130a10f>] sys_socket+0x1f/0x40
[79915.783577]  [<ffffffff8106211e>] system_call+0x7e/0x83
[79915.788800]
[79915.790295]
[79915.790296] Code: 48 89 02 48 89 50 08 75 c9 41 c7 86 40 04 00 00 01 00 00 00
[79915.799354] RIP  [<ffffffff81009fde>] get_page_from_freelist+0x16e/0x360
[79915.806056]  RSP <ffff81003ab4dd28>
[79915.809539] CR2: 0000000000200200
[79915.812845]  <1>Unable to handle kernel paging request at 0000000000100108 RIP:
[79915.817913]  [<ffffffff8100ad82>] free_hot_cold_page+0xd2/0x130
[79915.826287] PGD 0
[79915.828314] Oops: 0002 [4] SMP
[79915.831483] CPU 0
[79915.833510] Modules linked in: ide_cd cdrom usb_storage snd_via82xx snd_ens1371 snd_ens1370 gameport snd_ak4531_codec snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_seq_device snd_emu10k1x snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[79915.874577] Pid: 2094, comm: klogd Tainted: G    B 2.6.19-rc6-xenon64-smp.10 #1
[79915.881870] RIP: 0010:[<ffffffff8100ad82>]  [<ffffffff8100ad82>] free_hot_cold_page+0xd2/0x130
[79915.890488] RSP: 0018:ffff81003ab4d868  EFLAGS: 00010002
[79915.895797] RAX: ffff81000227da10 RBX: ffff81000227d9e8 RCX: 0000000000000000
[79915.902923] RDX: 0000000000100100 RSI: 0000000000000000 RDI: ffffffff81444dd0
[79915.910052] RBP: ffffffff81444dc0 R08: 000000003fc95025 R09: ffffffff81444d80
[79915.917178] R10: 0000000000000001 R11: ffffffff81031090 R12: 0000000000000256
[79915.924305] R13: ffffffff81444d80 R14: 000000000000000e R15: ffff8100023c57f8
[79915.931433] FS:  00002b22c4b4f6d0(0000) GS:ffffffff814e6000(0000) knlGS:00000000f7b0b6c0
[79915.939512] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[79915.945245] CR2: 0000000000100108 CR3: 0000000001001000 CR4: 00000000000006e0
[79915.952366] Process klogd (pid: 2094, threadinfo ffff81003ab4c000, task ffff81000268c7d0)
[79915.960529] Stack:  0000000000000034 0000000000000008 ffff81003ab4d8b8 ffff8100023c5868
[79915.968601]  000000000000000e ffffffff81024093 0000000000000001 ffff81000227d9e8
[79915.976050]  ffffffff81444d80 ffffffff8100a766 000000000000000a 0000000000000000
[79915.983306] Call Trace:
[79915.985942]  [<ffffffff81024093>] __pagevec_free+0x23/0x30
[79915.991422]  [<ffffffff8100a766>] release_pages+0x156/0x170
[79915.996996]  [<ffffffff8122b520>] serial8250_console_putchar+0x0/0xa0
[79916.003428]  [<ffffffff8100d8ff>] free_pages_and_swap_cache+0x7f/0xa0
[79916.009862]  [<ffffffff81007a91>] unmap_vmas+0x481/0x790
[79916.015176]  [<ffffffff8103b8a7>] exit_mmap+0x77/0x100
[79916.020306]  [<ffffffff8103dfbc>] mmput+0x3c/0xd0
[79916.025009]  [<ffffffff81015144>] do_exit+0x214/0x8e0
[79916.030061]  [<ffffffff8106a319>] do_page_fault+0x7c9/0x8d0
[79916.035624]  [<ffffffff81008fb5>] __d_lookup+0x85/0x120
[79916.040840]  [<ffffffff8100b941>] _atomic_dec_and_lock+0x41/0x80
[79916.046842]  [<ffffffff8102d9b4>] mntput_no_expire+0x24/0xb0
[79916.052498]  [<ffffffff8106807d>] error_exit+0x0/0x84
[79916.057547]  [<ffffffff81009fde>] get_page_from_freelist+0x16e/0x360
[79916.063893]  [<ffffffff81009fbd>] get_page_from_freelist+0x14d/0x360
[79916.070243]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[79916.075724]  [<ffffffff81060f90>] cache_alloc_refill+0x2b0/0x530
[79916.081725]  [<ffffffff8100a229>] kmem_cache_alloc+0x59/0x80
[79916.087379]  [<ffffffff81022dd7>] d_alloc+0x37/0x200
[79916.092342]  [<ffffffff81309964>] sock_attach_fd+0x64/0x120
[79916.097911]  [<ffffffff810120bd>] get_empty_filp+0x8d/0x160
[79916.103480]  [<ffffffff8104f145>] sock_map_fd+0x35/0x80
[79916.108702]  [<ffffffff8130a10f>] sys_socket+0x1f/0x40
[79916.113836]  [<ffffffff8106211e>] system_call+0x7e/0x83
[79916.119059]
[79916.120554]
[79916.120555] Code: 48 89 42 08 48 89 53 28 48 89 78 08 48 89 45 10 8b 45 00 ff
[79916.129614] RIP  [<ffffffff8100ad82>] free_hot_cold_page+0xd2/0x130
[79916.135883]  RSP <ffff81003ab4d868>
[79916.139364] CR2: 0000000000100108
[79916.142672]  <1>Fixing recursive fault but reboot is needed!

EVENT4... everything dies.

[79921.294125] NMI Watchdog detected LOCKUP on CPU 0
[79921.298824] CPU 0
[79921.300849] Modules linked in: ide_cd cdrom usb_storage snd_via82xx snd_ens1371 snd_ens1370 gameport snd_ak4531_codec snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_seq_device snd_emu10k1x snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[79921.341918] Pid: 8, comm: events/0 Tainted: G    B 2.6.19-rc6-xenon64-smp.10 #1
[79921.349210] RIP: 0010:[<ffffffff81067a37>]  [<ffffffff81067a37>] _spin_lock+0x7/0x10
[79921.356962] RSP: 0018:ffff81003ff43d58  EFLAGS: 00000082
[79921.362270] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff810080e82f40
[79921.369398] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffffff814451c0
[79921.376525] RBP: 0000000000000001 R08: ffffffff81444e05 R09: 0000000000000000
[79921.383652] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[79921.390771] R13: ffff810001dc27f0 R14: ffffffff81444d80 R15: 0000000000000001
[79921.397900] FS:  00002b22c4b4f6d0(0000) GS:ffffffff814e6000(0000) knlGS:00000000f7b0b6c0
[79921.405978] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[79921.411720] CR2: 0000000000100108 CR3: 0000000001001000 CR4: 00000000000006e0
[79921.418848] Process events/0 (pid: 8, threadinfo ffff81003ff42000, task ffff81003f43c850)
[79921.427013] Stack:  ffffffff810b7054 0000000000000246 ffff81003ac639c0 ffff81003d545ae0
[79921.435085]  ffff810024b92140 ffff810024b92000 ffff81003d545b00 0000000000000002
[79921.442534]  ffffffff810c52d3 ffff81003a96b200 ffff81003d545ac0 ffff81003d545ae0
[79921.449789] Call Trace:
[79921.452424]  [<ffffffff810b7054>] __free_pages_ok+0xe4/0x2f0
[79921.458081]  [<ffffffff810c52d3>] slab_destroy+0x83/0xb0
[79921.463388]  [<ffffffff810c55b9>] drain_freelist+0x79/0xb0
[79921.468871]  [<ffffffff810c6010>] cache_reap+0x0/0x130
[79921.474006]  [<ffffffff810c60f2>] cache_reap+0xe2/0x130
[79921.479227]  [<ffffffff8104fb22>] run_workqueue+0xb2/0x110
[79921.484709]  [<ffffffff8104be10>] worker_thread+0x0/0x160
[79921.490104]  [<ffffffff8104bf31>] worker_thread+0x121/0x160
[79921.495674]  [<ffffffff81088750>] default_wake_function+0x0/0x10
[79921.501677]  [<ffffffff8104be10>] worker_thread+0x0/0x160
[79921.507070]  [<ffffffff81033859>] kthread+0xd9/0x120
[79921.512034]  [<ffffffff81062ed8>] child_rip+0xa/0x12
[79921.516998]  [<ffffffff81033780>] kthread+0x0/0x120
[79921.521870]  [<ffffffff81062ece>] child_rip+0x0/0x12
[79921.526823]
[79921.528312]

-- 
				WebSig: http://www.jukie.net/~bart/sig/
