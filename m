Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbTL3UUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbTL3UUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:20:52 -0500
Received: from ik-dynamic-66-102-65-169.kingston.net ([66.102.65.169]:14721
	"EHLO linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id S265948AbTL3UUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:20:39 -0500
Subject: Re: Fw: oops with 2.6.0 on IBM 600X
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Adam Belay <ambx1@neo.rr.com>,
       nplanel@mandrakesoft.com, Lonnie Borntreger <cooker@borntreger.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200312302302.10834.arvidjaar@mail.ru>
References: <20031219212249.32461180.akpm@osdl.org>
	 <20031228115349.7e4947d5.akpm@osdl.org> <1072795322.5759.438.camel@pc>
	 <200312302302.10834.arvidjaar@mail.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QkCeBuwkfaGrGnJleiQw"
Message-Id: <1072815626.922.11.camel@pc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2mdk 
Date: Tue, 30 Dec 2003 15:20:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QkCeBuwkfaGrGnJleiQw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-30 at 15:02, Andrey Borzenkov wrote:
> looking more closely: apparently we have IDE (PCI?) chipset; additionally=
 BIOS=20
> export PnP information about IDE controller. Brian, could you do lspnp to=
=20
> verify and dmesg of system boot?

# lspnp
00 PNP0000 system peripheral: programmable interrupt controller
01 PNP0200 system peripheral: DMA controller
02 PNP0100 system peripheral: system timer
03 PNP0b00 system peripheral: real time clock
04 PNP0800 system peripheral: other
05 PNP0303 input device: keyboard
06 IBM3780 input device: mouse
07 PNP0c04 system peripheral: other
08 PNP0700 mass storage device: floppy
09 PNP0a03 bridge controller: PCI
0a PNP0c02 system peripheral: other
0b PNP0400 communications device: AT parallel port
0d PNP0501 communications device: RS-232
0e IBM0071 communications device: other
0f PNP0e03 bridge controller: PCMCIA
12 PNP0680 mass storage device: IDE
14 PNP0680 mass storage device: IDE
16 PNP0c02 system peripheral: other

# dmesg
Linux version 2.6.0 (brian@pc) (gcc version 3.3.1 (Mandrake Linux 9.2 3.3.1=
-4mdk)) #4 Tue Dec 30 08:24:43 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bfd0000 (usable)
 BIOS-e820: 000000000bfd0000 - 000000000bfdf000 (ACPI data)
 BIOS-e820: 000000000bfdf000 - 000000000bfe0000 (ACPI NVS)
 BIOS-e820: 000000000bfe0000 - 000000000c000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49104
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45008 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI disabled because your bios is from 1999 and too old
You can enable it with acpi=3Dforce
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v000 IBM                                       ) @ 0x000fd6e0
ACPI: RSDT (v001 IBM    TP600X   0x00000001  0x00000000) @ 0x0bfd0000
ACPI: FADT (v001 IBM    TP600X   0x00000001  0x00000000) @ 0x0bfd0100
ACPI: BOOT (v001 IBM    TP600X   0x00000001  0x00000000) @ 0x0bfd0040
ACPI: DSDT (v001 IBM    TP600X   0x00000106 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=3D260-linus ro root=3D3a00 devfs=3Dmount ac=
pi=3Dht splash=3Dsilent
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 124.507 MHz processor.
Console: colour dummy device 80x25
Memory: 190152k/196416k available (1747k kernel code, 5640k reserved, 814k =
data, 260k init, 0k highmem)
Calibrating delay loop... 589.82 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
Freeing initrd memory: 530k freed
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd880, last bus=3D7
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe700
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe724, dseg 0xf0000
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x15e0-0x15ef has been reserved
pnp: 00:0a: ioport range 0xef00-0xefaf has been reserved
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 7 of bridge 0000:00:07.3 [ef00:ef3f]
PCI: Address space collision on region 8 of bridge 0000:00:07.3 [efa0:efbf]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
vesafb: framebuffer at 0xe0000000, mapped to 0xcc800000, size 4032k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D1
vesafb: protected mode interface info at c000:ac10
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
pty: 1024 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23AA-60B, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CRN-8241B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 11733120 sectors (6007 MB) w/512KiB Cache, CHS=3D12416/15/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
Console: switching to colour frame buffer device 128x48
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
PM: Reading pmdisk image.
PM: Resume from disk failed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 260k freed
Real Time Clock Driver v1.12
EXT3 FS on dm-0, internal journal
Adding 524280k swap on /dev/rootvol/swap.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
inserting floppy driver for 2.6.0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
NET: Registered protocol family 17
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:06.0
PCI: Sharing IRQ 11 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0130]
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 06b8, PCI irq11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:02.1
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 06b8, PCI irq11
Socket status: 30000020
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
xircom_tulip_cb.c derived from tulip.c:v0.91 4/14/99 becker@scyld.com
 unofficial 2.4.x kernel port, version 0.91+LK1.1, October 11, 2001
PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:06:00.0 to 64
eth0: Xircom Cardbus Adapter rev 3 at 0x5000, 00:06:29:52:5E:57, IRQ 11.
eth0:  MII transceiver #0 config 3100 status 7809 advertising 01e1.
spurious 8259A interrupt: IRQ7.
eth0: Link is up, running at 100Mbit half-duplex
mtrr: 0xe0000000,0x400000 overlaps existing 0xe0000000,0x200000
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0347c40(lo)
IPv6 over IPv4 tunneling driver
pnp: Device 00:0b activated.
parport0: PC-style at 0x3bc [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
eth0: no IPv6 routers present

Cheers,
b.

--=20
My other computer is your Microsoft Windows server.

Brian J. Murrell

--=-QkCeBuwkfaGrGnJleiQw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8d4Il3EQlGLyuXARAl82AJwML7FIHlB4Qx+YuLxToeJT08ywUQCguHZ9
dyd3DE47NUtR8H6VcWPZZpk=
=W3dq
-----END PGP SIGNATURE-----

--=-QkCeBuwkfaGrGnJleiQw--

