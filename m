Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVI0ICz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVI0ICz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVI0ICz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:02:55 -0400
Received: from webmailv3.ispgateway.de ([62.67.200.115]:53643 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S932351AbVI0ICy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:02:54 -0400
Message-ID: <1127808162.4338fca2b5a2c@www.domainfactory-webmail.de>
Date: Tue, 27 Sep 2005 10:02:42 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB on nForce4 board only working with pci=routeirq
References: <4R0rb-4nk-13@gated-at.bofh.it> <43388901.8090500@shaw.ca>
In-Reply-To: <43388901.8090500@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.143.195.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitat von Robert Hancock <hancockr@shaw.ca>:

> Florian Engelhardt wrote:
> > Hello,
> >
> > i own a nForce4 mainboard from elitegroup. It has USB 1.1 and 2.0.
> > If i start the computer normal with my 2.6.13 kernel i get the following:
> > Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: OHCI Host Controller
> > Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: USB HC takeover failed!
> > (BIOS/SMM bug)
> > Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: can't reset
> > Sep 25 10:12:54 discovery ACPI: PCI interrupt for device 0000:00:02.0
> disabled
> > Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: init 0000:00:02.0 fail,
> -16
> > Sep 25 10:12:54 discovery ohci_hcd: probe of 0000:00:02.0 failed with error
> -16
> >
> > And non of my USB-devices is wokring anymore.
> > I than switched to 2.6.14-rc2-mm1, but the same behavior.
> > I tried to parse pci=routeirq to the kernel, and than it was wokring again.
> >
> > It worked perfect, also without pci=routeirq until 25th of september.
> > I updated the bios, but that was one month ago, and is was using my usb
> > devices since then with no problems, so i don´t know, what couses this
> > problem now.
>
> We probably need full dmesg output. Also, are you currently using the
> latest BIOS available?

Yes, i am using the latest bios available.

dmesg output comes here:

Sep 25 10:12:54 discovery syslog-ng[5227]: syslog-ng version 1.6.8 starting
Sep 25 10:12:54 discovery syslog-ng[5227]: Changing permissions on special file
/dev/tty12
Sep 25 10:12:54 discovery d/Buffer/Package
initialization:...............................................................................................
Sep 25 10:12:54 discovery Initialized 38/38 Regions 9/9 Fields 34/34 Buffers
14/23 Packages (1002 nodes)
Sep 25 10:12:54 discovery Executing all Device _STA and_INI
methods:...............................................................................................
Sep 25 10:12:54 discovery 95 Devices found containing: 95 _STA, 2 _INI methods
Sep 25 10:12:54 discovery ACPI: Interpreter enabled
Sep 25 10:12:54 discovery ACPI: Using IOAPIC for interrupt routing
Sep 25 10:12:54 discovery ACPI: PCI Root Bridge [PCI0] (0000:00)
Sep 25 10:12:54 discovery PCI: Probing PCI hardware (bus 00)
Sep 25 10:12:54 discovery ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Sep 25 10:12:54 discovery PCI: Transparent bridge - 0000:00:09.0
Sep 25 10:12:54 discovery Boot video device is 0000:05:00.0
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.HUB0._PRT]
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 *10 11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 7 9 10 11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 *10 11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 *11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 *10 11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 7 9 10 11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 *11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 7 9 10 11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 *10 11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 10 *11
12 14 15)
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0,
disabled.
Sep 25 10:12:54 discovery Linux Plug and Play Support v0.97 (c) Adam Belay
Sep 25 10:12:54 discovery pnp: PnP ACPI init
Sep 25 10:12:54 discovery pnp: PnP ACPI: found 12 devices
Sep 25 10:12:54 discovery SCSI subsystem initialized
Sep 25 10:12:54 discovery usbcore: registered new driver usbfs
Sep 25 10:12:54 discovery usbcore: registered new driver hub
Sep 25 10:12:54 discovery PCI: Using ACPI for IRQ routing
Sep 25 10:12:54 discovery PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
Sep 25 10:12:54 discovery PCI: Bridge: 0000:00:09.0
Sep 25 10:12:54 discovery IO window: 9000-afff
Sep 25 10:12:54 discovery MEM window: fdf00000-fdffffff
Sep 25 10:12:54 discovery PREFETCH window: fde00000-fdefffff
Sep 25 10:12:54 discovery PCI: Bridge: 0000:00:0b.0
Sep 25 10:12:54 discovery IO window: 8000-8fff
Sep 25 10:12:54 discovery MEM window: fdd00000-fddfffff
Sep 25 10:12:54 discovery PREFETCH window: fdc00000-fdcfffff
Sep 25 10:12:54 discovery PCI: Bridge: 0000:00:0c.0
Sep 25 10:12:54 discovery IO window: 7000-7fff
Sep 25 10:12:54 discovery MEM window: fdb00000-fdbfffff
Sep 25 10:12:54 discovery PREFETCH window: fda00000-fdafffff
Sep 25 10:12:54 discovery PCI: Bridge: 0000:00:0d.0
Sep 25 10:12:54 discovery IO window: 6000-6fff
Sep 25 10:12:54 discovery MEM window: fd900000-fd9fffff
Sep 25 10:12:54 discovery PREFETCH window: fd800000-fd8fffff
Sep 25 10:12:54 discovery PCI: Bridge: 0000:00:0e.0
Sep 25 10:12:54 discovery IO window: 5000-5fff
Sep 25 10:12:54 discovery MEM window: f4000000-fbffffff
Sep 25 10:12:54 discovery PREFETCH window: d8000000-dfffffff
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:09.0 to
64
Sep 25 10:12:54 discovery acpi_bus-0212 [01] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0b.0 to
64
Sep 25 10:12:54 discovery acpi_bus-0212 [01] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0c.0 to
64
Sep 25 10:12:54 discovery acpi_bus-0212 [01] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0d.0 to
64
Sep 25 10:12:54 discovery acpi_bus-0212 [01] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0e.0 to
64
Sep 25 10:12:54 discovery PCI-DMA: Disabling IOMMU.
Sep 25 10:12:54 discovery pnp: 00:00: ioport range 0x1000-0x107f could not be
reserved
Sep 25 10:12:54 discovery pnp: 00:00: ioport range 0x1080-0x10ff has been
reserved
Sep 25 10:12:54 discovery pnp: 00:00: ioport range 0x1400-0x147f has been
reserved
Sep 25 10:12:54 discovery pnp: 00:00: ioport range 0x1480-0x14ff could not be
reserved
Sep 25 10:12:54 discovery pnp: 00:00: ioport range 0x1800-0x187f has been
reserved
Sep 25 10:12:54 discovery pnp: 00:00: ioport range 0x1880-0x18ff has been
reserved
Sep 25 10:12:54 discovery IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24
13:02:28 ak Exp $
Sep 25 10:12:54 discovery Total HugeTLB memory allocated, 0
Sep 25 10:12:54 discovery Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Sep 25 10:12:54 discovery Initializing Cryptographic API
Sep 25 10:12:54 discovery pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0b.0 to
64
Sep 25 10:12:54 discovery pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ.
Check vendor BIOS
Sep 25 10:12:54 discovery assign_interrupt_mode Found MSI capability
Sep 25 10:12:54 discovery Allocate Port Service[pcie00]
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0c.0 to
64
Sep 25 10:12:54 discovery pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ.
Check vendor BIOS
Sep 25 10:12:54 discovery assign_interrupt_mode Found MSI capability
Sep 25 10:12:54 discovery Allocate Port Service[pcie00]
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0d.0 to
64
Sep 25 10:12:54 discovery pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ.
Check vendor BIOS
Sep 25 10:12:54 discovery assign_interrupt_mode Found MSI capability
Sep 25 10:12:54 discovery Allocate Port Service[pcie00]
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:0e.0 to
64
Sep 25 10:12:54 discovery pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ.
Check vendor BIOS
Sep 25 10:12:54 discovery assign_interrupt_mode Found MSI capability
Sep 25 10:12:54 discovery Allocate Port Service[pcie00]
Sep 25 10:12:54 discovery ACPI: Power Button (FF) [PWRF]
Sep 25 10:12:54 discovery ACPI: Power Button (CM) [PWRB]
Sep 25 10:12:54 discovery ACPI: Fan [FAN] (on)
Sep 25 10:12:54 discovery ACPI: CPU0 (power states: C1[C1])
Sep 25 10:12:54 discovery acpi_processor-0521 [07] acpi_processor_get_inf: Error
getting cpuindex for acpiid 0x1
Sep 25 10:12:54 discovery ACPI: Thermal Zone [THRM] (40 C)
Sep 25 10:12:54 discovery toshiba_acpi: Using generic hotkey driver
Sep 25 10:12:54 discovery Real Time Clock Driver v1.12
Sep 25 10:12:54 discovery Linux agpgart interface v0.101 (c) Dave Jones
Sep 25 10:12:54 discovery Hangcheck: starting hangcheck timer 0.9.0 (tick is 180
seconds, margin is 60 seconds).
Sep 25 10:12:54 discovery Hangcheck: Using monotonic_clock().
Sep 25 10:12:54 discovery PNP: PS/2 controller doesn't have AUX irq; using
default 0xc
Sep 25 10:12:54 discovery PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq
112
Sep 25 10:12:54 discovery serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 25 10:12:54 discovery serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 25 10:12:54 discovery Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing disabled
Sep 25 10:12:54 discovery ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 25 10:12:54 discovery ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep 25 10:12:54 discovery ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 25 10:12:54 discovery io scheduler noop registered
Sep 25 10:12:54 discovery io scheduler anticipatory registered
Sep 25 10:12:54 discovery io scheduler deadline registered
Sep 25 10:12:54 discovery io scheduler cfq registered
Sep 25 10:12:54 discovery 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
Sep 25 10:12:54 discovery 8139cp: pci dev 0000:01:09.0 (id 10ec:8139 rev 10) is
not an 8139C+ compatible chip
Sep 25 10:12:54 discovery 8139cp: Try the "8139too" driver instead.
Sep 25 10:12:54 discovery 8139too Fast Ethernet driver 0.9.27
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC4] ->
GSI 19 (level, low) -> IRQ 217
Sep 25 10:12:54 discovery eth0: RealTek RTL8139 at 0xac00, 00:11:5b:b2:d0:bc,
IRQ 217
Sep 25 10:12:54 discovery eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Sep 25 10:12:54 discovery Linux video capture interface: v1.00
Sep 25 10:12:54 discovery bttv: driver version 0.9.16 loaded
Sep 25 10:12:54 discovery bttv: using 8 buffers with 2080k (520 pages) each for
capture
Sep 25 10:12:54 discovery bttv: Bt8xx card found (0).
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] ->
GSI 18 (level, low) -> IRQ 225
Sep 25 10:12:54 discovery bttv0: Bt878 (rev 2) at 0000:01:08.0, irq: 225,
latency: 32, mmio: 0xfdeff000
Sep 25 10:12:54 discovery bttv0: detected: Hauppauge WinTV [card=10], PCI
subsystem ID is 0070:13eb
Sep 25 10:12:54 discovery bttv0: using: Hauppauge (bt878) [card=10,autodetected]
Sep 25 10:12:54 discovery bttv0: gpio: en=00000000, out=00000000 in=00fffffb
[init]
Sep 25 10:12:54 discovery bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
Sep 25 10:12:54 discovery tveeprom: Hauppauge: model = 38104, rev = B208,
serial# = 1331191
Sep 25 10:12:54 discovery tveeprom: tuner = Philips FI1216 MK2 (idx = 8, type =
5)
Sep 25 10:12:54 discovery tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 =
0x00000007)
Sep 25 10:12:54 discovery tveeprom: audio_processor = None (type = 0)
Sep 25 10:12:54 discovery bttv0: using tuner=5
Sep 25 10:12:54 discovery bttv0: registered device video0
Sep 25 10:12:54 discovery bttv0: registered device vbi0
Sep 25 10:12:54 discovery bttv0: PLL: 28636363 => 35468950 .. ok
Sep 25 10:12:54 discovery tvaudio: TV audio decoder + audio/video mux driver
Sep 25 10:12:54 discovery tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54
(PV951),ta8874z
Sep 25 10:12:54 discovery : chip found @ 0xc2 (bt878 #0 [sw])
Sep 25 10:12:54 discovery tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216
and compatibles))
Sep 25 10:12:54 discovery Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
Sep 25 10:12:54 discovery ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
Sep 25 10:12:54 discovery NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
Sep 25 10:12:54 discovery acpi_bus-0212 [02] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery NFORCE-CK804: chipset revision 162
Sep 25 10:12:54 discovery NFORCE-CK804: not 100% native mode: will probe irqs
later
Sep 25 10:12:54 discovery NFORCE-CK804: BIOS didn't set cable bits correctly.
Enabling workaround.
Sep 25 10:12:54 discovery NFORCE-CK804: BIOS didn't set cable bits correctly.
Enabling workaround.
Sep 25 10:12:54 discovery NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
Sep 25 10:12:54 discovery ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA,
hdb:DMA
Sep 25 10:12:54 discovery ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA,
hdd:DMA
Sep 25 10:12:54 discovery Probing IDE interface ide0...
Sep 25 10:12:54 discovery hda: PIONEER DVD-RW DVR-109, ATAPI CD/DVD-ROM drive
Sep 25 10:12:54 discovery ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 25 10:12:54 discovery Probing IDE interface ide1...
Sep 25 10:12:54 discovery hdc: PLEXTOR DVD-ROM PX-130A, ATAPI CD/DVD-ROM drive
Sep 25 10:12:54 discovery ide1 at 0x170-0x177,0x376 on irq 15
Sep 25 10:12:54 discovery hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB
Cache, UDMA(66)
Sep 25 10:12:54 discovery Uniform CD-ROM driver Revision: 3.20
Sep 25 10:12:54 discovery hdc: ATAPI 50X DVD-ROM drive, 512kB Cache
Sep 25 10:12:54 discovery libata version 1.11 loaded.
Sep 25 10:12:54 discovery sata_nv version 0.6
Sep 25 10:12:54 discovery acpi_bus-0212 [02] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] ->
GSI 23 (level, low) -> IRQ 233
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:07.0 to
64
Sep 25 10:12:54 discovery ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma
0xCC00 irq 233
Sep 25 10:12:54 discovery ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma
0xCC08 irq 233
Sep 25 10:12:54 discovery ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023
85:7468 86:3c01 87:4023 88:40ff
Sep 25 10:12:54 discovery ata1: dev 0 ATA, max UDMA7, 390721968 sectors: lba48
Sep 25 10:12:54 discovery nv_sata: Primary device added
Sep 25 10:12:54 discovery nv_sata: Primary device removed
Sep 25 10:12:54 discovery nv_sata: Secondary device added
Sep 25 10:12:54 discovery nv_sata: Secondary device removed
Sep 25 10:12:54 discovery ata1: dev 0 configured for UDMA/133
Sep 25 10:12:54 discovery scsi0 : sata_nv
Sep 25 10:12:54 discovery ata2: no device found (phy stat 00000000)
Sep 25 10:12:54 discovery scsi1 : sata_nv
Sep 25 10:12:54 discovery Vendor: ATA       Model: SAMSUNG SP2004C   Rev: VM10
Sep 25 10:12:54 discovery Type:   Direct-Access                      ANSI SCSI
revision: 05
Sep 25 10:12:54 discovery acpi_bus-0212 [02] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] ->
GSI 22 (level, low) -> IRQ 50
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:08.0 to
64
Sep 25 10:12:54 discovery ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma
0xB800 irq 50
Sep 25 10:12:54 discovery ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma
0xB808 irq 50
Sep 25 10:12:54 discovery ata3: no device found (phy stat 00000000)
Sep 25 10:12:54 discovery scsi2 : sata_nv
Sep 25 10:12:54 discovery ata4: no device found (phy stat 00000000)
Sep 25 10:12:54 discovery scsi3 : sata_nv
Sep 25 10:12:54 discovery SCSI device sda: 390721968 512-byte hdwr sectors
(200050 MB)
Sep 25 10:12:54 discovery SCSI device sda: drive cache: write back
Sep 25 10:12:54 discovery SCSI device sda: 390721968 512-byte hdwr sectors
(200050 MB)
Sep 25 10:12:54 discovery SCSI device sda: drive cache: write back
Sep 25 10:12:54 discovery sda: sda1 sda2 sda3 sda4
Sep 25 10:12:54 discovery Attached scsi disk sda at scsi0, channel 0, id 0, lun
0
Sep 25 10:12:54 discovery Attached scsi generic sg0 at scsi0, channel 0, id 0,
lun 0,  type 0
Sep 25 10:12:54 discovery acpi_bus-0212 [02] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] ->
GSI 21 (level, low) -> IRQ 58
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:02.1 to
64
Sep 25 10:12:54 discovery ehci_hcd 0000:00:02.1: EHCI Host Controller
Sep 25 10:12:54 discovery ehci_hcd 0000:00:02.1: debug port 1
Sep 25 10:12:54 discovery ehci_hcd 0000:00:02.1: new USB bus registered,
assigned bus number 1
Sep 25 10:12:54 discovery ehci_hcd 0000:00:02.1: irq 58, io mem 0xfe02e000
Sep 25 10:12:54 discovery PCI: cache line size of 64 is not supported by device
0000:00:02.1
Sep 25 10:12:54 discovery ehci_hcd 0000:00:02.1: park 0
Sep 25 10:12:54 discovery ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00,
driver 10 Dec 2004
Sep 25 10:12:54 discovery hub 1-0:1.0: USB hub found
Sep 25 10:12:54 discovery hub 1-0:1.0: 10 ports detected
Sep 25 10:12:54 discovery ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller
(OHCI) Driver (PCI)
Sep 25 10:12:54 discovery acpi_bus-0212 [02] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] ->
GSI 20 (level, low) -> IRQ 66
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:02.0 to
64
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: OHCI Host Controller
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: USB HC takeover failed! 
(BIOS/SMM bug)
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: can't reset
Sep 25 10:12:54 discovery ACPI: PCI interrupt for device 0000:00:02.0 disabled
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: init 0000:00:02.0 fail, -16
Sep 25 10:12:54 discovery ohci_hcd: probe of 0000:00:02.0 failed with error -16
Sep 25 10:12:54 discovery USB Universal Host Controller Interface driver v2.3
Sep 25 10:12:54 discovery usbcore: registered new driver audio
Sep 25 10:12:54 discovery drivers/usb/class/audio.c: v1.0.0:USB Audio Class
driver
Sep 25 10:12:54 discovery usbcore: registered new driver usblp
Sep 25 10:12:54 discovery drivers/usb/class/usblp.c: v0.13: USB Printer Device
Class driver
Sep 25 10:12:54 discovery Initializing USB Mass Storage driver...
Sep 25 10:12:54 discovery usbcore: registered new driver usb-storage
Sep 25 10:12:54 discovery USB Mass Storage support registered.
Sep 25 10:12:54 discovery usbcore: registered new driver usbhid
Sep 25 10:12:54 discovery drivers/usb/input/hid-core.c: v2.01:USB HID core
driver
Sep 25 10:12:54 discovery mice: PS/2 mouse device common for all mice
Sep 25 10:12:54 discovery i2c /dev entries driver
Sep 25 10:12:54 discovery i2c_adapter i2c-2: nForce2 SMBus adapter at 0xf800
Sep 25 10:12:54 discovery i2c_adapter i2c-3: nForce2 SMBus adapter at 0xf400
Sep 25 10:12:54 discovery it87: Found IT8712F chip at 0x290, revision 7
Sep 25 10:12:54 discovery it87 1-0290: Detected broken BIOS defaults, disabling
PWM interface
Sep 25 10:12:54 discovery Advanced Linux Sound Architecture Driver Version
1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
Sep 25 10:12:54 discovery acpi_bus-0212 [02] acpi_bus_set_power    : Device is
not power manageable
Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] ->
GSI 23 (level, low) -> IRQ 233
Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:04.0 to
64
Sep 25 10:12:54 discovery input: AT Translated Set 2 keyboard on isa0060/serio0
Sep 25 10:12:54 discovery intel8x0_measure_ac97_clock: measured 54875 usecs
Sep 25 10:12:54 discovery intel8x0: clocking to 46896
Sep 25 10:12:54 discovery usbcore: registered new driver snd-usb-audio
Sep 25 10:12:54 discovery ALSA device list:
Sep 25 10:12:54 discovery #0: NVidia CK804 with ALC655 at 0xfe02d000, irq 233
Sep 25 10:12:54 discovery NET: Registered protocol family 2
Sep 25 10:12:54 discovery IP route cache hash table entries: 32768 (order: 6,
262144 bytes)
Sep 25 10:12:54 discovery TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
Sep 25 10:12:54 discovery TCP bind hash table entries: 65536 (order: 7, 524288
bytes)
Sep 25 10:12:54 discovery TCP: Hash tables configured (established 131072 bind
65536)
Sep 25 10:12:54 discovery TCP reno registered
Sep 25 10:12:54 discovery TCP bic registered
Sep 25 10:12:54 discovery NET: Registered protocol family 1
Sep 25 10:12:54 discovery NET: Registered protocol family 10
Sep 25 10:12:54 discovery IPv6 over IPv4 tunneling driver
Sep 25 10:12:54 discovery NET: Registered protocol family 17
Sep 25 10:12:54 discovery powernow-k8: Found 1 AMD Athlon 64 / Opteron
processors (version 1.50.3)
Sep 25 10:12:54 discovery powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6 (1400
mV)
Sep 25 10:12:54 discovery powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8 (1350
mV)
Sep 25 10:12:54 discovery powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300
mV)
Sep 25 10:12:54 discovery powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100
mV)
Sep 25 10:12:54 discovery cpu_init done, current fid 0xe, vid 0x6
Sep 25 10:12:54 discovery ACPI wakeup devices:
Sep 25 10:12:54 discovery HUB0 XVR0 XVR1 XVR2 XVR3 USB0 USB2 MMAC MMCI UAR1
Sep 25 10:12:54 discovery ACPI: (supports S0 S3 S4 S5)
Sep 25 10:12:54 discovery VFS: Mounted root (reiser4 filesystem) readonly.
Sep 25 10:12:54 discovery Freeing unused kernel memory: 168k freed
Sep 25 10:12:54 discovery Adding 498004k swap on /dev/sda2.  Priority:-1
extents:1


But: I restarted the computer this morning without pci=routeirq and
my usb is working, it seems to me, that something is fishy with the bios
or the mainboard itself.

Kind Regards

Florian Engelhardt

