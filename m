Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315165AbSD3VdH>; Tue, 30 Apr 2002 17:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315224AbSD3VdH>; Tue, 30 Apr 2002 17:33:07 -0400
Received: from 213-145-191-71.dd.nextgentel.com ([213.145.191.71]:35367 "EHLO
	sevilla.gnome.no") by vger.kernel.org with ESMTP id <S315165AbSD3VdA>;
	Tue, 30 Apr 2002 17:33:00 -0400
Subject: IDE problems and a solution
From: Kjartan Maraas <kmaraas@online.no>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-xSwjgoqjVjswWk717wcD"
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 30 Apr 2002 23:32:08 +0200
Message-Id: <1020202328.1186.28.camel@sevilla.gnome.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xSwjgoqjVjswWk717wcD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I recently bought a new Compaq Evo N600c laptop with a fairly new Intel
IDE chipset on it (attaching dmesg and lspci output), and I ran into
problems with enabling DMA on it. After asking Compaq support I only got
an answer that Linux wasn't supported on this unit.

Later I found a couple of helpful engineers from the ProLiant server
team who installed Linux on a similar laptop to see if they could
reproduce the problem, and they did.

I started worrying I would have to return the laptop and just get
another one that was known to work. This was when Arjan hooked me up
with Andre on irc and things started going the right way :)

After mailing the attached output from dmesg and lspci he produced a
patch that made the machine work in record time. So I went from thinking
this was a hopeless situation to being told it was just a plain bug in
one day and I'm now a _very_ happy camper looking forward to solving the
other problems I have on the new laptop.

Great work Andre! And thanks to the Compaq guys who have spent time
helping out.

Patch will be up at http://linuxdiskcert.org/ shortly I'm told.

Cheers
Kjartan Maraas

PS. I tried 2.5.11 and that didn't work at all. I got the same warnings
during startup and a total hang later in the boot process. Poke me if
you want more details on that.


--=-xSwjgoqjVjswWk717wcD
Content-Description: 
Content-Disposition: attachment; filename=dmesg-failing-case.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Linux version 2.4.18-0.13 (bhcompile@porky.devel.redhat.com) (gcc version 2=
.96 20000731 (Red Hat Linux 7.2 2.96-109)) #1 Mon Apr 1 14:59:55 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
 BIOS-e820: 000000000ffd0000 - 000000000fff0c00 (reserved)
 BIOS-e820: 000000000fff0c00 - 000000000fffc000 (ACPI NVS)
 BIOS-e820: 000000000fffc000 - 0000000010000000 (reserved)
On node 0 totalpages: 65488
zone(0): 4096 pages.
zone(1): 61392 pages.
zone(2): 0 pages.
Kernel command line: ro root=3D/dev/hda3 hdc=3Dide-scsi bios=3Dassign-busse=
s
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 797.360 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1592.52 BogoMIPS
Memory: 255252k/261952k available (1644k kernel code, 6312k reserved, 312k =
data, 280k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf04b7, last bus=3D4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
aio_setup: okay!
aio_setup: sizeof(struct page) =3D 56
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IR=
Q SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS02 at 0x03e8 (irq =3D 4) is a 16550A
Real Time Clock Driver v1.10e
block: 496 slots per queue, batch=3D124
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PIIX4: (ide_setup_pci_device:) Could not enable device.
hda: IC25N030ATDA04-0, ATA DISK drive
hdc: SD-R2102, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=3D3876/240/63
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 122k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 280k freed
Adding Swap: 521600k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 15:18:13 Apr  1 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 02:09.0
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x4000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x4020, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x4040, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
ide-floppy driver 0.99.newide
hdc: driver not present
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2102  Rev: 1A08
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
ip_conntrack (2046 buckets, 16368 max)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 02:08.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:A5:B6:66:60, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:03.0
PCI: Sharing IRQ 11 with 02:03.1
PCI: Found IRQ 11 for device 02:03.1
PCI: Sharing IRQ 11 with 02:03.0
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x140-0x14f 0x378-0x=
37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Keyboard timed out[1]
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i830M chipset
agpgart: AGP aperture is 256M @ 0x60000000
[drm] AGP 0.99 on Unknown @ 0x60000000 256MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
maestro3: version 1.22 built at 15:16:16 Apr  1 2002
PCI: Found IRQ 11 for device 02:09.0
PCI: Sharing IRQ 11 with 00:1d.0
maestro3: Configuring ESS Allegro found at IO 0x2400 IRQ 11
maestro3:  subvendor id: 0x00940e11
ac97_codec: AC97 Audio codec, id: 0x4583:0x8308 (ESS Allegro ES1988)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12

--=-xSwjgoqjVjswWk717wcD
Content-Description: 
Content-Disposition: attachment; filename=lspci-failing-case.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at 60000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [40] #09 [1105]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2
		Command: RQ=3D0 SBA+ AGP+ 64bit- FW- Rate=3Dx1
00: 86 80 75 35 06 00 10 20 04 00 00 06 00 00 00 00
10: 08 00 00 60 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 30 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 09 a0 05 11 01 00 00 00 00 00 00 00 02 28 00 0e
50: 72 a2 0a 00 00 00 00 00 00 10 11 11 00 00 11 11
60: 00 00 04 08 08 08 00 00 00 00 00 00 00 00 00 00
70: ff 11 ff ff 00 00 00 00 10 00 04 00 70 42 00 30
80: 00 00 00 00 00 00 00 00 00 10 12 20 00 00 00 00
90: 0a 38 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 00 20 00 17 02 00 1f 01 03 00 00 00 00 00 00
b0: 80 00 00 00 00 00 00 00 00 00 50 0d 20 00 00 00
c0: 00 56 0e 41 a2 99 01 00 c0 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 1c 49 32 fc
f0: 14 44 04 70 22 33 0b 05 35 d2 31 ce 77 cb 1e cb

00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 04) (prog=
-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 40200000-402fffff
	Prefetchable memory behind bridge: 48000000-4fffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 76 35 07 00 20 00 04 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 30 30 a0 22
20: 20 40 20 40 00 48 f0 4f 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02) (prog-if=
 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 4000 [size=3D32]
00: 86 80 82 24 05 00 80 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 40 00 00 00 00 00 00 00 00 00 00 11 0e 30 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02) (prog-if=
 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 4020 [size=3D32]
00: 86 80 84 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 40 00 00 00 00 00 00 00 00 00 00 11 0e 30 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02) (prog-if=
 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 4040 [size=3D32]
00: 86 80 87 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 40 00 00 00 00 00 00 00 00 00 00 11 0e 30 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 0=
0 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D04, sec-latency=3D32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 40000000-401fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 00 80 00 42 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 04 20 20 20 80 22
20: 00 40 10 40 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00
40: 02 28 20 20 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 02 00 00 00 c0 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 47 0f 00 00 00 00 62 3e

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 8c 24 0f 01 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 10 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 11 00 00 10 00 00 00
60: 0b 0b 0b 0b 92 00 00 00 0b 0b 0b 80 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: fd 54 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 8d 03 00 00 04 00 00 00 0d 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 40 40 05 00 00 00 00
c0: 70 00 00 00 40 01 00 01 80 10 00 00 7f 07 00 00
d0: 07 20 00 02 02 07 00 00 04 00 00 00 00 00 00 00
e0: 70 00 00 c0 00 00 0f 3c 33 22 11 00 00 00 67 45
f0: 00 00 69 80 00 00 00 00 47 0f 0f 00 00 00 01 00

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [=
Master SecP PriP])
	Subsystem: Compaq Computer Corporation: Unknown device 0030
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned> [size=3D8]
	Region 1: I/O ports at <unassigned> [size=3D4]
	Region 2: I/O ports at <unassigned> [size=3D8]
	Region 3: I/O ports at <unassigned> [size=3D4]
	Region 4: I/O ports at 4060 [size=3D16]
	Region 5: Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=
=3D1K]
00: 86 80 8a 24 05 00 80 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 40 00 00 00 00 00 10 00 00 00 00 11 0e 30 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 07 a3 07 a3 00 00 00 00 01 00 01 00 00 00 00 00
50: 00 00 00 00 11 10 00 00 00 00 00 00 00 00 00 00
60: 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 =
LY (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device b111
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 48000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: I/O ports at 3000 [size=3D256]
	Region 2: Memory at 40200000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=3D47 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D31 SBA+ AGP+ 64bit- FW- Rate=3Dx1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 02 10 59 4c 87 00 b0 02 00 00 00 03 08 42 00 00
10: 08 00 00 48 01 30 00 00 00 00 20 40 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 11 b1
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 11 b1
50: 01 00 02 06 00 00 00 00 02 50 20 00 07 02 00 2f
60: 01 03 00 1f 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:03.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Compaq Computer Corporation: Unknown device 004e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 08 a8 82 00
10: 00 00 00 40 a0 00 00 02 02 03 03 b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 c0 05
40: 11 0e 4e 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 28 00 00 00 00 00 00 00 00 02 10 00 01
90: 80 02 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 06 00 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:03.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Compaq Computer Corporation: Unknown device 004e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40080000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D04, subordinate=3D04, sec-latency=3D176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 08 a8 82 00
10: 00 00 08 40 a0 00 00 02 02 04 04 b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 c0 05
40: 11 0e 4e 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 28 00 00 00 00 00 00 00 00 02 10 00 01
90: 80 02 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 06 00 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:04.0 Communication controller: Lucent Microelectronics LT WinModem (rev =
02)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0450
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 66 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40180000 (32-bit, non-prefetchable) [size=3D256]
	Region 1: I/O ports at 2840 [size=3D8]
	Region 2: I/O ports at 2000 [size=3D256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D160mA PME(D0-,D1-,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: c1 11 50 04 07 00 90 02 02 00 80 07 00 42 00 00
10: 00 00 18 40 41 28 00 00 01 20 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 68 14 50 04
30: 00 00 00 00 f8 00 00 00 00 00 00 00 0b 01 fc 0e
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff 00 00 00 00 01 00 e2 e4 00 00 00 00

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet C=
ontroller (rev 42)
	Subsystem: Compaq Computer Corporation: Unknown device 0098
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40100000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at 2800 [size=3D64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-
00: 86 80 38 10 07 00 90 02 42 00 00 02 08 42 00 00
10: 00 00 10 40 01 28 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 98 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 fe
e0: 00 40 00 3a 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:09.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 1=
2)
	Subsystem: Compaq Computer Corporation: Unknown device 0094
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 2400 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 5d 12 88 19 05 00 90 02 12 00 01 04 00 40 00 00
10: 01 24 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 94 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 02 18
40: 7f 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 40 00 40 0a 00 00 00 00 00 01 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 94 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 22 76 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--=-xSwjgoqjVjswWk717wcD--
