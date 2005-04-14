Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVDNU4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDNU4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVDNU4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:56:23 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:56468 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261378AbVDNUz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:55:27 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
Subject: [2.6.12-rc2][panic][NET] qdisc_restart -  When loading ipw2200 driver - not mangled
Date: Thu, 14 Apr 2005 16:55:21 -0400
User-Agent: KMail/1.7.2
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504141655.21440.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the dmesg/panic dump:

Any problems with the Network scheduling in 2.6.12-rc2?

[4294667.296000] Linux version 2.6.12-rc2 (root@segfault) (gcc version 4.0.0 20050319 (prerelease)) #1 Wed Apr 13 11:38:19 EDT 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[4294667.296000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000003ff60000 (usable)
[4294667.296000]  BIOS-e820: 000000003ff60000 - 000000003ff77000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
[4294667.296000] 127MB HIGHMEM available.
[4294667.296000] 896MB LOWMEM available.
[4294667.296000] DMI present.
[4294667.296000] ACPI: PM-Timer IO Port: 0x1008
[4294667.296000] Allocating PCI resources starting at 40000000 (gap: 40000000:bf800000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/hda1 ro acpi_sleep=s3_bios hdc=ide-cd lapic netconsole=@172.25.244.212/eth0,9353@172.25.244.222/00:0D:60:3C:3A:3F
[4294667.296000] ide_setup: hdc=ide-cd
[4294667.296000] netconsole: local port 6665
[4294667.296000] netconsole: local IP 172.25.244.212
[4294667.296000] netconsole: interface eth0
[4294667.296000] netconsole: remote port 9353
[4294667.296000] netconsole: remote IP 172.25.244.222
[4294667.296000] netconsole: remote ethernet address 00:0d:60:3c:3a:3f
[4294667.296000] Local APIC disabled by BIOS -- reenabling.
[4294667.296000] Found and enabled local APIC!
[4294667.296000] Initializing CPU#0
[4294667.296000] CPU 0 irqstacks, hard=c060a000 soft=c0609000
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 1798.930 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294670.127000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[4294670.127000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294670.160000] Memory: 1032876k/1047936k available
(3693k kernel code, 14480k reserved, 1200k data, 236k init, 130432k highmem)
[4294670.160000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294670.183000] Mount-cache hash table entries: 512
[4294670.183000] CPU: L1 I cache: 32K, L1 D cache: 32K
[4294670.183000] CPU: L2 cache: 2048K
[4294670.183000] Intel machine check architecture supported.
[4294670.183000] Intel machine check reporting enabled on CPU#0.
[4294670.183000] CPU: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
[4294670.183000] Enabling fast FPU save and restore... done.
[4294670.183000] Enabling unmasked SIMD FPU exception support... done.
[4294670.183000] Checking 'hlt' instruction... OK.
[4294670.187000]  tbxface-0118 [02] acpi_load_tables : ACPI Tables successfully acquired
[4294670.399000] Parsing all Control Methods:..................................................................................................................................................
..........................................................................................................................................................
....................................................................................................... 
[4294670.869000] Table [DSDT](id F005) - 1342 Objects with 64 Devices 403 Methods 19 Regions
[4294670.869000] Parsing all Control Methods:.
[4294670.870000] Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
[4294670.870000] ACPI Namespace successfully loaded at root c0632620
[4294670.870000] ACPI: setting ELCR to 0200 (from 0e28)
[4294670.880000] evxfevnt-0094 [03] acpi_enable   : Transition to ACPI mode successful
[4294670.982000] NET: Registered protocol family 16
[4294670.983000] PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
[4294670.983000] PCI: Using configuration type 1
[4294670.983000] mtrr: v2.0 (20020519)
[4294670.991000] ACPI: Subsystem revision 20050309
[4294671.006000] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
[4294671.006000] evgpeblk-0987 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0
Runtime GPEs in this block
[4294671.007000] ACPI: Found ECDT
[4294671.017000] Completing Region/Field/Buffer/Package initialization:..............................................................
..........................................................................................................................................................
.................................... 
[4294671.249000] Initialized 18/19 Regions 123/123 Fields 72/72 Buffers 39/46 Packages (1352 nodes)
[4294671.249000] Executing all Device _STA and_INI methods:..............................................................
[4294671.560000] 62 Devices found containing: 62 _STA, 8 _INI methods
[4294671.560000] ACPI: Interpreter enabled
[4294671.560000] ACPI: Using PIC for interrupt routing
[4294671.584000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
[4294671.607000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
[4294671.630000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11)
[4294671.652000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[4294671.669000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[4294671.687000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[4294671.704000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[4294671.726000] ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11)
[4294671.736000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294671.736000] PCI: Probing PCI hardware (bus 00)
[4294671.737000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[4294671.738000] PCI: Transparent bridge - 0000:00:1e.0
[4294671.772000] ACPI: Embedded Controller [EC] (gpe 28)
[4294671.777000] ACPI: Power Resource [PUBS] (on)
[4294671.857000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294671.857000] pnp: PnP ACPI init
[4294671.977000] pnp: PnP ACPI: found 12 devices
[4294671.977000] PnPBIOS: Disabled by ACPI PNP
[4294671.979000] SCSI subsystem initialized
[4294671.979000] Linux Kernel Card Services
[4294671.979000]   options:  [pci] [cardbus] [pm]
[4294671.980000] usbcore: registered new driver usbfs
[4294671.980000] usbcore: registered new driver hub
[4294671.980000] PCI: Using ACPI for IRQ routing
[4294671.980000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294671.991000] NET: Registered protocol family 23
[4294671.992000] Bluetooth: Core ver 2.7
[4294671.992000] NET: Registered protocol family 31
[4294671.992000] Bluetooth: HCI device and connection manager initialized
[4294671.992000] Bluetooth: HCI socket layer initialized
[4294672.027000] Simple Boot Flag at 0x35 set to 0x1
[4294672.027000] Machine check exception polling timer started.
[4294672.028000] IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
[4294672.034000] highmem bounce pool size: 64 pages
[4294672.034000] Initializing Cryptographic API
[4294672.034000] pci_hotplug: PCI Hot Plug PCI Coreversion: 0.5
[4294672.034000] ibmphpd: IBM Hot Plug PCI Control ler Driver version: 0.6
[4294672.034000] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
[4294672.074000] acpiphp: Slot [4294967295] registered
[4294672.205000] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[4294672.206000] ACPI: AC Adapter [AC] (on-line)
[4294672.297000] ACPI: Battery Slot [BAT0] (battery present)
[4294672.297000] ACPI: Power Button (FF) [PWRF]
[4294672.297000] ACPI: Lid Switch [LID]
[4294672.297000] ACPI: Sleep Button (CM) [SLPB]
[4294672.307000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[4294672.316000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294672.316000] ACPI: Processor [CPU] (supports 8 throttling states)
[4294672.335000] ACPI: Thermal Zone [THM0] (49 C)
[4294672.335000] ibm_acpi: IBM ThinkPad ACPI Extras v0.8
[4294672.335000] ibm_acpi: http://ibm-acpi.sf.net/
[4294672.344000] acpi_bus-0077 [95] acpi_bus_get_device   : No context for object [c1905d24]
[4294672.344000] ibm_acpi: dock device not present
[4294672.349000] isapnp: Scanning for PnP cards...
[4294672.703000] isapnp: No Plug & Play device found
[4294672.758000] lp: driver loaded but no devices found
[4294672.759000] Real Time Clock Driver v1.12
[4294672.759000] Non-volatile memory driver v1.2
[4294672.759000] hw_random: RNG not detected
[4294672.759000] Linux agpgart interface v0.101 (c)Dave Jones
[4294672.759000] agpgart: Detected an Intel 855PM Chipset.
[4294672.773000] agpgart: AGP aperture is 256M @ 0xd0000000
[4294672.773000] Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
[4294672.774000] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[4294672.779000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294672.780000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294672.805000] pnp: Device 00:09 activated.
[4294672.805000] parport: PnPBIOS parport detected.
[4294672.805000] parport0: PC-style at 0x3bc, irq 7 [PCSPP,TRISTATE]
[4294672.887000] lp0: using parport0 (interrupt-driven).
[4294672.887000] io scheduler noop registered
[4294672.887000] io scheduler anticipatory registered
[4294672.887000] io scheduler deadline registered
[4294672.887000] io scheduler cfq registered
[4294672.888000] loop: loaded (max 8 devices)
[4294672.888000] pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
[4294672.888000] Intel(R) PRO/1000 Network Driver - version 5.7.6-k2-NAPI
[4294672.888000] Copyright (c) 1999-2004 Intel Corporation.
[4294672.907000] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
[4294672.907000] PCI: setting IRQ 9 as level-triggered
[4294672.907000] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4294673.182000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[4294674.794000] e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Half Duplex
[4294674.799000] netconsole: network logging started
[4294674.799000] Linux video capture interface: v1.00
[4294674.799000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294674.799000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294674.800000] ICH4: IDE controller at PCI slot 0000:00:1f.1
[4294674.800000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[4294674.819000] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[4294674.819000] PCI: setting IRQ 10 as level-triggered
[4294674.819000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294674.819000] ICH4: chipset revision 1
[4294674.819000] ICH4: not 100% native mode: will probe irqs later
[4294674.819000]     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
[4294674.819000]     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
[4294675.083000] hda: HTS548080M9AT00, ATA DISK drive
[4294675.695000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294676.367000] hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4242N, ATAPI CD/DVD-ROM drive
[4294676.674000] ide1 at 0x170-0x177,0x376 on irq 15
[4294676.674000] hda: max request size: 128KiB
[4294676.691000] hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
[4294676.691000] hda: cache flushes supported
[4294676.691000]  hda: hda1 hda2 hda3
[4294676.710000] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[4294676.710000] Uniform CD-ROM driver Revision: 3.20
[4294676.721000] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4294676.721000] Yenta: CardBus bridge found at 0000:02:00.0 [1014:0552]
[4294676.721000] Yenta: Using INTVAL to route CSC interrupts to PCI
[4294676.721000] Yenta: Routing CardBus interrupts to PCI
[4294676.721000] Yenta TI: socket 0000:02:00.0, mfunc 0x01d21b22, devctl 0x64
[4294676.942000] Yenta: ISA IRQ mask 0x0878, PCI irq 9
[4294676.942000] Socket status: 30000086
[4294677.211000] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[4294677.211000] PCI: setting IRQ 5 as level-triggered
[4294677.211000] ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[4294677.211000] Yenta: CardBus bridge found at 0000:02:00.1 [1014:0552]
[4294677.211000] Yenta: Using INTVAL to route CSC interrupts to PCI
[4294677.211000] Yenta: Routing CardBus interrupts to PCI
[4294677.211000] Yenta TI: socket 0000:02:00.1, mfunc 0x01d21b22, devctl 0x64
[4294677.432000] Yenta: ISA IRQ mask 0x0858, PCI irq 5
[4294677.432000] Socket status: 30000086
[4294677.701000] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
[4294677.701000] PCI: setting IRQ 3 as level-triggered
[4294677.701000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
[4294677.701000] ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
[4294677.701000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[4294677.701000] ehci_hcd 0000:00:1d.7: irq 3, io mem 0xc0000000
[4294677.705000] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[4294677.705000] usb usb1: Product: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
[4294677.706000] usb usb1: Manufacturer: Linux 2.6.12-rc2 ehci_hcd
[4294677.706000] usb usb1: SerialNumber: 0000:00:1d.7
[4294677.706000] hub 1-0:1.0: USB hub found
[4294677.706000] hub 1-0:1.0: 6 ports detected
[4294677.727000] USB Universal Host Controller Interface driver v2.2
[4294677.727000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4294677.727000] uhci_hcd 0000:00:1d.0: Intel
Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
[4294677.789000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[4294677.789000] uhci_hcd 0000:00:1d.0: irq 9, io base 0x00001800
[4294677.789000] uhci_hcd 0000:00:1d.0: detected 2 ports
[4294677.789000] usb usb2: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
[4294677.789000] usb usb2: Manufacturer: Linux 2.6.12-rc2 uhci_hcd
[4294677.789000] usb usb2: SerialNumber: 0000:00:1d.0
[4294677.789000] hub 2-0:1.0: USB hub found
[4294677.789000] hub 2-0:1.0: 2 ports detected
[4294677.810000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[4294677.810000] PCI: setting IRQ 11 as level-triggered
[4294677.810000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[4294677.810000] uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
[4294677.872000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[4294677.872000] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
[4294677.872000] uhci_hcd 0000:00:1d.1: detected 2 ports
[4294677.872000] usb usb3: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
[4294677.872000] usb usb3: Manufacturer: Linux 2.6.12-rc2 uhci_hcd
[4294677.872000] usb usb3: SerialNumber: 0000:00:1d.1
[4294677.872000] hub 3-0:1.0: USB hub found
[4294677.872000] hub 3-0:1.0: 2 ports detected
[4294677.875000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294677.875000] uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
[4294677.937000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[4294677.937000] uhci_hcd 0000:00:1d.2: irq 10, io base 0x00001840
[4294677.937000] uhci_hcd 0000:00:1d.2: detected 2 ports
[4294677.937000] usb usb4: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
[4294677.937000] usb usb4: Manufacturer: Linux 2.6.12-rc2 uhci_hcd
[4294677.937000] usb usb4: SerialNumber: 0000:00:1d.2
[4294677.937000] hub 4-0:1.0: USB hub found
[4294677.937000] hub 4-0:1.0: 2 ports detected
[4294677.940000] usbcore: registered new driver hiddev
[4294677.940000] usbcore: registered new driver usbhid
[4294677.940000] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[4294677.940000] mice: PS/2 mouse device common for all mice
[4294677.940000] input: PC Speaker
[4294677.940000] i2c /dev entries driver
[4294677.941000] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
[4294677.942000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[4294677.951000] input: AT Translated Set 2 keyboard on isa0060/serio0
[4294678.569000] Synaptics Touchpad, model: 1
[4294678.569000]  Firmware: 5.9
[4294678.569000]  Sensor: 44
[4294678.569000]  new absolute packet format
[4294678.569000]  Touchpad has extended capability bits
[4294678.569000]  -> multifinger detection
[4294678.569000]  -> palm detection
[4294678.569000]  -> pass-through port
[4294678.569000] serio: Synaptics pass-through port at isa0060/serio1/input0
[4294678.569000] input: SynPS/2 Synaptics TouchPad on isa0060/serio1
[4294678.752000] intel8x0_measure_ac97_clock: measured 49287 usecs
[4294678.752000] intel8x0: clocking to 48000
[4294678.753000] ALSA device list:
[4294678.753000]   #0: Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 5
[4294678.753000] NET: Registered protocol family 2
[4294678.763000] IP: routing cache hash table of 2048 buckets, 64Kbytes
[4294678.763000] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[4294678.766000] TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
[4294678.771000] TCP: Hash tables configured (established 262144 bind 65536)
[4294678.771000] NET: Registered protocol family 1
[4294678.771000] NET: Registered protocol family 17
[4294678.947000] swsusp: Suspend partition has wrong signature?
[4294678.975000] ACPI wakeup devices:
[4294678.975000]  LID SLPB PCI0 UART PCI1 USB0 USB1 AC9M
[4294678.975000] ACPI: (supports S0 S3 S4 S5)
[4294678.976000] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[4294679.005000] EXT3-fs: mounted filesystem with ordered data mode.
[4294679.005000] VFS: Mounted root (ext3 filesystem) readonly.
[4294679.005000] Freeing unused kernel memory: 236k freed
[4294679.005000] kjournald starting.  Commit interval 5 seconds
[4294682.737000] input: PS/2 Generic Mouse on synaptics-pt/serio0
[4294684.613000] Adding 1050832k swap on /dev/hda3. Priority:-1 extents:1
[4294684.796000] EXT3 FS on hda1, internal journal
[4294689.611000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.3
[4294689.611000] ipw2200: Copyright(c) 2003-2004 Intel Corporation
[4294689.612000] ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294689.612000] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[4294692.342000] Unable to handle kernel paging request at virtual address ffffffab
[4294692.342000]  printing eip:
[4294692.342000] ffffffab
[4294692.342000] *pde = 00002067
[4294692.342000] Oops: 0000 [#1]
[4294692.342000] PREEMPT
[4294692.342000] Modules linked in: ipw2200 ieee80211 ieee80211_crypt
[4294692.342000] CPU:    0
[4294692.342000] EIP:    0060:[<ffffffab>]    Not tainted VLI
[4294692.342000] EFLAGS: 00010286   (2.6.12-rc2)
[4294692.342000] EIP is at 0xffffffab
[4294692.342000] eax: f742ec24   ebx: c0609000   ecx: f7712280   edx: f7712000
[4294692.342000] esi: f7712280   edi: f746404c   ebp: c0609eec   esp: c0609e40
[4294692.342000] ds: 007b   es: 007b   ss: 0068
[4294692.342000] Process swapper (pid: 0, threadinfo=c0609000 task=c0520c80)
[4294692.342000] Stack: f8861d22 c18dd180 f74efa40 c18dd180 f771b000 c0609e88 c0609e8c c0166f12
[4294692.342000]        c040c81b f7712000 f7e1ca8c f7712280 f742ec24 00000001 00000912 00000001
[4294692.342000]        00000024 00000286 f7712284 00000000 00000108 f7e216b4 00000000 f7464010
[4294692.342000] Call Trace:
[4294692.342000]  [<c0104d76>] show_stack+0xa6/0xe0
[4294692.342000]  [<c0104f2b>] show_registers+0x15b/0x1f0
[4294692.342000]  [<c01051a1>] die+0x141/0x2d0
[4294692.342000]  [<c011e13e>] do_page_fault+0x22e/0x6a6
[4294692.342000]  [<c0104817>] error_code+0x4f/0x54
[4294692.342000]  [<c04236da>] qdisc_restart+0xba/0x730
[4294692.342000]  [<c04136fe>] dev_queue_xmit+0x13e/0x640
[4294692.342000]  [<c0454c4c>] arp_solicit+0xfc/0x210
[4294692.342000]  [<c041a6ee>] neigh_timer_handler+0x13e/0x320
[4294692.342000]  [<c0137450>] run_timer_softirq+0x130/0x490
[4294692.342000]  [<c0131ad2>] __do_softirq+0x42/0xa0
[4294692.342000]  [<c01066e1>] do_softirq+0x51/0x60
[4294692.342000]  =======================
[4294692.342000]  [<c0131bf6>] irq_exit+0x36/0x40
[4294692.342000]  [<c01065ad>] do_IRQ+0x5d/0xa0
[4294692.342000]  [<c010472a>] common_interrupt+0x1a/0x20
[4294692.342000]  [<c01010e7>] cpu_idle+0x37/0x50
[4294692.342000]  [<c05c98ba>] start_kernel+0x16a/0x180
[4294692.342000]  [<c010019f>] 0xc010019f
[4294692.342000] Code:  Bad EIP value.
[4294692.342000]  <0>Kernel panic - not syncing: Fatal exception in interrupt
[4294692.343000]
