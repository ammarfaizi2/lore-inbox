Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUFRPqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUFRPqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUFRPpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:45:31 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:42494 "EHLO
	damned.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S265226AbUFRPl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:41:29 -0400
To: linux-kernel@vger.kernel.org
Subject: radeonfb == blank screen (Thinkpad r50p - FireGL T2 1600x1200 LCD)
Message-Id: <20040618154118.ED0D5106@damned.travellingkiwi.com>
Date: Fri, 18 Jun 2004 16:41:18 +0100 (BST)
From: hamish@travellingkiwi.com (Hamie)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

I've just tried kernel 2.6.7 and radeonfb on my Thinkpad r50p, and sadly it doesn't seem to work as advertised. The display works fine in VGA 80x24 on initial boot, but when the radeonfb initialises, I get a blank screen with just the cursor flashing back & forth at the bottom in time to whatever is supposedly supposed to be displayed.

Thankfully X does manage to get the display back, so I can login afterwards... If I load it as a module, I can then switch back to the console (CTRL-ALT-F1) and I'm back in 80x24 VGA mode again...


dmesg output is appended...

The system itself is debian-unstable

Not sure if I'm doing anything wrong... Or if it's a bug. The dmesg output (With radeonfb debugging enabled) doesn't seem to show any errors. I am unsing ACPI though (As you can see from the dmesg output). Any advice gratefully listened to...

TIA

hamish

595.005 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 514676k/523648k available (2228k kernel code, 8204k reserved, 916k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3162.11 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9f9b7 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.......................................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F005) - 1322 Objects with 63 Devices 391 Methods 20 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c0456e1c
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 1 Runtime GPEs in this block
ACPI: Found ECDT
Completing Region/Field/Buffer/Package initialization:...............................................................................................................................................................................................................................................................
Initialized 19/20 Regions 123/123 Fields 67/67 Buffers 46/46 Packages (1332 nodes)
Executing all Device _STA and_INI methods:....................................................... exfldio-0143 [22] ex_setup_region       : Field [PWKI] access width (4 bytes) too large for region [U7CS] (length 2)
exfldio-0155 [22] ex_setup_region       : Field [PWKI] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
exfldio-0179: *** Warning: The ACPI AML in your computer contains errors, please nag the manufacturer to correct it.
exfldio-0182: *** Warning: Allowing relaxed access to fields; turn on CONFIG_ACPI_DEBUG for details.
exfldio-0143 [22] ex_setup_region       : Field [PWKI] access width (4 bytes) too large for region [U7CS] (length 2)
exfldio-0155 [22] ex_setup_region       : Field [PWKI] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
exfldio-0143 [22] ex_setup_region       : Field [PWUC] access width (4 bytes) too large for region [U7CS] (length 2)
exfldio-0155 [22] ex_setup_region       : Field [PWUC] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
exfldio-0143 [22] ex_setup_region       : Field [PWUC] access width (4 bytes) too large for region [U7CS] (length 2)
exfldio-0155 [22] ex_setup_region       : Field [PWUC] Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
....
59 Devices found containing: 59 _STA, 8 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
Linux Kernel Card Services
 options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
radeonfb_pci_register BEGIN
radeonfb: probed SDR SGRAM 131072k videoram
radeonfb: mapped 16384k videoram
radeonfb: Invalid ROM signature 303 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=320.00 Mhz, System=202.00 MHz
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-2: registered as adapter #2
i2c_adapter i2c-3: registered as adapter #3
1 chips in connector info
- chip 1 has 2 connectors
 * connector 0 of type 2 (CRT) : 2300
 * connector 1 of type 4 (DVI-D) : 4200
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1600x1200              radeonfb: detected LVDS panel size from BIOS: 1600x1200
BIOS provided panel power delay: 1000
radeondb: BIOS provided dividers will be used
ref_divider = c
post_divider = 0
fbk_divider = 48
Scanning BIOS table ...
320 x 350
320 x 400
320 x 400
320 x 480
400 x 600
512 x 384
640 x 350
640 x 400
640 x 475
640 x 480
720 x 576
800 x 600
848 x 480
1024 x 768
1152 x 864
1280 x 1024
1600 x 1200
Found panel in BIOS table:
 hblank: 560
 hOver_plus: 56
 hSync_width: 192
 vblank: 50
 vOver_plus: 2
 vSync_width: 3
 clock: 16200
Setting up default mode based on panel info
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon NT  SDR SGRAM 128 MB
radeonfb_pci_register END
Simple Boot Flag at 0x35 set to 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Using anticipatory io scheduler
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
   ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
   ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HTS726060M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
       current capacity is 110194034 sectors (56419 MB)
       native  capacity is 117210240 sectors (60011 MB)
hda: 110194034 sectors (56419 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 >
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
Firmware: 5.9
Sensor: 44
new absolute packet format
Touchpad has extended capability bits
-> multifinger detection
-> palm detection
-> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
i2c-core: driver dev_driver registered.
i2c_adapter i2c-0: Registered as minor 0
i2c_adapter i2c-1: Registered as minor 1
i2c_adapter i2c-2: Registered as minor 2
i2c_adapter i2c-3: Registered as minor 3
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding 1466600k swap on /dev/hda14.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49543 usecs
intel8x0: clocking to 48000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem e1975000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Bluetooth: Core ver 2.5
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.6
usbcore: registered new driver hci_usb
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
usb 4-1: new full speed USB device using address 2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
hw_random: RNG not detected
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0552]
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000086
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0552]
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000086
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Thermal Zone [THM0] (49 C)
cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
SCSI subsystem initialized
Bluetooth: L2CAP ver 2.2
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Non-volatile memory driver v1.2
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
hamish@ballbreaker:~$ 

