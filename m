Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTKXUpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTKXUpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:45:36 -0500
Received: from CPE000102d0fe24-CM0f1119830776.cpe.net.cable.rogers.com ([65.49.144.24]:38661
	"EHLO thorin.norang.ca") by vger.kernel.org with ESMTP
	id S261552AbTKXUpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:45:16 -0500
Date: Mon, 24 Nov 2003 15:45:13 -0500
From: Bernt Hansen <bernt@norang.ca>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Toshiba ACPI battery status - ACPI errors
Message-ID: <20031124204513.GA8950@norang.ca>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
Organization: Norang Consulting Inc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a new Toshiba Tecra S1 laptop which I cannot get ACPI battery
status from.  I grepped my dmesg output for ACPI and got the following
messages:

 BIOS-e820: 000000001fff0000 - 000000001fffffc0 (ACPI data)
 BIOS-e820: 000000001fffffc0 - 0000000020000000 (ACPI NVS)
ACPI: RSDP (v000 OID_00                                    ) @
0x000e6010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @
0x1fffaaf0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @
0x1ffffb00
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @
0x1ffffb90
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010101) @
0x1ffffbc0
ACPI: SSDT (v001 INSYDE   GV3Ref 0x00002000 INTL 0x20021002) @
0x1fffab30
ACPI: DSDT (v001 TOSINV   INT810 0x00001002 INTL 0x02002036) @
0x00000000
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._STA]
(Node dff61fe0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._STA]
(Node dff61ea0), AE_NOT_EXIST
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 6)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 7 10 11)
ACPI: Embedded Controller [EC0] (gpe 16)
ACPI: Power Resource [PUT2] (on)
ACPI: Power Resource [PFA1] (off)
ACPI: Power Resource [PFA0] (off)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
acpiphp_glue: can't get bus number, assuming 0
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)

The errors with "Method execution failed" seem to be my problem.  Any
ideas what I can try to get the status of the batteries in this laptop?
There are two batteries in this thing.

I have attached the full dmesg output in case it is helpful.  Let me
know what I can do to help solve this problem.

Thanks,
Bernt.

-- 
Bernt Hansen     Norang Consulting Inc.

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg output
Content-Disposition: attachment; filename="x.x"

Linux version 2.6.0-test10-legolas (root@legolas) (gcc version 3.3.2 (Debian)) #1 Mon Nov 24 12:19:13 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fffffc0 (ACPI data)
 BIOS-e820: 000000001fffffc0 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e6010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @ 0x1fffaaf0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @ 0x1ffffb00
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @ 0x1ffffb90
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010101) @ 0x1ffffbc0
ACPI: SSDT (v001 INSYDE   GV3Ref 0x00002000 INTL 0x20021002) @ 0x1fffab30
ACPI: DSDT (v001 TOSINV   INT810 0x00001002 INTL 0x02002036) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=LinuxNoX ro root=303 2
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1495.416 MHz processor.
Console: colour dummy device 80x25
Memory: 515192k/524224k available (1912k kernel code, 8284k reserved, 842k data, 152k init, 0k highmem)
Calibrating delay loop... 2957.31 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1494.0867 MHz.
..... host bus clock speed is 99.0657 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xe9f24, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node dff61fe0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node dff61ea0), AE_NOT_EXIST
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 6)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 7 10 11)
ACPI: Embedded Controller [EC0] (gpe 16)
ACPI: Power Resource [PUT2] (on)
ACPI: Power Resource [PFA1] (off)
ACPI: Power Resource [PFA0] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xa8000000, mapped to 0xe080d000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at c000:574f
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1500MHz": max frequency: 1500000kHz
speedstep-smi: signature:0x47534943, command:0x008200b2, event:0x00ff00b3, perf_level:0x07d00001.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
acpiphp_glue: can't get bus number, assuming 0
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
toshiba: not a supported Toshiba laptop
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

PCI: Enabling device 0000:02:08.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:02:08.0 to 64
e100: selftest timeout
e100: Failed to initialize, instance #0
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: IC25N040ATCS05-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63
 hda: hda1 hda2 hda3
Console: switching to colour frame buffer device 128x48
Yenta: CardBus bridge found at 0000:02:09.0 [1179:ff10]
Yenta: ISA IRQ list 0008, PCI irq10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:02:09.1 [1179:ff10]
Yenta: ISA IRQ list 0000, PCI irq11
Socket status: 30000059
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 5, pci mem e1812000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001200
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001600
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001700
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Intel 810 + AC97 Audio, version 0.24, 12:18:14 Nov 24 2003
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0xe100 and 0xe000, MEM 0xf0000000 and 0xf0000200, IRQ 10
i810: Intel ICH4 mmio at 0xe1814000 and 0xe1816200
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS99 (Unknown)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
i810_audio: setting clocking to 48546
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
hub 2-0:1.0: new USB device on port 1, assigned address 2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:1d.0-1
Adding 529192k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
cs: unable to map card memory!
cs: unable to map card memory!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x170-0x177 0x300-0x307 0x310-0x31f 0x370-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

--z6Eq5LdranGa6ru8--
