Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWF0R4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWF0R4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWF0R4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:56:05 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:50016 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161232AbWF0R4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:56:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=dGr9kkZmRfLMN9Yc3+4S0I/o18jb5fPa14ZbCIgYsnDnCgNV/NMKXUuUsZzgQ4FxfwBJYuRtM4VOfjRTTjvtat4eyf0B1HfqGYhzX/FtsEiW7ilsgb6fKs92K0R85QQYq46izIscnjCS6dOou3gYHNy7I7xZkfuNxFipZ/So2Og=
Date: Tue, 27 Jun 2006 23:25:43 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Fixing recursive fault but reboot is needed!
Message-ID: <20060627175543.GA28379@satan.machinehead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[17179569.184000] Linux version 2.6.15-25-386 (buildd@terranova) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 PREEMPT Wed Jun 14 11:25:49 UTC 2006
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000001fe40000 (usable)
[17179569.184000]  BIOS-e820: 000000001fe40000 - 000000001fe50000 (ACPI data)
[17179569.184000]  BIOS-e820: 000000001fe50000 - 000000001ff00000 (ACPI NVS)
[17179569.184000] 0MB HIGHMEM available.
[17179569.184000] 510MB LOWMEM available.
[17179569.184000] found SMP MP-table at 000ff780
[17179569.184000] On node 0 totalpages: 130624
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   DMA32 zone: 0 pages, LIFO batch:0
[17179569.184000]   Normal zone: 126528 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 0 pages, LIFO batch:0
[17179569.184000] DMI 2.3 present.
[17179569.184000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f7170
[17179569.184000] ACPI: RSDT (v001 INTEL  D845GBV2 0x20030226 MSFT 0x00000097) @ 0x1fe40000
[17179569.184000] ACPI: FADT (v002 INTEL  D845GBV2 0x20030226 MSFT 0x00000097) @ 0x1fe40200
[17179569.184000] ACPI: MADT (v001 INTEL  D845GBV2 0x20030226 MSFT 0x00000097) @ 0x1fe40300
[17179569.184000] ACPI: ASF! (v016 AMIASF I845GASF 0x00000001 MSFT 0x0100000d) @ 0x1fe44350
[17179569.184000] ACPI: DSDT (v001 INTEL  D845GBV2 0x0000010a MSFT 0x0100000d) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x408
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 15:2 APIC version 20
[17179569.184000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 20000000 (gap: 1ff00000:e0100000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/hda3 ro quiet splash
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[17179569.184000] Detected 2400.399 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179570.612000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179570.612000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179570.624000] Memory: 507444k/522496k available (1976k kernel code, 14400k reserved, 606k data, 288k init, 0k highmem)
[17179570.624000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179570.704000] Calibrating delay using timer specific routine.. 4805.04 BogoMIPS (lpj=9610089)
[17179570.704000] Security Framework v1.0.0 initialized
[17179570.704000] SELinux:  Disabled at boot.
[17179570.704000] Mount-cache hash table entries: 512
[17179570.704000] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[17179570.704000] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[17179570.704000] CPU: Trace cache: 12K uops, L1 D cache: 8K
[17179570.704000] CPU: L2 cache: 512K
[17179570.704000] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[17179570.704000] mtrr: v2.0 (20020519)
[17179570.704000] CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
[17179570.704000] Enabling fast FPU save and restore... done.
[17179570.704000] Enabling unmasked SIMD FPU exception support... done.
[17179570.704000] Checking 'hlt' instruction... OK.
[17179570.720000] checking if image is initramfs... it is
[17179571.288000] Freeing initrd memory: 6613k freed
[17179571.304000] ACPI: Looking for DSDT ... not found!
[17179571.308000] ENABLING IO-APIC IRQs
[17179571.308000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179571.452000] NET: Registered protocol family 16
[17179571.452000] EISA bus registered
[17179571.452000] ACPI: bus type pci registered
[17179571.452000] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
[17179571.452000] PCI: Using configuration type 1
[17179571.452000] ACPI: Subsystem revision 20051216
[17179571.456000] ACPI: Interpreter enabled
[17179571.456000] ACPI: Using IOAPIC for interrupt routing
[17179571.456000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179571.456000] PCI: Probing PCI hardware (bus 00)
[17179571.460000] Boot video device is 0000:00:02.0
[17179571.460000] PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
[17179571.460000] PCI quirk: region 0480-04bf claimed by ICH4 GPIO
[17179571.460000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[17179571.460000] PCI: Transparent bridge - 0000:00:1e.0
[17179571.460000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179571.460000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[17179571.464000] ACPI: Power Resource [URP1] (off)
[17179571.464000] ACPI: Power Resource [FDDP] (off)
[17179571.464000] ACPI: Power Resource [LPTP] (off)
[17179571.464000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[17179571.464000] ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
[17179571.464000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[17179571.468000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[17179571.468000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[17179571.468000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[17179571.468000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[17179571.468000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[17179571.468000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179571.468000] pnp: PnP ACPI init
[17179571.472000] pnp: PnP ACPI: found 13 devices
[17179571.472000] PnPBIOS: Disabled by ACPI PNP
[17179571.472000] PCI: Using ACPI for IRQ routing
[17179571.472000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179571.476000] pnp: 00:0b: ioport range 0x400-0x47f could not be reserved
[17179571.476000] pnp: 00:0b: ioport range 0x680-0x6ff has been reserved
[17179571.476000] pnp: 00:0b: ioport range 0x480-0x4bf has been reserved
[17179571.476000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179571.476000] PCI: Bridge: 0000:00:1e.0
[17179571.476000]   IO window: d000-dfff
[17179571.476000]   MEM window: ff800000-ff8fffff
[17179571.476000]   PREFETCH window: e6a00000-e6afffff
[17179571.476000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179571.476000] audit: initializing netlink socket (disabled)
[17179571.476000] audit(1151413134.476:1): initialized
[17179571.476000] VFS: Disk quotas dquot_6.5.1
[17179571.476000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179571.476000] Initializing Cryptographic API
[17179571.476000] io scheduler noop registered
[17179571.476000] io scheduler anticipatory registered
[17179571.476000] io scheduler deadline registered
[17179571.476000] io scheduler cfq registered
[17179571.476000] isapnp: Scanning for PnP cards...
[17179571.832000] isapnp: No Plug & Play device found
[17179571.848000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[17179571.848000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179571.848000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.848000] Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
[17179571.852000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[17179571.852000] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[17179571.852000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[17179571.852000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179571.852000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179571.852000] mice: PS/2 mouse device common for all mice
[17179571.852000] EISA: Probing bus 0 at eisa.0
[17179571.852000] EISA: Detected 0 cards.
[17179571.852000] NET: Registered protocol family 2
[17179571.884000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179571.892000] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[17179571.892000] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[17179571.892000] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[17179571.892000] TCP: Hash tables configured (established 16384 bind 16384)
[17179571.892000] TCP reno registered
[17179571.892000] TCP bic registered
[17179571.892000] NET: Registered protocol family 1
[17179571.892000] NET: Registered protocol family 8
[17179571.892000] NET: Registered protocol family 20
[17179571.892000] Using IPI Shortcut mode
[17179571.892000] ACPI wakeup devices: 
[17179571.892000] P0P1 UAR1 USB0 USB1 USB2 USB3 AC97 SLPB 
[17179571.892000] ACPI: (supports S0 S1 S4 S5)
[17179571.892000] Freeing unused kernel memory: 288k freed
[17179571.940000] vga16fb: initializing
[17179571.940000] vga16fb: mapped to 0xc00a0000
[17179572.056000] Console: switching to colour frame buffer device 80x25
[17179572.056000] fb0: VGA16 VGA frame buffer device
[17179573.076000] Capability LSM initialized
[17179573.184000] ACPI: Processor [CPU1] (supports 8 throttling states)
[17179573.728000] ICH4: IDE controller at PCI slot 0000:00:1f.1
[17179573.728000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[17179573.728000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 169
[17179573.728000] ICH4: chipset revision 2
[17179573.728000] ICH4: not 100% native mode: will probe irqs later
[17179573.728000]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
[17179573.728000]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
[17179573.728000] Probing IDE interface ide0...
[17179574.020000] hda: ST380011A, ATA DISK drive
[17179574.692000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[17179574.696000] Probing IDE interface ide1...
[17179575.432000] hdc: SAMSUNG DVD-ROM SD-616Q, ATAPI CD/DVD-ROM drive
[17179575.768000] ide1 at 0x170-0x177,0x376 on irq 15
[17179575.772000] hda: max request size: 1024KiB
[17179575.784000] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
[17179575.784000] hda: cache flushes supported
[17179575.784000]  hda: hda1 hda2 hda3 hda4
[17179575.804000] hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
[17179575.804000] Uniform CD-ROM driver Revision: 3.20
[17179576.164000] usbcore: registered new driver usbfs
[17179576.164000] usbcore: registered new driver hub
[17179576.168000] USB Universal Host Controller Interface driver v2.3
[17179576.168000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179576.168000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179576.168000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179576.168000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179576.168000] uhci_hcd 0000:00:1d.0: irq 177, io base 0x0000e800
[17179576.168000] hub 1-0:1.0: USB hub found
[17179576.168000] hub 1-0:1.0: 2 ports detected
[17179576.272000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 185
[17179576.272000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179576.272000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179576.272000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179576.272000] uhci_hcd 0000:00:1d.1: irq 185, io base 0x0000e880
[17179576.272000] hub 2-0:1.0: USB hub found
[17179576.272000] hub 2-0:1.0: 2 ports detected
[17179576.376000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 169
[17179576.376000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179576.376000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[17179576.376000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[17179576.376000] uhci_hcd 0000:00:1d.2: irq 169, io base 0x0000ec00
[17179576.376000] hub 3-0:1.0: USB hub found
[17179576.376000] hub 3-0:1.0: 2 ports detected
[17179576.480000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
[17179576.480000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179576.480000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179576.480000] ehci_hcd 0000:00:1d.7: debug port 1
[17179576.480000] PCI: cache line size of 128 is not supported by device 0000:00:1d.7
[17179576.480000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
[17179576.480000] ehci_hcd 0000:00:1d.7: irq 193, io mem 0xffa7fc00
[17179576.484000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179576.484000] hub 4-0:1.0: USB hub found
[17179576.484000] hub 4-0:1.0: 6 ports detected
[17179576.744000] Attempting manual resume
[17179586.908000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179586.912000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179586.960000] hw_random hardware driver 1.0.0 loaded
[17179587.212000] input: PC Speaker as /class/input/input1
[17179587.252000] Real Time Clock Driver v1.12
[17179587.272000] Linux agpgart interface v0.101 (c) Dave Jones
[17179587.332000] agpgart: Detected an Intel 845G Chipset.
[17179587.332000] agpgart: Detected 892K stolen memory.
[17179587.348000] agpgart: AGP aperture is 128M @ 0xf0000000
[17179587.360000] parport: PnPBIOS parport detected.
[17179587.360000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[17179587.384000] Floppy drive(s): fd0 is 1.44M
[17179587.424000] FDC 0 is a National Semiconductor PC87306
[17179587.484000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 201
[17179587.484000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[17179587.492000] i810_smbus 0000:00:02.0: i810/i815 i2c device found.
[17179587.740000] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
[17179587.800000] intel8x0_measure_ac97_clock: measured 53708 usecs
[17179587.800000] intel8x0: clocking to 48000
[17179587.940000] ts: Compaq touchscreen protocol output
[17179587.980000] 8139too Fast Ethernet driver 0.9.27
[17179587.980000] ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 19 (level, low) -> IRQ 185
[17179587.980000] eth0: RealTek RTL8139 at 0xe0986c00, 00:08:a1:8e:cd:88, IRQ 185
[17179587.980000] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[17179587.996000] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[17179588.580000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[17179589.840000] lp0: using parport0 (interrupt-driven).
[17179589.900000] Adding 987988k swap on /dev/hda2.  Priority:-1 extents:1 across:987988k
[17179590.180000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[17179590.180000] md: bitmap version 4.39
[17179590.684000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[17179591.164000] cdrom: open failed.
[17179594.580000] kjournald starting.  Commit interval 5 seconds
[17179594.580000] EXT3 FS on hda1, internal journal
[17179594.580000] EXT3-fs: mounted filesystem with ordered data mode.
[17179594.628000] ReiserFS: hda4: found reiserfs format "3.6" with standard journal
[17179594.632000] ReiserFS: hda4: using ordered data mode
[17179594.632000] ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[17179594.636000] ReiserFS: hda4: checking transaction log (hda4)
[17179594.648000] ReiserFS: hda4: Using r5 hash to sort names
[17179596.124000] NET: Registered protocol family 17
[17179600.308000] ACPI: Power Button (FF) [PWRF]
[17179600.308000] ACPI: Sleep Button (CM) [SLPB]
[17179600.420000] ibm_acpi: ec object not found
[17179600.452000] pcc_acpi: loading...
[17179604.588000] [drm] Initialized drm 1.0.1 20051102
[17179604.588000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179604.596000] [drm] Initialized i915 1.4.0 20060119 on minor 0
[17179605.400000] ppdev: user-space parallel port driver
[17179605.800000] apm: BIOS not found.
[17179608.280000] NET: Registered protocol family 10
[17179608.280000] lo: Disabled Privacy Extensions
[17179608.280000] IPv6 over IPv4 tunneling driver
[17179613.580000] Bluetooth: Core ver 2.8
[17179613.580000] NET: Registered protocol family 31
[17179613.580000] Bluetooth: HCI device and connection manager initialized
[17179613.580000] Bluetooth: HCI socket layer initialized
[17179613.596000] Bluetooth: L2CAP ver 2.8
[17179613.596000] Bluetooth: L2CAP socket layer initialized
[17179613.600000] Bluetooth: RFCOMM socket layer initialized
[17179613.600000] Bluetooth: RFCOMM TTY layer initialized
[17179613.600000] Bluetooth: RFCOMM ver 1.7
[17179618.580000] eth0: no IPv6 routers present
[17194423.960000] loop: loaded (max 8 devices)
[17194672.556000] ------------[ cut here ]------------
[17194672.556000] kernel BUG at mm/rmap.c:486!
[17194672.556000] invalid operand: 0000 [#1]
[17194672.556000] PREEMPT 
[17194672.556000] Modules linked in: loop rfcomm l2cap bluetooth ipv6 ppdev i915 drm speedstep_lib cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative video tc1100_wmi sony_acpi pcc_acpi hotkey dev_acpi container button acpi_sbs battery ac i2c_acpi_ec af_packet reiserfs ext3 jbd dm_mod md_mod lp 8139cp 8139too tsdev mii i2c_i810 snd_intel8x0 snd_ac97_codec snd_ac97_bus i2c_algo_bit snd_pcm_oss snd_mixer_oss i2c_core floppy parport_pc parport intel_agp snd_pcm snd_timer agpgart rtc pcspkr snd soundcore snd_page_alloc psmouse hw_random serio_raw shpchp pci_hotplug evdev ext2 ide_generic ehci_hcd uhci_hcd usbcore ide_cd cdrom ide_disk piix generic thermal processor fan capability commoncap vga16fb vgastate fbcon tileblit font bitblit softcursor
[17194672.556000] CPU:    0
[17194672.556000] EIP:    0060:[<c0155a72>]    Not tainted VLI
[17194672.556000] EFLAGS: 00010286   (2.6.15-25-386) 
[17194672.556000] EIP is at page_remove_rmap+0x22/0x30
[17194672.556000] eax: ffffffff   ebx: cf90d110   ecx: c03dc944   edx: c11da2e0
[17194672.556000] esi: 40044000   edi: c11da2e0   ebp: 00000020   esp: d28f7dcc
[17194672.556000] ds: 007b   es: 007b   ss: 0068
[17194672.556000] Process as (pid: 25485, threadinfo=d28f6000 task=c8228550)
[17194672.556000] Stack: c014eeaf c11da2e0 df9e7580 fffffff8 00000000 d11e3400 400b4000 d28f7e54 
[17194672.556000]        d11e3400 c014f122 c03dc944 d067c544 d11e3400 40035000 400b4000 d28f7e54 
[17194672.556000]        00000000 d11e3400 400b3fff d067c544 40035000 400b4000 d28f6000 c014f22e 
[17194672.556000] Call Trace:
[17194672.556000]  [<c014eeaf>] zap_pte_range+0x10f/0x2a0
[17194672.556000]  [<c014f122>] unmap_page_range+0xe2/0x130
[17194672.556000]  [<c014f22e>] unmap_vmas+0xbe/0x210
[17194672.556000]  [<c0153cec>] exit_mmap+0x5c/0xf0
[17194672.556000]  [<c0119dfd>] mmput+0x2d/0x90
[17194672.556000]  [<c011ec29>] do_exit+0xf9/0x420
[17194672.556000]  [<c011efbf>] do_group_exit+0x2f/0xb0
[17194672.556000]  [<c0128715>] get_signal_to_deliver+0x205/0x330
[17194672.556000]  [<c0102e54>] do_signal+0x44/0x110
[17194672.556000]  [<c0150c91>] do_no_page+0x161/0x2d0
[17194672.556000]  [<c0150f25>] __handle_mm_fault+0xa5/0x210
[17194672.556000]  [<c0116b2f>] do_page_fault+0x30f/0x61a
[17194672.556000]  [<c0116820>] do_page_fault+0x0/0x61a
[17194672.556000]  [<c0102f47>] do_notify_resume+0x27/0x40
[17194672.556000]  [<c010313e>] work_notifysig+0x13/0x25
[17194672.556000] Code: 0b d6 01 d5 22 30 c0 eb ba 8b 54 24 04 83 42 08 ff 0f 98 c0 84 c0 75 01 c3 8b 42 08 40 78 0c 6a ff 6a 10 e8 b1 f4 fe ff 59 58 c3 <0f> 0b e6 01 d5 22 30 c0 eb ea 8d 74 26 00 55 57 56 53 83 ec 0c 
[17194672.556000]  <1>Fixing recursive fault but reboot is needed!
[17194672.556000] scheduling while atomic: as/0x00000003/25485
[17194672.556000]  [<c02ec552>] schedule+0x5c2/0x690
[17194672.556000]  [<c0155a86>] try_to_unmap_one+0x6/0x1b0
[17194672.556000]  [<c0104c30>] do_invalid_op+0x0/0xa0
[17194672.556000]  [<c0104c30>] do_invalid_op+0x0/0xa0
[17194672.556000]  [<c011ee30>] do_exit+0x300/0x420
[17194672.556000]  [<c0104c30>] do_invalid_op+0x0/0xa0
[17194672.556000]  [<c0104973>] die+0x163/0x170
[17194672.556000]  [<c0104cbc>] do_invalid_op+0x8c/0xa0
[17194672.556000]  [<c0155a72>] page_remove_rmap+0x22/0x30
[17194672.556000]  [<e0bdf524>] reiserfs_add_entry+0x304/0x430 [reiserfs]
[17194672.556000]  [<e0bdf4d4>] reiserfs_add_entry+0x2b4/0x430 [reiserfs]
[17194672.556000]  [<c01041ff>] error_code+0x4f/0x60
[17194672.556000]  [<c0155a72>] page_remove_rmap+0x22/0x30
[17194672.556000]  [<c014eeaf>] zap_pte_range+0x10f/0x2a0
[17194672.556000]  [<c014f122>] unmap_page_range+0xe2/0x130
[17194672.556000]  [<c014f22e>] unmap_vmas+0xbe/0x210
[17194672.556000]  [<c0153cec>] exit_mmap+0x5c/0xf0
[17194672.556000]  [<c0119dfd>] mmput+0x2d/0x90
[17194672.556000]  [<c011ec29>] do_exit+0xf9/0x420
[17194672.556000]  [<c011efbf>] do_group_exit+0x2f/0xb0
[17194672.556000]  [<c0128715>] get_signal_to_deliver+0x205/0x330
[17194672.556000]  [<c0102e54>] do_signal+0x44/0x110
[17194672.556000]  [<c0150c91>] do_no_page+0x161/0x2d0
[17194672.556000]  [<c0150f25>] __handle_mm_fault+0xa5/0x210
[17194672.556000]  [<c0116b2f>] do_page_fault+0x30f/0x61a
[17194672.556000]  [<c0116820>] do_page_fault+0x0/0x61a
[17194672.556000]  [<c0102f47>] do_notify_resume+0x27/0x40
[17194672.556000]  [<c010313e>] work_notifysig+0x13/0x25
