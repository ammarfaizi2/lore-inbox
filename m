Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUCLUxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUCLUw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:52:28 -0500
Received: from imap.gmx.net ([213.165.64.20]:53971 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262374AbUCLUo6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:44:58 -0500
X-Authenticated: #1426509
From: =?iso-8859-1?q?J=FCrgen_Repolusk?= <juerep@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: ALSA via82xx fails since 2.6.2
Date: Fri, 12 Mar 2004 21:34:11 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403122134.21542.juerep@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I see this in dmesg on 2.6.4-rc1:

VIA 82xx Audio: probe of 0000:00:07.5 failed with error -16

this is on a sony vaio pcg-fx505

regards
juergen repolusk, please CC me personally

complete dmesg (+lspci follow)
ADT (v001 SONY   K5       0x06040000 PTL_ 0x000f4240) @ 0x0fefee4c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0fefeec0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0fefeee8
ACPI: DSDT (v001  SONY  K5       0x06040000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=gentoo264 ro root=303 apm=off acpi=on
vga=0x318
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1200.077 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 254264k/262144k available (2817k kernel code, 7056k reserved, 1078k
data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2359.29 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) 4  stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1199.0872 MHz.
..... host bus clock speed is 199.0978 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7cd, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040211
ACPI: IRQ9 SCI: Level Trigger.
spurious 8259A interrupt: IRQ7.
irq 9: nobody cared!
Call Trace:
 [<c010b69b>] __report_bad_irq+0x2b/0x90
 [<c02592ad>] acpi_irq+0xf/0x1a
 [<c010b794>] note_interrupt+0x64/0xa0
 [<c010ba73>] do_IRQ+0x143/0x160
 [<c0109dc8>] common_interrupt+0x18/0x20
 [<c0126a94>] do_softirq+0x44/0xa0
 [<c025929e>] acpi_irq+0x0/0x1a
 [<c010ba47>] do_IRQ+0x117/0x160
 [<c0109dc8>] common_interrupt+0x18/0x20
 [<c010c04c>] setup_irq+0x9c/0x100
 [<c025929e>] acpi_irq+0x0/0x1a
 [<c010bb68>] request_irq+0x98/0xd0
 [<c02592ed>] acpi_os_install_interrupt_handler+0x35/0x5b
 [<c025929e>] acpi_irq+0x0/0x1a
 [<c025929e>] acpi_irq+0x0/0x1a
 [<c025d58e>] acpi_ev_install_sci_handler+0x1d/0x1f
 [<c025d548>] acpi_ev_sci_xrupt_handler+0x0/0x1c
 [<c025cf8d>] acpi_ev_handler_initialize+0x9/0x71
 [<c026ebf4>] acpi_enable_subsystem+0x2e/0x5b
 [<c04e35d2>] acpi_bus_init+0x7c/0x111
 [<c04e36c0>] acpi_init+0x59/0xb4
 [<c04d082c>] do_initcalls+0x2c/0xa0
 [<c01332c2>] init_workqueues+0x12/0x30
 [<c01050d5>] init+0x35/0x140
 [<c01050a0>] init+0x0/0x140
 [<c01072c9>] kernel_thread_helper+0x5/0xc

handlers:
[<c025929e>] (acpi_irq+0x0/0x1a)
Disabling IRQ #9
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
ACPI: Power Resource [PCR0] (off)
ACPI: Power Resource [PCR1] (off)
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
vesafb: framebuffer at 0xe9000000, mapped to 0xd080d000, size 8128k
vesafb: mode is 1024x768x24, linelength=3072, pages=2
vesafb: protected mode interface info at c000:50aa
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f74d0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 28 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:10 (@c00f758c)
powernow:  cpuid: 0x762 fsb: 100        maxFID: 0x2     startvid: 0xd
powernow:    FID: 0x4 (5.0x [500MHz])   VID: 0x13 (1.200V)
powernow:    FID: 0x6 (6.0x [600MHz])   VID: 0x13 (1.200V)
powernow:    FID: 0xa (8.0x [800MHz])   VID: 0x13 (1.200V)
powernow:    FID: 0xe (10.0x [1000MHz]) VID: 0xe (1.300V)
powernow:    FID: 0x2 (12.0x [1200MHz]) VID: 0xd (1.350V)

powernow: Minimum speed 500 MHz. Maximum speed 1200 MHz.
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: Thermal Zone [THRM] (62 C)
Console: switching to colour frame buffer device 128x48
sonypi: Sony Programmable I/O Controller Driver v1.21.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off,
compat = off, mask = 0xffffffff, useinput = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: AGP aperture is 128M @ 0xf0000000
ipmi: message handler initialized
ipmi: device interface at char major 253
ipmi_kcs: No KCS @ port 0x0ca2
ipmi_kcs: Unable to find any KCS interfaces
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-30, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST CD-RW/DVD DRIVE GCC-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Console: switching to colour frame buffer device 128x48
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 172k freed
Adding 514072k swap on /dev/hda2.  Priority:-1 extents:1
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xd1087800, 08:00:46:59:fa:80, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:07.2 to 64
uhci_hcd 0000:00:07.2: irq 9, io base 00001c00
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: detected 2 ports
uhci_hcd 0000:00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.4-rc1 uhci_hcd
usb usb1: SerialNumber: 0000:00:07.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: unknown reserved power switching mode
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
uhci_hcd 0000:00:07.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:07.3 to 64
uhci_hcd 0000:00:07.3: irq 9, io base 00001c20
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: detected 2 ports
uhci_hcd 0000:00:07.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.4-rc1 uhci_hcd
usb usb2: SerialNumber: 0000:00:07.3
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
uhci_hcd 0000:00:07.2: port 1 portsc 018a
hub 1-0:1.0: port 1, status 300, change 3, 1.5 Mb/s
uhci_hcd 0000:00:07.2: port 2 portsc 018a
hub 1-0:1.0: port 2, status 300, change 3, 1.5 Mb/s
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: unknown reserved power switching mode
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
uhci_hcd 0000:00:07.3: port 1 portsc 018a
hub 2-0:1.0: port 1, status 300, change 3, 1.5 Mb/s
uhci_hcd 0000:00:07.3: port 2 portsc 018a
hub 2-0:1.0: port 2, status 300, change 3, 1.5 Mb/s
uhci_hcd 0000:00:07.2: port 1 portsc 0188
hub 1-0:1.0: port 1 enable change, status 300
uhci_hcd 0000:00:07.2: port 2 portsc 0188
hub 1-0:1.0: port 2 enable change, status 300
unable to grab ports 0x1000-0x10ff
VIA 82xx Audio: probe of 0000:00:07.5 failed with error -16
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:0a.0 [104d:80f6]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
uhci_hcd 0000:00:07.3: port 1 portsc 0188
hub 2-0:1.0: port 1 enable change, status 300
uhci_hcd 0000:00:07.3: port 2 portsc 0188
hub 2-0:1.0: port 2 enable change, status 300
Yenta: ISA IRQ mask 0x0008, PCI irq 9
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0a.1 [104d:80f6]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0008, PCI irq 10
Socket status: 30000006
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
uhci_hcd 0000:00:07.2: suspend_hc
uhci_hcd 0000:00:07.3: suspend_hc
blk: queue cfdfb800, I/O limit 4095Mb (mask 0xffffffff)
mtrr: 0xe9000000,0x800000 overlaps existing 0xe9000000,0x400000
mtrr: 0xe9000000,0x800000 overlaps existing 0xe9000000,0x400000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.


lspci00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
40)
00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97
Audio Controller (rev 50)
00:07.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97
Modem] (rev 30)
00:0a.0 CardBus bridge: Texas Instruments PCI1420
00:0a.1 CardBus bridge: Texas Instruments PCI1420
00:0e.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller
(Link)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP
2x (rev 64)
02:00.0 Class ffff: Harris Semiconductor D-Links DWL-g650 A1 (rev ff)




lspci -vvxxx (via 82xx only)

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97
Audio Controller (rev 50)
        Subsystem: Sony Corporation: Unknown device 80f6
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 1000 [size=256]
        Region 1: I/O ports at 1c54 [size=4]
        Region 2: I/O ports at 1c50 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 58 30 01 00 10 02 50 00 01 04 00 00 00 00
10: 01 10 00 00 55 1c 00 00 51 1c 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 f6 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00
40: 05 c1 00 1c 40 00 00 00 01 00 00 02 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



- --
******************************************************************************
Jürgen Viktor Repolusk
Fleischmarkt 14/2/24
Austria - 1010 Vienna
phone: +43 (0)650 5661250
e-mail: juerep@gmx.at
web: http://www.repi.tk

this is unix land - in silent times you can hear windows machines reboot
******************************************************************************
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAUh7K86YqkexXDbgRArkrAJ0c+kOY+YGwy7RVEwzZRFFCEbTNTgCfZ2WG
oJ5ceNmwHXmp3+lKtRhx/u0=
=V3UC
-----END PGP SIGNATURE-----
