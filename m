Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVA3FG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVA3FG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 00:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVA3FG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 00:06:57 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:65456 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261647AbVA3FGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 00:06:25 -0500
Date: Sun, 30 Jan 2005 03:06:22 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: irq 10: nobody cared! (bug with IDE, Promise PDC20265 controller)
Message-ID: <20050130050622.GA3074@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear developers,

I bought myself a DVD recorder yesterday and today I tried to install it in
my system. I have an Asus A7V motherboard with a VIA KT133 chipset with 2
VIA IDE controllers and 2 Promise PDC20265 controllers.

Since I already had a CD recorder, I decided to keep it and I tried to
configure the things as:

/dev/hda: the DVD recorder (in ide0, a VIA controller);
/dev/hdc: the CD recorder (in ide1, also a VIA controller);
/dev/hde: a 13GB HD (in ide2, a Promise PDC20265 controller);
/dev/hdg: a 30GB HD (in ide3, also a PDC20265 controller).

Unfortunately, right upon boot with my kernel 2.6.11-rc2, I got a stack
trace saying that "irq 10: nobody cared!" and a whole lot of lines
regarding to the promise controller. My kernel didn't have ACPI enabled
(only APM).

I then tried to compile a 2.6.11-rc2-mm2 kernel with ACPI enabled and that
didn't solve the problem.

Could anybody help, please? I don't know what is the relevant information,
but I am attaching the dmesg of the 2.6.11-rc2-mm2 kernel. BTW, it
suggested that I booted with the irqpoll option, which I did, but the
problem persisted.

If you need more information, please don't hesistate to ask.


Thanks in advance for any help, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.11-rc2-mm2-1 (root@dumont) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #1 Sun Jan 30 01:40:01 BRST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61420 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a90
ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec000
ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec080
ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec040
ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=linux root=2103 irqpoll
Misrouted IRQ fixup and polling support enabled.
This may significantly impact system performance.
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 605.414 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255708k/262064k available (2137k kernel code, 5796k reserved, 721k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1183.74 BogoMIPS (lpj=591872)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e20)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 16 throttling states)
inotify device minor=63
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 16M @ 0xe7000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized mga 3.1.0 20021029 on minor 0: 
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 5 (level, low) -> IRQ 5
ttyS14 at I/O 0xa000 (irq = 5) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
lp0: using parport0 (interrupt-driven).
parport_pc: VIA parallel port: io=0x378, irq=7
io scheduler noop registered
io scheduler anticipatory registered
ACPI: Floppy Controller [FDC0] at I/O 0x3f2-0x3f5, 0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 9 (level, low) -> IRQ 9
eth0: RealTek RTL8139 at 0xd0816000, 00:e0:7d:96:28:8f, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 9 (level, low) -> IRQ 9
eth1: RealTek RTL8139 at 0xd0818000, 00:e0:7d:95:c9:9c, IRQ 9
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: 0000:00:11.0 has unsupported PM cap regs version (1)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: QUANTUM FIREBALL CX13.0A, ATA DISK drive
ide2 at 0x8800-0x8807,0x8402 on irq 10
Probing IDE interface ide3...
hdg: QUANTUM FIREBALLlct15 30, ATA DISK drive
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c013704a>] __report_bad_irq+0x2a/0xa0
 [<c0137160>] note_interrupt+0x80/0xf0
 [<c0136ad4>] __do_IRQ+0xe4/0xf0
 [<c0105249>] do_IRQ+0x19/0x30
 [<c01038a2>] common_interrupt+0x1a/0x20
 [<c011f5fe>] __do_softirq+0x2e/0x90
 [<c011f686>] do_softirq+0x26/0x30
 [<c010524e>] do_IRQ+0x1e/0x30
 [<c01038a2>] common_interrupt+0x1a/0x20
 [<c0136b95>] enable_irq+0x35/0xd0
 [<c024e243>] probe_hwif+0x273/0x490
 [<c024880c>] idedefault_attach+0x1c/0x50
 [<c0247b1a>] ata_attach+0x7a/0xd0
 [<c024e475>] probe_hwif_init_with_fixup+0x15/0x80
 [<c0251982>] ide_setup_pci_device+0x92/0xb0
 [<c02439a8>] pdc202xx_init_one+0x28/0x30
 [<c03e8a5d>] ide_scan_pcidev+0x5d/0x70
 [<c03e8ab7>] ide_scan_pcibus+0x47/0xe0
 [<c03e8980>] probe_for_hwifs+0x10/0x20
 [<c03e89e0>] ide_init+0x50/0x70
 [<c03ce85c>] do_initcalls+0x2c/0xc0
 [<c01002a0>] init+0x0/0x110
 [<c01002a0>] init+0x0/0x110
 [<c01002ca>] init+0x2a/0x110
 [<c01012f8>] kernel_thread_helper+0x0/0x18
 [<c01012fd>] kernel_thread_helper+0x5/0x18
handlers:
[<c024a980>] (ide_intr+0x0/0x140)
Disabling IRQ #10
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c013704a>] __report_bad_irq+0x2a/0xa0
 [<c0137160>] note_interrupt+0x80/0xf0
 [<c0136ad4>] __do_IRQ+0xe4/0xf0
 [<c0105249>] do_IRQ+0x19/0x30
 [<c01038a2>] common_interrupt+0x1a/0x20
 [<c011f5fe>] __do_softirq+0x2e/0x90
 [<c011f686>] do_softirq+0x26/0x30
 [<c010524e>] do_IRQ+0x1e/0x30
 [<c01038a2>] common_interrupt+0x1a/0x20
 [<c0136b95>] enable_irq+0x35/0xd0
 [<c024b00f>] SELECT_DRIVE+0x2f/0x50
 [<c024baaf>] ide_config_drive_speed+0x14f/0x3b0
 [<c0242ab4>] pdc202xx_tune_chipset+0x314/0x470
 [<c024e228>] probe_hwif+0x258/0x490
 [<c024880c>] idedefault_attach+0x1c/0x50
 [<c0247b1a>] ata_attach+0x7a/0xd0
 [<c024e475>] probe_hwif_init_with_fixup+0x15/0x80
 [<c0251982>] ide_setup_pci_device+0x92/0xb0
 [<c02439a8>] pdc202xx_init_one+0x28/0x30
 [<c03e8a5d>] ide_scan_pcidev+0x5d/0x70
 [<c03e8ab7>] ide_scan_pcibus+0x47/0xe0
 [<c03e8980>] probe_for_hwifs+0x10/0x20
 [<c03e89e0>] ide_init+0x50/0x70
 [<c03ce85c>] do_initcalls+0x2c/0xc0
 [<c01002a0>] init+0x0/0x110
 [<c01002a0>] init+0x0/0x110
 [<c01002ca>] init+0x2a/0x110
 [<c01012f8>] kernel_thread_helper+0x0/0x18
 [<c01012fd>] kernel_thread_helper+0x5/0x18
handlers:
[<c024a980>] (ide_intr+0x0/0x140)
Disabling IRQ #10
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c013704a>] __report_bad_irq+0x2a/0xa0
 [<c0137160>] note_interrupt+0x80/0xf0
 [<c0136ad4>] __do_IRQ+0xe4/0xf0
 [<c0105249>] do_IRQ+0x19/0x30
 [<c01038a2>] common_interrupt+0x1a/0x20
 [<c011f5fe>] __do_softirq+0x2e/0x90
 [<c011f686>] do_softirq+0x26/0x30
 [<c010524e>] do_IRQ+0x1e/0x30
 [<c01038a2>] common_interrupt+0x1a/0x20
 [<c0136b95>] enable_irq+0x35/0xd0
 [<c024baaf>] ide_config_drive_speed+0x14f/0x3b0
 [<c0242ab4>] pdc202xx_tune_chipset+0x314/0x470
 [<c0242f05>] config_chipset_for_dma+0x165/0x2c0
 [<c02430f4>] pdc202xx_config_drive_xfer_rate+0x94/0xb0
 [<c0243060>] pdc202xx_config_drive_xfer_rate+0x0/0xb0
 [<c024e218>] probe_hwif+0x248/0x490
 [<c024880c>] idedefault_attach+0x1c/0x50
 [<c0247b1a>] ata_attach+0x7a/0xd0
 [<c024e475>] probe_hwif_init_with_fixup+0x15/0x80
 [<c0251982>] ide_setup_pci_device+0x92/0xb0
 [<c02439a8>] pdc202xx_init_one+0x28/0x30
 [<c03e8a5d>] ide_scan_pcidev+0x5d/0x70
 [<c03e8ab7>] ide_scan_pcibus+0x47/0xe0
 [<c03e8980>] probe_for_hwifs+0x10/0x20
 [<c03e89e0>] ide_init+0x50/0x70
 [<c03ce85c>] do_initcalls+0x2c/0xc0
 [<c01002a0>] init+0x0/0x110
 [<c01002a0>] init+0x0/0x110
 [<c01002ca>] init+0x2a/0x110
 [<c01012f8>] kernel_thread_helper+0x0/0x18
 [<c01012fd>] kernel_thread_helper+0x5/0x18
handlers:
[<c024a980>] (ide_intr+0x0/0x140)
Disabling IRQ #10
ide3 at 0x8000-0x8007,0x7802 on irq 10
Probing IDE interface ide4...
Probing IDE interface ide5...
hde: max request size: 128KiB
hde: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, UDMA(33)
hde: cache flushes not supported
 hde: hde1 hde2 hde3
hdg: max request size: 128KiB
hdg: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(33)
hdg: cache flushes not supported
 hdg: hdg1
hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
i2c /dev entries driver
i2c_adapter i2c-0: enabling sensors
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
PCI: 0000:00:0c.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0x9400, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PWRB PCI0 UAR1 UAR2 USB0 USB1 
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
Adding 248996k swap on /dev/hde2.  Priority:-1 extents:1
EXT3 FS on hde3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
uhci_hcd: Unknown symbol usb_hcd_pci_suspend
uhci_hcd: Unknown symbol usb_hcd_pci_probe
uhci_hcd: Unknown symbol usb_check_bandwidth
uhci_hcd: Unknown symbol usb_disabled
uhci_hcd: Unknown symbol usb_release_bandwidth
uhci_hcd: Unknown symbol usb_register_root_hub
uhci_hcd: Unknown symbol usb_put_dev
uhci_hcd: Unknown symbol usb_get_dev
uhci_hcd: Unknown symbol usb_claim_bandwidth
uhci_hcd: Unknown symbol usb_hcd_pci_resume
uhci_hcd: Unknown symbol usb_hcd_giveback_urb
uhci_hcd: Unknown symbol usb_hcd_pci_remove
uhci_hcd: Unknown symbol usb_alloc_dev
kobject_register failed for usbcore (-17)
 [<c01ba61b>] kobject_register+0x5b/0x60
 [<c0133631>] mod_sysfs_setup+0x51/0xc0
 [<c01347c1>] load_module+0x7a1/0xa70
 [<c0134b2a>] sys_init_module+0x6a/0x1a0
 [<c0102edd>] sysenter_past_esp+0x52/0x75
uhci_hcd: Unknown symbol usb_hcd_pci_suspend
uhci_hcd: Unknown symbol usb_hcd_pci_probe
uhci_hcd: Unknown symbol usb_check_bandwidth
uhci_hcd: Unknown symbol usb_disabled
uhci_hcd: Unknown symbol usb_release_bandwidth
uhci_hcd: Unknown symbol usb_register_root_hub
uhci_hcd: Unknown symbol usb_put_dev
uhci_hcd: Unknown symbol usb_get_dev
uhci_hcd: Unknown symbol usb_claim_bandwidth
uhci_hcd: Unknown symbol usb_hcd_pci_resume
uhci_hcd: Unknown symbol usb_hcd_giveback_urb
uhci_hcd: Unknown symbol usb_hcd_pci_remove
uhci_hcd: Unknown symbol usb_alloc_dev
ieee1394: Initialized config rom entry `ip1394'
ohci1394: Unknown symbol hpsb_iso_wake
ohci1394: Unknown symbol hpsb_packet_received
ohci1394: Unknown symbol dma_prog_region_free
ohci1394: Unknown symbol hpsb_add_host
ohci1394: Unknown symbol dma_region_sync_for_device
ohci1394: Unknown symbol dma_prog_region_init
ohci1394: Unknown symbol dma_prog_region_alloc
ohci1394: Unknown symbol dma_region_offset_to_bus
ohci1394: Unknown symbol hpsb_alloc_host
ohci1394: Unknown symbol hpsb_selfid_complete
ohci1394: Unknown symbol hpsb_remove_host
ohci1394: Unknown symbol hpsb_iso_packet_received
ohci1394: Unknown symbol hpsb_iso_packet_sent
ohci1394: Unknown symbol hpsb_packet_sent
ohci1394: Unknown symbol dma_region_sync_for_cpu
ohci1394: Unknown symbol hpsb_selfid_received
ohci1394: Unknown symbol hpsb_bus_reset
kobject_register failed for usbcore (-17)
 [<c01ba61b>] kobject_register+0x5b/0x60
 [<c0133631>] mod_sysfs_setup+0x51/0xc0
 [<c01347c1>] load_module+0x7a1/0xa70
 [<c0134b2a>] sys_init_module+0x6a/0x1a0
 [<c0102edd>] sysenter_past_esp+0x52/0x75
kobject_register failed for usbcore (-17)
 [<c01ba61b>] kobject_register+0x5b/0x60
 [<c0133631>] mod_sysfs_setup+0x51/0xc0
 [<c01347c1>] load_module+0x7a1/0xa70
 [<c0134b2a>] sys_init_module+0x6a/0x1a0
 [<c0102edd>] sysenter_past_esp+0x52/0x75
uhci_hcd: Unknown symbol usb_hcd_pci_suspend
uhci_hcd: Unknown symbol usb_hcd_pci_probe
uhci_hcd: Unknown symbol usb_check_bandwidth
uhci_hcd: Unknown symbol usb_disabled
uhci_hcd: Unknown symbol usb_release_bandwidth
uhci_hcd: Unknown symbol usb_register_root_hub
uhci_hcd: Unknown symbol usb_put_dev
uhci_hcd: Unknown symbol usb_get_dev
uhci_hcd: Unknown symbol usb_claim_bandwidth
uhci_hcd: Unknown symbol usb_hcd_pci_resume
uhci_hcd: Unknown symbol usb_hcd_giveback_urb
uhci_hcd: Unknown symbol usb_hcd_pci_remove
uhci_hcd: Unknown symbol usb_alloc_dev
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth1: link up, 10Mbps, half-duplex, lpa 0x0000

--J/dobhs11T7y2rNN--
