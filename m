Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTHFN72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTHFN72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:59:28 -0400
Received: from mail46-s.fg.online.no ([148.122.161.46]:32179 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP id S263171AbTHFN6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:58:55 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Con Kolivas <kernel@kolivas.org>, Alex Goddard <agoddard@purdue.edu>,
       svein@brage.info
Subject: Re: 2.6.0-tst2-mm4 and ide-scsi
Date: Wed, 6 Aug 2003 15:57:39 +0200
User-Agent: KMail/1.5.2
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
References: <871xw1kyu2.fsf@lapper.ihatent.com> <200308060413.22293.svein.ove@aas.no> <200308061221.47391.kernel@kolivas.org>
In-Reply-To: <200308061221.47391.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XlQM/ucgjsYVh06"
Message-Id: <200308061557.47645.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XlQM/ucgjsYVh06
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

onsdag 6. august 2003, 04:21, skrev Con Kolivas:
> On Wed, 6 Aug 2003 12:13, Svein Ove Aas wrote:
> > onsdag 6. august 2003, 04:15, skrev Con Kolivas:
> > > On Wed, 6 Aug 2003 11:46, Svein Ove Aas wrote:
> > > > onsdag 6. august 2003, 03:43, skrev Alex Goddard:
> > > > > I'm pretty much positive that cdrecord has a disk at once version
> > > > > that doesn't make anything explode.
> > > >
> > > > The only one I'm aware of is the '-dao' option, but that's no good
> > > > when what I really want to do is burn a CUE sheet and files, or copy
> > > > another CD. It still expects an ISO file(or WAV, whatever) as input.
> > > >
> > > > Actualy, the only use for that option that I'm aware of is to help a
> > > > few troubled CD-readers.
> > >
> > > Latest version supports -dao cuefile=3D
> > >
> > > please download and use that.
> >
> > All right, that takes care of everything for the moment; well, except f=
or
> > getting the wheel on my mouse to work with 2.6.0. (Grumble)
>
> USB mouse? Check you have correct module loaded/builtin and you have usbfs
> mounted with this in your fstab
>
> none /proc/bus/usb usbfs defaults 0 0

As it turns out, that wasn't the problem; however, looking at it I noticed=
=20
that my USB mouse *wasn't registered*.
As it turns out, I had only compiled support for EHCI, and I needed OHCI to=
=20
make things work.

Curiously, the mouse *did* work earlier (apart from the wheel, that is) whe=
n I=20
loaded the psmouse module, which is no longer needed. Now, why is that?

On another note, the kernel now reboots immediately after boot unless I=20
disable ACPI. Having done that, I get routeing conflicts instead; the EHCI=
=20
and OHCI controllers are, of course, the same device, but their drivers see=
m=20
to want to use different IRQs.

That happened in 2.4 as well, but without the reboots; even so, something's=
=20
obviously wrong.
I'll attach my .config, dmesg output and lspci output if anyone wants to ha=
ve=20
a go.

> > Just out of curiousity, how would you *read* a CD in the same way?
>
> Pass. man cdrecord?

No dice.

=2D - Svein Ove Aas
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MQlZ9OlFkai3rMARAsEGAJ9VHu28PRRU8POIU/weZROTwVQIAQCeP6Ph
zuZTWOS1KIxoAvpta9a4rDo=3D
=3DyN9H
=2D----END PGP SIGNATURE-----

--Boundary-00=_XlQM/ucgjsYVh06
Content-Type: text/plain;
  charset="iso-8859-1";
  name="msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="msg"

Linux version 2.6.0-test2 (root@flash.brage.info) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #8 Wed Aug 6 14:25:04 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Gentoo_2.6.0 ro root=342 acpi=off
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1800.924 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3547.13 BogoMIPS
Memory: 515388k/524272k available (1836k kernel code, 8088k reserved, 716k data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 2200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1799.0832 MHz.
..... host bus clock speed is 266.0641 MHz.
Initializing RT netlink socket
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xf1ad0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Disabled via command line (acpi=off)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
Enabling SEP on CPU 0
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Real Time Clock Driver v1.11
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT371: IDE controller at PCI slot 0000:00:0b.0
PCI: Found IRQ 9 for device 0000:00:0b.0
HPT371: chipset revision 1
HPT37X: using 33MHz PCI clock
HPT371: 100% native mode on irq 9
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
hdg: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
hdh: SONY CD-RW CRX160E, ATAPI CD/DVD-ROM drive
hdg: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdg: set_drive_speed_status: error=0x04
hdh: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdh: set_drive_speed_status: error=0x04
ide3 at 0xa800-0xa807,0xa402 on irq 9
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x8000-0x8007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x8008-0x800f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: Maxtor 6Y120L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MAXTOR 6L080J4, ATA DISK drive
hdd: MAXTOR 6L080J4, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
hdb: max request size: 128KiB
hdb: host protected area => 1
hdb: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(133)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3
hdc: max request size: 128KiB
hdc: host protected area => 1
hdc: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(133)
 /dev/ide/host0/bus1/target0/lun0: p1
hdd: max request size: 128KiB
hdd: host protected area => 1
hdd: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(133)
 /dev/ide/host0/bus1/target1/lun0: p1
end_request: I/O error, dev hdg, sector 0
hdg: ATAPI 32X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdh, sector 0
end_request: I/O error, dev hdh, sector 0
hdh: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache
PCI: Found IRQ 3 for device 0000:00:10.3
IRQ routing conflict for 0000:00:10.0, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.1, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.2, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.3, have irq 9, want irq 3
ehci_hcd 0000:00:10.3: VIA Technologies, In USB 2.0
ehci_hcd 0000:00:10.3: irq 9, pci mem e0804000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 3 for device 0000:00:10.0
IRQ routing conflict for 0000:00:10.0, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.1, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.2, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.3, have irq 9, want irq 3
uhci-hcd 0000:00:10.0: VIA Technologies, In USB
uhci-hcd 0000:00:10.0: irq 9, io base 00009000
uhci-hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PCI: Found IRQ 3 for device 0000:00:10.1
IRQ routing conflict for 0000:00:10.0, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.1, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.2, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.3, have irq 9, want irq 3
uhci-hcd 0000:00:10.1: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:10.1: irq 9, io base 00008800
uhci-hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
PCI: Found IRQ 3 for device 0000:00:10.2
IRQ routing conflict for 0000:00:10.0, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.1, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.2, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.3, have irq 9, want irq 3
uhci-hcd 0000:00:10.2: VIA Technologies, In USB (#3)
uhci-hcd 0000:00:10.2: irq 9, io base 00008400
uhci-hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb2) for (hdb2)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-1
b44.c:v0.9 (Jul 14, 2003)
PCI: Found IRQ 9 for device 0000:00:09.0
eth0: Broadcom 4400 10/100BaseT Ethernet 00:e0:18:ae:d3:f7
loop: loaded (max 8 devices)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-0) for (dm-0)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-1) for (dm-1)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-4) for (dm-4)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-2) for (dm-2)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-3) for (dm-3)
Using r5 hash to sort names
NTFS driver 2.1.4 [Flags: R/W MODULE].
NTFS volume version 3.1.
Adding 2097144k swap on /usr/swapfile.  Priority:-1 extents:5317
PCI: Found IRQ 10 for device 0000:00:0e.0
PCI: Sharing IRQ 10 with 0000:00:07.0
PCI: Sharing IRQ 10 with 0000:00:08.0
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
ip_tables: (C) 2000-2002 Netfilter core team
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT

--Boundary-00=_XlQM/ucgjsYVh06
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pci"

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e9000000-e9ffffff
	Prefetchable memory behind bridge: eb700000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8800000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at d800 [size=128]
	Capabilities: <available only to root>

00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=64]
	Region 1: I/O ports at d000 [size=16]
	Region 2: I/O ports at b800 [size=128]
	Region 3: Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at e7800000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: <available only to root>

00:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at eb6f0000 [disabled] [size=16K]
	Capabilities: <available only to root>

00:0b.0 RAID bus controller: Triones Technologies, Inc. HPT371 (rev 01)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ea800000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ea000000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
	Subsystem: Creative Labs CT4780 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9800 [size=32]
	Capabilities: <available only to root>

00:0e.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 06)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 9400 [size=8]
	Capabilities: <available only to root>

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 9000 [size=32]
	Capabilities: <available only to root>

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 8800 [size=32]
	Capabilities: <available only to root>

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at 8400 [size=32]
	Capabilities: <available only to root>

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 8000 [size=16]
	Capabilities: <available only to root>

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
	Subsystem: Asustek Computer, Inc. A7V8X Motherboard (Realtek ALC650 codec)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at e000 [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 200] (rev a3) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 4057
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e9000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Region 2: Memory at eb800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at eb7f0000 [disabled] [size=64K]
	Capabilities: <available only to root>


--Boundary-00=_XlQM/ucgjsYVh06
Content-Type: text/plain;
  charset="iso-8859-1";
  name="conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="conf"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_DM=y
CONFIG_DM_IOCTL_V4=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IPV6=m
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=m
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
CONFIG_SCTP_HMAC_NONE=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_TULIP=y
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
CONFIG_NET_PCI=y
CONFIG_B44=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ADI=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_VIAPRO=m
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_REISERFS_FS=y
CONFIG_MINIX_FS=m
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=m
CONFIG_NFSD=m
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_EMU10K1=m
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_TVMIXER=m
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--Boundary-00=_XlQM/ucgjsYVh06--

