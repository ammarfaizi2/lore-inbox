Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271633AbVBFJLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271633AbVBFJLO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 04:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271628AbVBFJLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 04:11:14 -0500
Received: from smtpout2.uol.com.br ([200.221.4.193]:61666 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S272358AbVBFJHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 04:07:49 -0500
Date: Sun, 6 Feb 2005 07:07:47 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050206090747.GA3822@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050206023610.GA2250@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050206023610.GA2250@node1.opengeometry.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Feb 05 2005, William Park wrote:
> On Sat, Feb 05, 2005 at 08:45:58PM -0200, Rogério Brito wrote:
> > The message seems to be related to the Promise PDC20265 driver and it
> > appeared right after I moved my HDs from my motherboard's VIA controllers
> > to the Promise controllers. I have an Asus A7V board, with 2 VIA 686a
> > controllers and 2 Promise PDC20265 controllers.
> > 
> > I already tried enabling and disabling ACPI, but it seems that the problem
> > just doesn't go away. :-(
> 
> Try 'acpi=noirq'.  It did it for me (Abit VP6 dual-p3, Via VT82C694X,
> Via VT82C686B).

I tried to boot with acpi=noirq, but it didn't work for me. Here is the
relevant part of the dmesg output (and the whole dmesg is attached to this
message):

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(...)
Kernel command line: BOOT_IMAGE=Linux root=2103 acpi=noirq
(...)
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: 0000:00:11.0 has unsupported PM cap regs version (1)
PCI: Found IRQ 10 for device 0000:00:11.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
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
 [<c012c1e9>] __report_bad_irq+0x31/0x77
 [<c012c2bc>] note_interrupt+0x75/0x99
 [<c012bd80>] __do_IRQ+0x95/0xc1
 [<c010469d>] do_IRQ+0x19/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c011a03c>] __do_softirq+0x2c/0x7d
 [<c011a0af>] do_softirq+0x22/0x26
 [<c01046a2>] do_IRQ+0x1e/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012be85>] enable_irq+0x88/0x8d
 [<c020fb94>] probe_hwif+0x2f7/0x383
 [<c020adb4>] ata_attach+0xa3/0xbd
 [<c020fc30>] probe_hwif_init_with_fixup+0x10/0x74
 [<c021234b>] ide_setup_pci_device+0x72/0x7f
 [<c0207c26>] pdc202xx_init_one+0x15/0x18
 [<c03792f5>] ide_scan_pcidev+0x34/0x59
 [<c0379336>] ide_scan_pcibus+0x1c/0x92
 [<c0379266>] probe_for_hwifs+0xb/0xd
 [<c03792ac>] ide_init+0x44/0x59
 [<c03646d9>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c020cec8>] (ide_intr+0x0/0xee)
Disabling IRQ #10
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c012c1e9>] __report_bad_irq+0x31/0x77
 [<c012c2bc>] note_interrupt+0x75/0x99
 [<c012bd80>] __do_IRQ+0x95/0xc1
 [<c010469d>] do_IRQ+0x19/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c011a03c>] __do_softirq+0x2c/0x7d
 [<c011a0af>] do_softirq+0x22/0x26
 [<c01046a2>] do_IRQ+0x1e/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012be85>] enable_irq+0x88/0x8d
 [<c020dbe3>] ide_config_drive_speed+0x168/0x30d
 [<c0207266>] pdc202xx_tune_chipset+0x38c/0x396
 [<c020fbde>] probe_hwif+0x341/0x383
 [<c020adb4>] ata_attach+0xa3/0xbd
 [<c020fc30>] probe_hwif_init_with_fixup+0x10/0x74
 [<c021234b>] ide_setup_pci_device+0x72/0x7f
 [<c0207c26>] pdc202xx_init_one+0x15/0x18
 [<c03792f5>] ide_scan_pcidev+0x34/0x59
 [<c0379336>] ide_scan_pcibus+0x1c/0x92
 [<c0379266>] probe_for_hwifs+0xb/0xd
 [<c03792ac>] ide_init+0x44/0x59
 [<c03646d9>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c020cec8>] (ide_intr+0x0/0xee)
Disabling IRQ #10
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c012c1e9>] __report_bad_irq+0x31/0x77
 [<c012c2bc>] note_interrupt+0x75/0x99
 [<c012bd80>] __do_IRQ+0x95/0xc1
 [<c010469d>] do_IRQ+0x19/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c011a03c>] __do_softirq+0x2c/0x7d
 [<c011a0af>] do_softirq+0x22/0x26
 [<c01046a2>] do_IRQ+0x1e/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012be85>] enable_irq+0x88/0x8d
 [<c020dbe3>] ide_config_drive_speed+0x168/0x30d
 [<c0207266>] pdc202xx_tune_chipset+0x38c/0x396
 [<c020757e>] config_chipset_for_dma+0x216/0x227
 [<c02075c6>] pdc202xx_config_drive_xfer_rate+0x37/0x6c
 [<c020fc05>] probe_hwif+0x368/0x383
 [<c020adb4>] ata_attach+0xa3/0xbd
 [<c020fc30>] probe_hwif_init_with_fixup+0x10/0x74
 [<c021234b>] ide_setup_pci_device+0x72/0x7f
 [<c0207c26>] pdc202xx_init_one+0x15/0x18
 [<c03792f5>] ide_scan_pcidev+0x34/0x59
 [<c0379336>] ide_scan_pcibus+0x1c/0x92
 [<c0379266>] probe_for_hwifs+0xb/0xd
 [<c03792ac>] ide_init+0x44/0x59
 [<c03646d9>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c020cec8>] (ide_intr+0x0/0xee)
Disabling IRQ #10
ide3 at 0x8000-0x8007,0x7802 on irq 10
hde: max request size: 128KiB
hde: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, UDMA(33)
hde: cache flushes not supported
 hde: hde1 hde2 hde3 hde4
hdg: max request size: 128KiB
hdg: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(33)
hdg: cache flushes not supported
 hdg: hdg1
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

So, it seems that I'm always getting this, whether I use acpi=off,
acpi=noirq or the irqpoll options passed to the kernel. Would there be
anything else that I should try?


Thank you very much for the help, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.11-rc3-mm1-1 (root@dumont) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #1 Sat Feb 5 20:48:14 BRST 2005
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
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Linux root=2103 acpi=noirq
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 605.742 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256160k/262064k available (1708k kernel code, 5344k reserved, 730k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1196.03 BogoMIPS (lpj=598016)
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
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:02: ioport range 0xe800-0xe80f has been reserved
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
[drm] Initialized mga 3.1.0 20021029 on minor 0: 
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Found IRQ 5 for device 0000:00:0a.0
ttyS14 at I/O 0xa000 (irq = 5) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
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
PCI: Found IRQ 9 for device 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:0d.0
eth0: RealTek RTL8139 at 0xd0816000, 00:e0:7d:96:28:8f, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
PCI: Found IRQ 9 for device 0000:00:0d.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
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
PCI: Found IRQ 10 for device 0000:00:11.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
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
 [<c012c1e9>] __report_bad_irq+0x31/0x77
 [<c012c2bc>] note_interrupt+0x75/0x99
 [<c012bd80>] __do_IRQ+0x95/0xc1
 [<c010469d>] do_IRQ+0x19/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c011a03c>] __do_softirq+0x2c/0x7d
 [<c011a0af>] do_softirq+0x22/0x26
 [<c01046a2>] do_IRQ+0x1e/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012be85>] enable_irq+0x88/0x8d
 [<c020fb94>] probe_hwif+0x2f7/0x383
 [<c020adb4>] ata_attach+0xa3/0xbd
 [<c020fc30>] probe_hwif_init_with_fixup+0x10/0x74
 [<c021234b>] ide_setup_pci_device+0x72/0x7f
 [<c0207c26>] pdc202xx_init_one+0x15/0x18
 [<c03792f5>] ide_scan_pcidev+0x34/0x59
 [<c0379336>] ide_scan_pcibus+0x1c/0x92
 [<c0379266>] probe_for_hwifs+0xb/0xd
 [<c03792ac>] ide_init+0x44/0x59
 [<c03646d9>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c020cec8>] (ide_intr+0x0/0xee)
Disabling IRQ #10
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c012c1e9>] __report_bad_irq+0x31/0x77
 [<c012c2bc>] note_interrupt+0x75/0x99
 [<c012bd80>] __do_IRQ+0x95/0xc1
 [<c010469d>] do_IRQ+0x19/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c011a03c>] __do_softirq+0x2c/0x7d
 [<c011a0af>] do_softirq+0x22/0x26
 [<c01046a2>] do_IRQ+0x1e/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012be85>] enable_irq+0x88/0x8d
 [<c020dbe3>] ide_config_drive_speed+0x168/0x30d
 [<c0207266>] pdc202xx_tune_chipset+0x38c/0x396
 [<c020fbde>] probe_hwif+0x341/0x383
 [<c020adb4>] ata_attach+0xa3/0xbd
 [<c020fc30>] probe_hwif_init_with_fixup+0x10/0x74
 [<c021234b>] ide_setup_pci_device+0x72/0x7f
 [<c0207c26>] pdc202xx_init_one+0x15/0x18
 [<c03792f5>] ide_scan_pcidev+0x34/0x59
 [<c0379336>] ide_scan_pcibus+0x1c/0x92
 [<c0379266>] probe_for_hwifs+0xb/0xd
 [<c03792ac>] ide_init+0x44/0x59
 [<c03646d9>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c020cec8>] (ide_intr+0x0/0xee)
Disabling IRQ #10
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
irq 10: nobody cared (try booting with the "irqpoll" option.
 [<c012c1e9>] __report_bad_irq+0x31/0x77
 [<c012c2bc>] note_interrupt+0x75/0x99
 [<c012bd80>] __do_IRQ+0x95/0xc1
 [<c010469d>] do_IRQ+0x19/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c011a03c>] __do_softirq+0x2c/0x7d
 [<c011a0af>] do_softirq+0x22/0x26
 [<c01046a2>] do_IRQ+0x1e/0x24
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012be85>] enable_irq+0x88/0x8d
 [<c020dbe3>] ide_config_drive_speed+0x168/0x30d
 [<c0207266>] pdc202xx_tune_chipset+0x38c/0x396
 [<c020757e>] config_chipset_for_dma+0x216/0x227
 [<c02075c6>] pdc202xx_config_drive_xfer_rate+0x37/0x6c
 [<c020fc05>] probe_hwif+0x368/0x383
 [<c020adb4>] ata_attach+0xa3/0xbd
 [<c020fc30>] probe_hwif_init_with_fixup+0x10/0x74
 [<c021234b>] ide_setup_pci_device+0x72/0x7f
 [<c0207c26>] pdc202xx_init_one+0x15/0x18
 [<c03792f5>] ide_scan_pcidev+0x34/0x59
 [<c0379336>] ide_scan_pcibus+0x1c/0x92
 [<c0379266>] probe_for_hwifs+0xb/0xd
 [<c03792ac>] ide_init+0x44/0x59
 [<c03646d9>] do_initcalls+0x4b/0x99
 [<c0100272>] init+0x0/0xce
 [<c0100299>] init+0x27/0xce
 [<c0101245>] kernel_thread_helper+0x5/0xb
handlers:
[<c020cec8>] (ide_intr+0x0/0xee)
Disabling IRQ #10
ide3 at 0x8000-0x8007,0x7802 on irq 10
hde: max request size: 128KiB
hde: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, UDMA(33)
hde: cache flushes not supported
 hde: hde1 hde2 hde3 hde4
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
PCI: Found IRQ 11 for device 0000:00:0c.0
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
Freeing unused kernel memory: 144k freed
Adding 240964k swap on /dev/hde4.  Priority:-1 extents:1
EXT3 FS on hde3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 9 for device 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: irq 9, io base 0xd400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: irq 9, io base 0xd000
usb 1-1: new full speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-2: new full speed USB device using uhci_hcd and address 3
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ieee1394: Initialized config rom entry `ip1394'
usb 1-1.1: new full speed USB device using uhci_hcd and address 3
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:11.0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e1800000-e18007ff]  Max Packet=[2048]
usb 1-1.2: new low speed USB device using uhci_hcd and address 4
usbcore: registered new driver hiddev
input: USB HID v1.00 Keyboard [Silitek  Silitek USB Keyboard] on usb-0000:00:04.2-1.1
input: USB HID v1.00 Mouse [0461:4d03] on usb-0000:00:04.2-1.2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011066645555ead]
eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth1: link up, 10Mbps, half-duplex, lpa 0x0000

--y0ulUmNC+osPPQO6--
