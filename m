Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281692AbRKZODe>; Mon, 26 Nov 2001 09:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281694AbRKZODP>; Mon, 26 Nov 2001 09:03:15 -0500
Received: from kryton.packetst0rm.net ([213.229.39.136]:13466 "EHLO
	mx0.packetst0rm.net") by vger.kernel.org with ESMTP
	id <S281692AbRKZODC>; Mon, 26 Nov 2001 09:03:02 -0500
Date: Mon, 26 Nov 2001 15:02:52 +0100 (CET)
From: Michael Kummer <frost@packetst0rm.net>
X-X-Sender: frost@warp4
To: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.4.[5/15]
Message-ID: <Pine.LNX.4.40.0111261446110.716-100000@warp4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi

i getting the following panic when i try to 'make install' openssl (it
has been compiled on a faster system), but the error occurs everytime the
CPU load gets high or much memory is in use.

i've already changed the RAM but with no success.
any suggestions about this?

- -- log 1 --

Nov 26 15:19:43 test kernel: invalid operand: 0000
Nov 26 15:19:43 test kernel: CPU:    0
Nov 26 15:19:43 test kernel: EIP:    0010:[<c012d876>]    Not tainted
Nov 26 15:19:43 test kernel: EFLAGS: 00010206
Nov 26 15:19:43 test kernel: eax: c032fb00   ebx: c030fb18   ecx: c030fb00
edx: 000007f1
Nov 26 15:19:43 test kernel: esi: c101fc40   edi: 00000000   ebp: 00000001
esp: c081fe84
Nov 26 15:19:43 test kernel: ds: 0018   es: 0018   ss: 0018
Nov 26 15:19:43 test kernel: Process basename (pid: 6336,
stackpage=c081f000)
Nov 26 15:19:43 test kernel: Stack: c030fd20 00000101 00000000 c030fba8
000007f1 00000282 00000000 c030fb00
Nov 26 15:19:43 test kernel:        c012da7f 000001d2 c274bd00 00000001
c109a180 c030fd18 000001d2 c01255f9
Nov 26 15:19:43 test kernel:        c012d8c6 00234000 c0125632 00234000
c274bd00 00000001 c005e320 c012570a
Nov 26 15:19:43 test kernel: Call Trace: [<c012da7f>] [<c01255f9>]
[<c012d8c6>] [<c0125632>] [<c012570a>]
Nov 26 15:19:43 test kernel:    [<c0111b74>] [<c0111a18>] [<c010c350>]
[<c013339c>] [<c01333e7>] [<c0106df4>]
Nov 26 15:19:44 test kernel:
Nov 26 15:19:44 test kernel: Code: 0f 0b 8b 46 18 a9 40 00 00 00 74 02 0f
0b 8b 46 18 a9 80 00

- -- log 1 --

- -- log 2 --

Nov 26 15:39:27 test kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Nov 26 15:39:27 test kernel:  printing eip:
Nov 26 15:39:27 test kernel: c012c075
Nov 26 15:39:27 test kernel: *pde = 0084c067
Nov 26 15:39:27 test kernel: *pte = 00000000
Nov 26 15:39:27 test kernel: Oops: 0002
Nov 26 15:39:27 test kernel: CPU:    0
Nov 26 15:39:27 test kernel: EIP:    0010:[<c012c075>]    Not tainted
Nov 26 15:39:27 test kernel: EFLAGS: 00010006
Nov 26 15:39:27 test kernel: eax: 00000000   ebx: c0045838   ecx: c0d6b040
edx: 00000000
Nov 26 15:39:27 test kernel: esi: c0045830   edi: 00000246   ebp: 000000f0
esp: c0ad7e44
Nov 26 15:39:27 test kernel: ds: 0018   es: 0018   ss: 0018
Nov 26 15:39:27 test kernel: Process perl (pid: 9588, stackpage=c0ad7000)
Nov 26 15:39:27 test kernel: Stack: c0805080 c086d560 c0ad7ea8 c0ad7ea8
c0186053 c0045830 000000f0 00000000
Nov 26 15:39:27 test kernel:        c0ad7ecc c0ad7ea8 00000001 c05c70e0
c0ad7ea8 00000000 c0ad7ecc c0ad7ea8
Nov 26 15:39:27 test kernel:        00000000 c01861b0 c01861c6 c0ad7ea8
c0805080 c0ad7ecc c0ad7ecc 00000000
Nov 26 15:39:27 test kernel: Call Trace: [<c0186053>] [<c01861b0>]
[<c01861c6>] [<c01862fc>] [<c0185e3b>]
Nov 26 15:39:27 test kernel:    [<c0186543>] [<c0127dae>] [<c01281e6>]
[<c0128100>] [<c01814bb>] [<c0133766>]
Nov 26 15:39:27 test kernel:    [<c0106ce3>]
Nov 26 15:39:27 test kernel:
Nov 26 15:39:27 test kernel: Code: 89 42 04 89 10 8b 46 08 89 48 04 89 01
89 59 04 89 4e 08 8b

- -- log 2 --

- - last top output --

  3:39pm  up 8 min,  3 users,  load average: 1.26, 0.91, 0.43
30 processes: 27 sleeping, 3 running, 0 zombie, 0 stopped
CPU states: 67.2% user, 24.1% system,  0.0% nice,  8.6% idle
Mem:    13228K av,   12352K used,     876K free,       0K shrd,    1444K
buff
Swap:  102812K av,    1036K used,  101776K free                    4476K
cached

13859 root       9   0  1432 1380  1188 S     2.5 10.4   0:04 sshd
21384 root       9   0  1448 1264  1188 S     0.0  9.5   0:00 sshd
13634 root       9   0  1392 1220  1148 S     0.0  9.2   0:01 sshd
20372 root       9   0  1192 1192   952 S     0.0  9.0   0:00 bash
 5768 root      15   0  1176 1176   980 R     5.1  8.8   0:00 perl
26127 root      14   0  1020 1020   816 R     6.8  7.7   0:13 top
10488 root       9   0  1240 1016   944 S     0.0  7.6   0:00 bash
17549 root       9   0  1216  968   968 S     0.0  7.3   0:00 bash
31877 root      12   0   960  960   856 S     3.4  7.2   0:00 sh
15814 root      10   0   948  948   844 S     0.8  7.1   0:01 sh
11717 root       9   0   988  864   792 S     0.0  6.5   0:00 sshd
15694 root       9   0   788  788   620 S     0.0  5.9   0:00 make
25758 root      10   0   784  784   680 R     2.5  5.9   0:01 syslogd
16093 bin        9   0   664  660   560 S     0.0  4.9   0:00 rpc.portmap
10015 daemon     9   0   648  564   564 S     0.0  4.2   0:00 atd
 2261 root       9   0   580  536   492 S     0.0  4.0   0:00 crond
 4268 root       9   0   508  508   440 S     0.0  3.8   0:01 klogd
 8932 root       9   0   440  408   372 S     0.0  3.0   0:00 tail
    1 root       8   0   216  200   180 S     0.0  1.5   0:11 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      18  19     0    0     0 SWN   0.0  0.0   0:00
ksoftirqd_CPU0
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    6 root       9   0     0    0     0 SW    0.0  0.0   0:01 kupdated
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 i2oevtd
    8 root       9   0     0    0     0 SW    0.0  0.0   0:00 i2oblock
    9 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreiserfsd
 6089 root       9   0     0    0     0 SW    0.0  0.0   0:00 eth0
10978 root       9   0     0    0     0 SW    0.0  0.0   0:00 rpciod
 1480 root       9   0     0    0     0 SW    0.0  0.0   0:00 lockd

- -- last top output --

- -- dmesg --

Linux version 2.4.15-grsec-1.8.9 (root@kryton) (gcc version 2.95.3 20010315 (release)) #1 Mon Nov 26 13:25:08 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000001000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=linux2415 ro root=1603
Initializing CPU#0
Detected 119.755 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 238.38 BogoMIPS
Memory: 12956k/16384k available (1750k kernel code, 3044k reserved, 462k data, 268k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 05
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfb740, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 2
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:pio, hdd:pio
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: SAMSUNG SCR-3232, ATAPI CD/DVD-ROM drive
hdc: QUANTUM BIGFOOT1280A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: 2511936 sectors (1286 MB) w/87KiB Cache, CHS=2492/16/63
hda: ATAPI 32X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hdc: [PTBL] [623/64/63] hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Loading I2O Core - (c) Copyright 1999 Red Hat Software
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O LAN OSM (C) 1999 University of Helsinki.
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139cp 10/100 PCI Ethernet driver v0.0.5 (Oct 19, 2001)
8139cp: pci dev 00:0a.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
8139cp: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.22
eth0: RealTek RTL8139 Fast Ethernet at 0xc180f000, 00:00:21:cd:8e:37, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139A'
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack (128 buckets, 1024 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (c)2000 Netfilter core team
registreing ipv6 mark target
FAT: bogus logical sector size 0
UMSDOS: msdos_read_super failed, mount aborted.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: checking transaction log (device 16:03) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 42 transactions in 20 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 268k freed
Adding Swap: 102812k swap-space (priority -1)
reiserfs: checking transaction log (device 16:05) ...
reiserfs: replayed 44 transactions in 26 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 16:06) ...
reiserfs: replayed 1 transactions in 19 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
grsec: setregid(rgid=2/egid=0) by (atd:23702) UID(2) EUID(0), parent (atd:25414) UID(0) EUID(2)
grsec: setregid(rgid=0/egid=2) by (atd:23702) UID(2) EUID(0), parent (init:1) UID(0) EUID(0)
grsec: setreuid(ruid=0/euid=2) by (atd:23702) UID(2) EUID(0), parent (init:1) UID(0) EUID(0)
eth0: no IPv6 routers present

- -- dmesg --

distro: slackware 8 with kernel 2.4.15 + grsecurity patch

but the panics already occured with the plain 2.4.5 kernel

i've just read the changelog of 2.4.16 and i hope that the 8139too driver
was the problem :)


best regards

Michael Kummer

- ---

Web: http://www.sprinter-sbg.at | Email: michael@kummer.cc
Lieferinger-Hauptstrasse 47 / B4 | A - 5020 Salzburg
Mobil: +43 664 3333995 | Tel: +43 662 825355 11

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8AkuQTOeKpVx8ESMRAj/5AJ9ZgfENJsX1CB4v6CQrLG7G0iRRfQCgvAOU
p3TzEaavzuEcYdxN1f0WzQ0=
=y9Hr
-----END PGP SIGNATURE-----

