Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSKBQPR>; Sat, 2 Nov 2002 11:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSKBQPQ>; Sat, 2 Nov 2002 11:15:16 -0500
Received: from dialin-145-254-150-185.arcor-ip.net ([145.254.150.185]:7296
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S261294AbSKBQPK>; Sat, 2 Nov 2002 11:15:10 -0500
Date: Sat, 2 Nov 2002 15:32:58 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.44 bugs
Message-ID: <20021102143257.GA1183@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

See attached file. Hopefully enought descriptive, else ask me to present
more informations.

Nico
   -> not subscribe to lkml

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.5.44bugs"
Content-Transfer-Encoding: quoted-printable

net/ipv4/raw.c: missing include: linux/netfilter_ipv4.h
Typo in include/linux/pnp.h: ) must be replaced by }
ds.o does not load: Permission denied. pcmcia_core loads without problems
trident.c/o: When loading, soundcard makes very high noise, like it happens
             when you put the microphone next to the loudspeakers
             After setting the volume with aumix, the problem disappers.

-------- > problem shown:

flapp:~ # modprobe ds
/lib/modules/2.5.44/kernel/drivers/pcmcia/ds.o: init_module: Operation not =
permitted
Hint: insmod errors can be caused by incorrect module parameters, including=
 invalid IO or IRQ parameters
/lib/modules/2.5.44/kernel/drivers/pcmcia/ds.o: insmod /lib/modules/2.5.44/=
kernel/drivers/pcmcia/ds.o failed
/lib/modules/2.5.44/kernel/drivers/pcmcia/ds.o: insmod ds failed

------------ > Modules loaded while trying to load ds:

flapp:~ # lsmod
Module                  Size  Used by
ipv6                  161984  -1  (autoclean)
e100                   57312   1  (autoclean)
psmouse                 5456   0  (unused)
ide-cd                 31152   0  (autoclean)
cdrom                  28832   0  (autoclean) [ide-cd]
trident                31824   0=20
soundcore               4304   0  [trident]
ac97_codec             10864   0  [trident]
nls_iso8859-15          3392   1  (autoclean)
nls_cp437               4384   1  (autoclean)
vfat                    9712   1  (autoclean)
fat                    38496   0  (autoclean) [vfat]


---------- > Kernel Version/Output:

Linux version 2.5.44 (root@flapp) (gcc version 3.2) #2 Tue Oct 22 09:12:21 =
CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages
  Normal zone: 61424 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3D2.5.44 ro root=3D302 BOOT_FILE=3D/bo=
ot/2.5/44-21-Oct-2002
Initializing CPU#0
Detected 646.660 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1273.85 BogoMIPS
Memory: 256492k/262080k available (1716k kernel code, 5200k reserved, 465k =
data, 88k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=3D1
PCI: Using configuration type 1
Registering system device cpu0
adding '' to cpu class interfaces
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Registering system device pic0
Registering system device rtc0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) =3D 40
Journalled Block Device driver loaded
devfs: v1.21 (20020820) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS CVS-09/15/02:17 with quota, no debug enabled
Capability LSM initialized
pty: 256 Unix98 ptys configured
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ALI15X3: IDE controller at PCI slot 00:10.0
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x6050-0x6057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x6058-0x605f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area =3D> 1
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=3D1222/255/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
atkbd.c: Unknown key (set 0, scancode 0xfc, on isa0060/serio1) pressed.
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 88k freed
Adding 297192k swap on /dev/discs/disc0/part3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14=
.10f, 09:02:23 Oct 22 2002
PCI: Guessed IRQ 10 for device 00:06.0
trident: ALi Audio Accelerator found at IO 0x9000, IRQ 10
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev 16:00, sector 0
end_request: I/O error, dev 16:00, sector 0
end_request: I/O error, dev 16:00, sector 0
input: PS/2 Generic Mouse on isa0060/serio1
Intel(R) PRO/100 Network Driver - version 2.1.24-k1
Copyright (c) 2002 Intel Corporation

PCI: Guessed IRQ 10 for device 00:0a.0
e100: selftest OK.
e100: eth0: Intel(R) 8255x-based Ethernet Adapter
  Mem:0x80100000  IRQ:10  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: eth0 NIC Link is Up 100 Mbps Full duplex
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ds: no socket drivers loaded!
unloading Kernel Card Services
MTRR: setting reg 1
MTRR: setting reg 1
MTRR: setting reg 1
spurious 8259A interrupt: IRQ7.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ds: no socket drivers loaded!
unloading Kernel Card Services

--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9w+IZtnlUggLJsX0RAsPxAJ0Sic36CjteIiW/W0AkFYmMb2YJfwCePXKI
ZznV0tCbfsO2syOxlU66/iE=
=lG21
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
