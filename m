Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbTC2WiB>; Sat, 29 Mar 2003 17:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbTC2WiB>; Sat, 29 Mar 2003 17:38:01 -0500
Received: from [200.43.253.62] ([200.43.253.62]:28080 "EHLO smtp.bensa.ar")
	by vger.kernel.org with ESMTP id <S261165AbTC2Why>;
	Sat, 29 Mar 2003 17:37:54 -0500
From: Norberto BENSA <nbensa@gmx.net>
Reply-To: nbensa@yahoo.com
Organization: BENSA.ar
Subject: Problem burning with ATAPI cd-rw
Date: Sat, 29 Mar 2003 19:07:38 -0300
User-Agent: KMail/1.5
X-GPG-KEY: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x49664BBE
X-OS: Gentoo GNU/Linux 1.4
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_qkhh++d1IIwsDv/";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200303291907.38188.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_qkhh++d1IIwsDv/
Content-Type: multipart/mixed;
  boundary="Boundary-01=_qkhh+Jj9Tlwrl7P"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_qkhh+Jj9Tlwrl7P
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hello all,

I'm having a problem burning CDs. I ruined 3 cds (yeah, now I know '-dummy'=
=20
:-/ and after checking dmesg, I see lots of these messages (or similar)

	ATAPI device hda:
	  Error: Illegal request -- (Sense key=3D0x05)
	  Invalid field in parameter list -- (asc=3D0x26, ascq=3D0x00)
	  The failed "Mode Select 10" packet command was:
	  "55 10 00 00 00 00 00 00 3c 00 00 00 "
	hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
	hda: packet command error: error=3D0x50
	hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
	hda: packet command error: error=3D0x50

This is kernel 2.4.20 (actually gentoo-sources 2.4.20-r1 with ptrace patch.=
)=20
I'm using glibc 2.3.2, cdrecord 2.0, xcdroast 0.98_alpha13. I'm not using=20
ide-scsi.

hda: SAMSUNG CD-R/RW DRIVE SW-208F, ATAPI CD/DVD-ROM drive
hdb: Pioneer DVD-ROM ATAPIModel DVD-114 0124, ATAPI CD/DVD-ROM drive
hdc: QUANTUM FIREBALLP AS20.5, ATA DISK drive
hdd: ST330630A, ATA DISK drive

(full dmesg is attached.)

I know this drive works because I burned lots of CDs with it under Linux. T=
he=20
only thing I've changed is glibc (from 2.3.1 to 2.3.2) but I find it hard t=
o=20
believe it'd be the culprit; correct me if I'm wrong.

Someone suggested me to try a new ide cable, but it didn't make any=20
difference.

Thanks in advance for any help,

Norberto

--Boundary-01=_qkhh+Jj9Tlwrl7P
Content-Type: text/plain;
  charset="us-ascii";
  name="kernel_dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="kernel_dmesg"

Linux version 2.4.20-gentoo-r1 (root@venkman) (gcc version 3.2.2 20030322 (=
Gentoo Linux 1.4 3.2.2-r2)) #6 Sat Mar 29 00:55:29 ART 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/discs/disc0/part7 vga=3D0x0f06 quiet
Local APIC disabled by BIOS -- reenabling.
=46ound and enabled local APIC!
Initializing CPU#0
Detected 1000.142 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 1970.17 BogoMIPS
Memory: 254432k/262080k available (1325k kernel code, 5220k reserved, 240k =
data, 100k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 999.0881 MHz.
=2E.... host bus clock speed is 133.0317 MHz.
cpu: 0, clocks: 133317, slice: 66658
CPU0<T0:133312,T1:66640,D:14,S:66658,C:133317>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG CD-R/RW DRIVE SW-208F, ATAPI CD/DVD-ROM drive
hdb: Pioneer DVD-ROM ATAPIModel DVD-114 0124, ATAPI CD/DVD-ROM drive
hdc: QUANTUM FIREBALLP AS20.5, ATA DISK drive
hdd: ST330630A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02cbdf0, I/O limit 4095Mb (mask 0xffffffff)
hdc: 40132503 sectors (20548 MB) w/1902KiB Cache, CHS=3D39813/16/63, UDMA(1=
00)
blk: queue c02cbf30, I/O limit 4095Mb (mask 0xffffffff)
hdd: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3D59303/16/63, UDMA(6=
6)
Partition check:
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [2498/255/63] p1 < p5 p6 p7 p8 >
 /dev/ide/host0/bus1/target1/lun0: [PTBL] [3720/255/63] p1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 16:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
=46reeing unused kernel memory: 100k freed
Adding Swap: 265032k swap-space (priority -1)
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 12 for device 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xdc00, 00:e0:7d:9f:1f:90, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139C'
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 10 for device 00:07.2
PCI: Sharing IRQ 10 with 00:07.3
PCI: Sharing IRQ 10 with 00:0c.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:07.3
PCI: Sharing IRQ 10 with 00:07.2
PCI: Sharing IRQ 10 with 00:0c.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
mice: PS/2 mouse device common for all mice
Creative EMU10K1 PCI Audio Driver, version 0.20a, 01:16:43 Mar 29 2003
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:07.2
PCI: Sharing IRQ 10 with 00:07.3
emu10k1: EMU10K1 rev 5 model 0x8040 found, IO at 0xe000-0xe01f, IRQ 10
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
hda: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdb: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: raid0 personality registered as nr 2
 [events: 0000081a]
 [events: 0000081a]
md: autorun ...
md: considering ide/host0/bus1/target0/lun0/part8 ...
md:  adding ide/host0/bus1/target0/lun0/part8 ...
md:  adding ide/host0/bus1/target1/lun0/part1 ...
md: created md0
md: bind<ide/host0/bus1/target1/lun0/part1,1>
md: bind<ide/host0/bus1/target0/lun0/part8,2>
md: running: <ide/host0/bus1/target0/lun0/part8><ide/host0/bus1/target1/lun=
0/part1>
md: ide/host0/bus1/target0/lun0/part8's event counter: 0000081a
md: ide/host0/bus1/target1/lun0/part1's event counter: 0000081a
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid0: looking at ide/host0/bus1/target1/lun0/part1
raid0:   comparing ide/host0/bus1/target1/lun0/part1(29880768) with ide/hos=
t0/bus1/target1/lun0/part1(29880768)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 1 zones
raid0: looking at ide/host0/bus1/target0/lun0/part8
raid0:   comparing ide/host0/bus1/target0/lun0/part8(15590976) with ide/hos=
t0/bus1/target1/lun0/part1(29880768)
raid0:   NOT EQUAL
raid0:   comparing ide/host0/bus1/target0/lun0/part8(15590976) with ide/hos=
t0/bus1/target0/lun0/part8(15590976)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 0
raid0: checking ide/host0/bus1/target1/lun0/part1 ... contained as device 0
  (29880768) is smallest!.
raid0: checking ide/host0/bus1/target0/lun0/part8 ... contained as device 1
  (15590976) is smallest!.
raid0: zone->nb_dev: 2, size: 31181952
raid0: current zone offset: 15590976
raid0: zone 1
raid0: checking ide/host0/bus1/target1/lun0/part1 ... contained as device 0
  (29880768) is smallest!.
raid0: checking ide/host0/bus1/target0/lun0/part8 ... nope.
raid0: zone->nb_dev: 1, size: 14289792
raid0: current zone offset: 29880768
raid0: done.
raid0 : md_size is 45471744 blocks.
raid0 : conf->smallest->size is 14289792 blocks.
raid0 : nb_zone is 4.
raid0 : Allocating 32 bytes for hash.
md: updating md0 RAID superblock on device
md: ide/host0/bus1/target0/lun0/part8 [events: 0000081b]<6>(write) ide/host=
0/bus1/target0/lun0/part8's sb offset: 15590976
md: ide/host0/bus1/target1/lun0/part1 [events: 0000081b]<6>(write) ide/host=
0/bus1/target1/lun0/part1's sb offset: 29880768
md: ... autorun DONE.
SGI XFS snapshot 2.4.20-2002-11-29_01:21_UTC with no debug enabled
XFS mounting filesystem md(9,0)
Ending clean XFS mount for filesystem: md(9,0)
hub.c: new USB device 00:07.2-1, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:07.2-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x5a9/0xa511) is not claimed by any active d=
river.
hub.c: new USB device 00:07.2-1.2, assigned address 4
input0: Microsoft Microsoft IntelliMouse=AE Explorer on usb1:4.0
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
hdb: CHECK for good STATUS
hdd: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
hdd: task_no_data_intr: error=3D0x04 { DriveStatusError }
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4191  Mon D=
ec  9 11:49:01 PST 2002
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
inserting floppy driver for 2.4.20-gentoo-r1
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 02 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 08 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in parameter list -- (asc=3D0x26, ascq=3D0x00)
  The failed "Mode Select 10" packet command was:=20
  "55 10 00 00 00 00 00 00 3c 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 02 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 08 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in parameter list -- (asc=3D0x26, ascq=3D0x00)
  The failed "Mode Select 10" packet command was:=20
  "55 10 00 00 00 00 00 00 3c 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 02 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 08 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 02 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Mode Sense 10" packet command was:=20
  "5a 00 30 00 00 00 00 00 08 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x30
ATAPI device hda:
  Error: Medium error -- (Sense key=3D0x03)
  Write error - loss of streaming -- (asc=3D0x0c, ascq=3D0x09)
  The failed "Write 10" packet command was:=20
  "2a 00 ff ff ff 6a 00 00 1f 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x30
ATAPI device hda:
  Error: Medium error -- (Sense key=3D0x03)
  (reserved error code) -- (asc=3D0x02, ascq=3D0x00)
  The failed "Write 10" packet command was:=20
  "2a 00 00 00 02 6c 00 00 1f 00 00 00 "
hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=3D0x50
ATAPI device hda:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in parameter list -- (asc=3D0x26, ascq=3D0x00)
  The failed "Mode Select 10" packet command was:=20
  "55 10 00 00 00 00 00 00 10 00 00 00 "

--Boundary-01=_qkhh+Jj9Tlwrl7P--

--Boundary-03=_qkhh++d1IIwsDv/
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+hhkqFXVF50lmS74RAmjdAKCfMcWBXhuOamVfQnYxJ9kv2BTZtACgqKHA
URG1i/uD+sdg0U7qbpm62uQ=
=7OCx
-----END PGP SIGNATURE-----

--Boundary-03=_qkhh++d1IIwsDv/--

