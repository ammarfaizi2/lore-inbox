Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266240AbSKSPRo>; Tue, 19 Nov 2002 10:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSKSPRo>; Tue, 19 Nov 2002 10:17:44 -0500
Received: from brokedown.net ([24.217.80.65]:31433 "EHLO ns1.brokedown.net")
	by vger.kernel.org with ESMTP id <S266240AbSKSPRb>;
	Tue, 19 Nov 2002 10:17:31 -0500
Subject: Keyboard/Mouse Locking Up On Laptop
From: Josh Grebe <squash2@brokedown.net>
To: linux-kernel@vger.kernel.org
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Nov 2002 09:20:14 -0600
Message-Id: <1037719215.7701.13.camel@squashlaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_ns1.brokedown.net-17628-1037719487-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_ns1.brokedown.net-17628-1037719487-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi All,

I have a Compaq Evo n600c laptop. This unit works great while plugged
in, but when it runs on battery power, after a couple of minutes of
idle, the keyboard and mouse will stop responding. The BIOS is pretty
limited in options, and doesn't have anything to adjust APM settings,
and compiling the kernel with apm enabled or disabled also makes no
difference.

One strange thing, if I am running X and the keyboard freezes, I can ssh
in from another machine and chvt 1 and have a working text console. chvt
7 brings me right back to a frozen X session. Similarly, if I'm in a
text console and it freezes, I an remotely start X and have a working X
session, but chvt back to text mode is still frozen. This affects all
text consoles, so chvt 2 takes me to another fozen session. The tty
still works, as killing the running process, or wall/write, or the
process updating its screen does update the console as you would expect.

I've been plugging at this thing for a while now, I've gone as far as to
disable screen blanking in vgacon.c, but to no avail. Below is my boot
messages as well as some possibly pertinant info from /proc.

Any assistance is greatly appreciated.

- Josh

Boot messages:
Linux version 2.4.18 (root@squashlaptop) (gcc version 3.2) #11 SMP Tue
Nov 19 08
:21:20 CST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027fd0000 (usable)
 BIOS-e820: 0000000027fd0000 - 0000000027ff0c00 (reserved)
 BIOS-e820: 0000000027ff0c00 - 0000000027ffc000 (ACPI NVS)
 BIOS-e820: 0000000027ffc000 - 0000000028000000 (reserved)
On node 0 totalpages: 163792
zone(0): 4096 pages.
zone(1): 159696 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=3D2.4.18-test root=3D303
Initializing CPU#0
Detected 730.903 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1458.17 BogoMIPS
Memory: 641932k/655168k available (1551k kernel code, 12848k reserved,
398k data
, 232k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) III Mobile CPU      1066MHz stepping 01
per-CPU timeslice cutoff: 1463.08 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 730.9014 MHz.
..... host bus clock speed is 132.8910 MHz.
cpu: 0, clocks: 1328910, slice: 664455
CPU0<T0:1328896,T1:664432,D:9,S:664455,C:1328910>
Waiting on wait_init_idle (map =3D 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf04dd, last bus=3D4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Using IRQ router default [8086/248c] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS02 at 0x03e8 (irq =3D 4) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=3D32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4060-0x4067, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4068-0x406f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 39070080 sectors (20004 MB), CHS=3D2584/240/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@sa
w.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:A5:B4:E3:CD, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: Detected Intel i830M chipset
agpgart: AGP aperture is 256M @ 0x60000000
[drm] AGP 0.99 on Unknown @ 0x60000000 256MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
maestro3: version 1.22 built at 08:22:36 Nov 19 2002
maestro3: Configuring ESS Allegro found at IO 0x2400 IRQ 11
maestro3:  subvendor id: 0x00940e11
ac97_codec: AC97 Audio codec, id: 0x4583:0x8308 (ESS Allegro ES1988)
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 08:22:43 Nov 19 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x4000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x4020, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x4040, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver rio500
rio500.c: v1.1:USB Rio 500 driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack (5118 buckets, 40944 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 264592k swap-space (priority -1)


lspci:
00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
M6 LY
02:03.0 CardBus bridge: Texas Instruments PCI1420
02:03.1 CardBus bridge: Texas Instruments PCI1420
02:04.0 Communication controller: Lucent Microelectronics LT WinModem
(rev 02)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VM (KM)
Ethernet Controller (rev 41)

/proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 8086:3575 (Intel Corp.) (rev 2).
      Prefetchable 32 bit memory at 0x60000000 [0x6fffffff].
  Bus  0, device   1, function  0:
    PCI bridge: PCI device 8086:3576 (Intel Corp.) (rev 2).
      Master Capable.  Latency=3D64.  Min Gnt=3D12.
  Bus  0, device  29, function  0:
    USB Controller: PCI device 8086:2482 (Intel Corp.) (rev 1).
      IRQ 11.
      I/O at 0x4000 [0x401f].
  Bus  0, device  29, function  1:
    USB Controller: PCI device 8086:2484 (Intel Corp.) (rev 1).
      IRQ 11.
      I/O at 0x4020 [0x403f].
  Bus  0, device  29, function  2:
    USB Controller: PCI device 8086:2487 (Intel Corp.) (rev 1).
      IRQ 11.
      I/O at 0x4040 [0x405f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev
65).
      Master Capable.  No bursts.  Min Gnt=3D6.
  Bus  0, device  31, function  0:
    ISA bridge: PCI device 8086:248c (Intel Corp.) (rev 1).
  Bus  0, device  31, function  1:
    IDE interface: PCI device 8086:248a (Intel Corp.) (rev 1).
      IRQ 11.
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x4060 [0x406f].
      Non-prefetchable 32 bit memory at 0x28000000 [0x280003ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon Mobility M6
LY (rev 0).
      IRQ 11.
      Master Capable.  Latency=3D66.  Min Gnt=3D8.
      Prefetchable 32 bit memory at 0x48000000 [0x4fffffff].
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0x40200000 [0x4020ffff].
  Bus  2, device   3, function  0:
    CardBus bridge: Texas Instruments PCI1420 (rev 0).
      IRQ 11.
      Master Capable.  Latency=3D66.  Min Gnt=3D196.Max Lat=3D3.
      Non-prefetchable 32 bit memory at 0x40000000 [0x40000fff].
  Bus  2, device   3, function  1:
    CardBus bridge: Texas Instruments PCI1420 (#2) (rev 0).
      IRQ 11.
      Master Capable.  Latency=3D66.  Min Gnt=3D196.Max Lat=3D3.
      Non-prefetchable 32 bit memory at 0x40080000 [0x40080fff].
  Bus  2, device   4, function  0:
    Communication controller: Lucent Microelectronics LT WinModem (rev
2).
      IRQ 11.
      Master Capable.  Latency=3D66.  Min Gnt=3D252.Max Lat=3D14.
      Non-prefetchable 32 bit memory at 0x40180000 [0x401800ff].
      I/O at 0x2840 [0x2847].
      I/O at 0x2000 [0x20ff].
  Bus  2, device   8, function  0:
    Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet
Controller (rev 65).
      IRQ 11.
      Master Capable.  Latency=3D66.  Min Gnt=3D8.Max Lat=3D56.
      Non-prefetchable 32 bit memory at 0x40100000 [0x40100fff].
      I/O at 0x2800 [0x283f].
  Bus  2, device   9, function  0:
    Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev
18).
      IRQ 11.
      Master Capable.  Latency=3D64.  Min Gnt=3D2.Max Lat=3D24.
      I/O at 0x2400 [0x24ff].

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
2000-2fff : PCI Bus #02
  2000-20ff : Lucent Microelectronics LT WinModem
  2400-24ff : ESS Technology ES1988 Allegro-1
    2400-24ff : maestro3
  2800-283f : Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller
    2800-283f : eepro100
  2840-2847 : Lucent Microelectronics LT WinModem
3000-3fff : PCI Bus #01
  3000-30ff : ATI Technologies Inc Radeon Mobility M6 LY
4000-401f : PCI device 8086:2482 (Intel Corp.)
  4000-401f : usb-uhci
4020-403f : PCI device 8086:2484 (Intel Corp.)
  4020-403f : usb-uhci
4040-405f : PCI device 8086:2487 (Intel Corp.)
  4040-405f : usb-uhci
4060-406f : PCI device 8086:248a (Intel Corp.)
  4060-4067 : ide0
  4068-406f : ide1

/proc/interrupts:
          CPU0
  0:     263044          XT-PIC  timer
  1:       4903          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 11:      43981          XT-PIC  Allegro, usb-uhci, usb-uhci, usb-uhci,
eth0
 12:      17897          XT-PIC  PS/2 Mouse
 14:      17218          XT-PIC  ide0
NMI:          0
LOC:     263011
ERR:          0
MIS:          0

/proc/apm:
1.16 1.2 0x03 0x01 0x03 0x09 91% -1 ?

/proc/devices:
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 tts/%d
  5 cua/%d
  7 vcs
 10 misc
 13 input
 14 sound
128 ptm
136 pts/%d
162 raw
180 usb
226 drm

Block devices:
  3 ide0











--=_ns1.brokedown.net-17628-1037719487-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA92lauqO3cwDbBqFwRAlc6AJ48Lgx7EtYOQiSjkeHJjJYysnqavgCdH6q/
az160rjMgP1Efn3fg1J+cRk=
=FVsh
-----END PGP SIGNATURE-----

--=_ns1.brokedown.net-17628-1037719487-0001-2--
