Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUHUNo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUHUNo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 09:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUHUNo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 09:44:27 -0400
Received: from smtprelay02.uni-oldenburg.de ([134.106.40.86]:6590 "EHLO
	smtprelay02.uni-oldenburg.de") by vger.kernel.org with ESMTP
	id S265477AbUHUNny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 09:43:54 -0400
Date: Sat, 21 Aug 2004 15:43:46 +0200
From: matthias brill <matthias.brill@akamail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: atiixp problem with asus L4000R
Message-ID: <20040821134346.GA7415@akamail.com>
Reply-To: matthias.brill@akamail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
X-Conspiracy: there is no conspiracy
User-Agent: Mutt/1.5.6+20040803i
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.106808, Antispam-Data: 2004.8.20.110968
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__TO_MALFORMED_2 0, __HAS_MSGID 0, __SANE_MSGID 0, __MIME_VERSION 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CD 0, __USER_AGENT 0, USER_AGENT 0.000'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi takashi,

i'm wrangling with an asus L4000R-series (L4510RBP) pentium-m/ati9100igp
notebook, and i'm in need of help.  the machine alleges to include an
"ATI Technologies Inc IXP150 AC'97 Audio Controller":

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio Controller

the snd_atiixp (2.6.8.1) module fails on this one:

ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -13

i've been looking through the code in atiixp.c but don't see what "-13"
is supposed to mean...?

i don't know what is needed to support this particular IXP150 -- i'm
appending 'lspci -v', 'dmesg' and the current kernel .config.

thanks in advance, thias


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5830 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8107
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f7f00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] AGP version 3.0

0000:00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5838 (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fd700000-fdafffff
	Prefetchable memory behind bridge: efe00000-f7dfffff

0000:00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4347 (rev 01) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8108
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fe900000 (32-bit, non-prefetchable) [size=4K]

0000:00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4348 (rev 01) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8108
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at fea00000 (32-bit, non-prefetchable) [size=4K]

0000:00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4345 (rev 01) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8108
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
	Memory at feb00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

0000:00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 18)
	Subsystem: Asustek Computer, Inc.: Unknown device 8108
	Flags: 66MHz, medium devsel
	I/O ports at 0a00 [size=16]
	Memory at 1e000000 (32-bit, non-prefetchable) [size=1K]

0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349 (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8108
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at ff00 [size=16]

0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
	Subsystem: Asustek Computer, Inc.: Unknown device 8108
	Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342 (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=64
	Memory behind bridge: fdb00000-fe0fffff

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio Controller
	Subsystem: Asustek Computer, Inc.: Unknown device 1833
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 5
	Memory at fe700000 (32-bit, non-prefetchable) [size=256]

0000:00:14.6 Modem: ATI Technologies Inc: Unknown device 434d (rev 01) (prog-if 00 [Generic])
	Subsystem: Asustek Computer, Inc.: Unknown device 1836
	Flags: 66MHz, slow devsel, IRQ 5
	Memory at fe800000 (32-bit, non-prefetchable) [size=256]

0000:01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5835 (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1832
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
	Memory at f0000000 (32-bit, prefetchable) [size=64M]
	I/O ports at e000 [size=256]
	Memory at fda00000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fd900000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
	Capabilities: [50] Power Management version 2

0000:02:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev b8)
	Subsystem: Asustek Computer, Inc.: Unknown device 1834
	Flags: bus master, medium devsel, latency 168, IRQ 5
	Memory at 1e001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 1e400000-1e7ff000 (prefetchable)
	Memory window 1: 1e800000-1ebff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

0000:02:05.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C551 IEEE 1394 Controller (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1837
	Flags: bus master, medium devsel, latency 64, IRQ 7
	Memory at fe000000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2

0000:02:06.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Flags: bus master, fast devsel, latency 64, IRQ 7
	Memory at fdf00000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2

0000:02:07.0 Network controller: Broadcom Corporation BCM4301 802.11b (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 0120
	Flags: bus master, fast devsel, latency 64, IRQ 5
	Memory at fde00000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.8.1 (thias@cinnamon) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #1 Sat Aug 21 14:04:46 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001df40000 (usable)
 BIOS-e820: 000000001df40000 - 000000001df50000 (ACPI data)
 BIOS-e820: 000000001df50000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
479MB LOWMEM available.
On node 0 totalpages: 122688
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 118592 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000fad90
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000425 MSFT 0x00000097) @ 0x1df40000
ACPI: FADT (v001 A M I  OEMFACP  0x05000425 MSFT 0x00000097) @ 0x1df40200
ACPI: ECDT (v001 A M I  OEMECDT  0x05000425 MSFT 0x00000097) @ 0x1df40360
ACPI: OEMB (v001 A M I  OEMBIOS  0x05000425 MSFT 0x00000097) @ 0x1df50040
ACPI: DSDT (v001  A0009 A0009000 0x00000000 INTL 0x20030522) @ 0x00000000
Built 1 zonelists
Kernel command line: ro root=/dev/hda5 acpi_os_name="Microsoft Windows  XP"
Found and enabled local APIC!
Initializing CPU#0
CPU 0 irqstacks, hard=c0400000 soft=c03ff000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1400.274 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 482424k/490752k available (2055k kernel code, 7556k reserved, 829k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2777.08 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.0862 MHz.
..... host bus clock speed is 99.0990 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Found ECDT
    ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.RDC3] (Node ddeb37e0), AE_AML_NO_RETURN_VALUE
    ACPI-1133: *** Error: Method execution failed [\ECIO] (Node ddeb3320), AE_AML_NO_RETURN_VALUE
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.BAT0._STA] (Node ddeb2bc0), AE_AML_NO_RETURN_VALUE
    ACPI-0154: *** Error: Method execution failed [\_SB_.PCI0.BAT0._STA] (Node ddeb2bc0), AE_AML_NO_RETURN_VALUE
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 6)
    ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.RDC3] (Node ddeb37e0), AE_AML_NO_RETURN_VALUE
    ACPI-1133: *** Error: Method execution failed [\ECIO] (Node ddeb3320), AE_AML_NO_RETURN_VALUE
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.BAT0._STA] (Node ddeb2bc0), AE_AML_NO_RETURN_VALUE
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12 14 15)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:14.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:14.6[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
ACPI: PCI interrupt 0000:02:05.1[B] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 5 (level, low) -> IRQ 5
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Ati IGP9100/M chipset
agpgart: Maximum main memory to use for agp memory: 409M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:00:14.6[B] -> GSI 5 (level, low) -> IRQ 5
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI interrupt 0000:00:14.1[A] -> GSI 11 (level, low) -> IRQ 11
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N060ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >
ieee1394: Initialized config rom entry `ip1394'
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1400MHz": max frequency: 1400000kHz
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 1004020k swap on /dev/hda1.  Priority:-1 extents:1
Real Time Clock Driver v1.12
Asus Laptop ACPI Extras version 0.28
  L4R model detected, unsupported, trying default values, supply the developers with your DSDT
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -13
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:13.0: PCI device 1002:4347 (ATI Technologies Inc)
ohci_hcd 0000:00:13.0: irq 10, pci mem de8d1000
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:13.1: PCI device 1002:4348 (ATI Technologies Inc)
ohci_hcd 0000:00:13.1: irq 10, pci mem de8dc000
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:13.2: PCI device 1002:4345 (ATI Technologies Inc)
ehci_hcd 0000:00:13.2: irq 10, pci mem de8de000
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
hub 3-0:1.0: over-current change on port 1
hub 3-0:1.0: over-current change on port 6
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 5 (level, low) -> IRQ 5
Yenta: CardBus bridge found at 0000:02:05.0 [1043:1834]
Yenta: ISA IRQ mask 0x0018, PCI irq 5
Socket status: 30000006
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:05.1[B] -> GSI 7 (level, low) -> IRQ 7
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[7]  MMIO=[fe000000-fe0007ff]  Max Packet=[2048]
b44.c:v0.94 (May 4, 2004)
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 7 (level, low) -> IRQ 7
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0e:a6:8e:d1:c5
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000317baeb]
ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ip_conntrack version 2.1 (3834 buckets, 30672 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
b44: eth0: Link is down.

--/04w6evG8XlLl3ft
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="040821-2.6.8.1-config.gz"
Content-Transfer-Encoding: base64

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
tQ7wbzjCDl4n8net2Aci/gd50l3rFnYAAA==

--/04w6evG8XlLl3ft--

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJ1GS15PQg+xdZ4cRAqL8AKCMElW77xN++XQXILOE+wG4GeV9XACZAYnK
AxKYZLscYe062PQex3KfHXQ=
=YJPf
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
