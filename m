Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTLRIzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTLRIzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:55:55 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:9680 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264238AbTLRIzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:55:46 -0500
Date: Thu, 18 Dec 2003 09:56:21 +0100
From: Arnaud Fontaine <arnaud@andesi.org>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.23
Message-ID: <20031218085621.GA8283@scrappy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I am using 2.4.23 kernel with no patchset. It was the first time i
install a linux distribution on this PC, so i can't tell you if it have
this Oops with an another version of the kernel. It looks to work fine=20
during 1 or 2 days until i have an weird Oops. I have rebooted the machine=
=20
after this but it appears again few days later and despite some reboot.

I haven't include the support for module loadable. I am using Debian
GNU/Linux Woody up to date.

Thanks for you help.
Arnaud Fontaine

-------------- ksymoops
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
c0138ff2
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[vfs_follow_link+26/332]    Not tainted
EFLAGS: 00010217
eax: 00000000   ebx: caaf5f8c   ecx: cba98288   edx: caaf5f8c
esi: 00000000   edi: 00000000   ebp: cbafc0e0   esp: caaf5ee4
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 800, stackpage=3Dcaaf5000)
Stack: caa3dc40 caaf4000 caaf5f8c cbafc0e0 c014add7 caaf5f8c 00000000
c0136dea=20
       caa3dc40 caaf5f8c cbafc0e0 caaf5f8c cb57d000 00000000 00000001
00000001=20
       00000001 cb57d00d caa3dc40 cb57d006 00000007 08733bbe c0136f56
c01370c7=20
Call Trace:    [proc_follow_link+27/32] [link_path_walk+1794/2132]
[path_walk+26/28] [path_lookup+27/36] [open_namei+101/1244]
Code: 80 3e 2f 0f 85 a5 00 00 00 53 e8 b7 d4 ff ff ba 00 e0 ff ff=20


>>ebx; caaf5f8c <END_OF_CODE+a840894/????>
>>ecx; cba98288 <END_OF_CODE+b7e2b90/????>
>>edx; caaf5f8c <END_OF_CODE+a840894/????>
>>ebp; cbafc0e0 <END_OF_CODE+b8469e8/????>
>>esp; caaf5ee4 <END_OF_CODE+a8407ec/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   80 3e 2f                  cmpb   $0x2f,(%esi)
Code;  00000003 Before first symbol
   3:   0f 85 a5 00 00 00         jne    ae <_EIP+0xae> 000000ae Before
first symbol
Code;  00000009 Before first symbol
   9:   53                        push   %ebx
Code;  0000000a Before first symbol
   a:   e8 b7 d4 ff ff            call   ffffd4c6 <_EIP+0xffffd4c6>
ffffd4c6 <END_OF_CODE+3fd47dce/????>
Code;  0000000f Before first symbol
   f:   ba 00 e0 ff ff            mov    $0xffffe000,%edx

--------------

# lspci -vvv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+
AGP System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e6000000 (32-bit, non-prefetchable)
[size=3D16M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=3D28 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [e0] #00 [0000]

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e6000000-e5ffffff
	Prefetchable memory behind bridge: e8000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
(prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (20000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e5800000 (32-bit, non-prefetchable)
[size=3D4K]

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power
Management Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev c3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:0b.0 VGA compatible controller: Trident Microsystems TGUI 9440 (rev
e3) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e5000000 (32-bit, non-prefetchable)
[size=3D2M]
	Region 1: Memory at e4800000 (32-bit, non-prefetchable)
[size=3D64K]
	Expansion ROM at 000c0000 [disabled] [size=3D64K]

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
(prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at d800 [size=3D16]

-------------- dmesg

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000000f00000 (usable)
 BIOS-e820: 0000000000f00000 - 0000000001000000 (reserved)
 BIOS-e820: 0000000001000000 - 000000000bffc000 (usable)
 BIOS-e820: 000000000bffc000 - 000000000bfff000 (ACPI data)
 BIOS-e820: 000000000bfff000 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49148
zone(0): 4096 pages.
zone(1): 45052 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3D2.4.23 ro root=3D305 ether=3D0,0,eth0
ether=3D0,0,eth1
Initializing CPU#0
Detected 200.457 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 399.76 BogoMIPS
Memory: 191092k/196592k available (1049k kernel code, 4092k reserved,
246k data, 260k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU:     After generic, caps: 0080a135 00000000 00000000 00000004
CPU:             Common caps: 0080a135 00000000 00000000 00000004
CPU: Cyrix 6x86MX 3x Core/Bus Clock stepping 06
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Cyrix ARR
PCI: PCI BIOS revision 2.10 entry at 0xf0560, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: Card '3Com 3C509B EtherLink III'
isapnp: Card '3Com 3C509B EtherLink III'
isapnp: 2 Plug & Play cards detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
FDC 0 is a post-1991 82077
eth0: 3c5x9 at 0x220, 10baseT port, address  00 60 97 7e 7e 0b, IRQ 10.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth1: 3c5x9 at 0x230, 10baseT port, address  00 60 97 7e 92 55, IRQ 11.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
ALI15X3: IDE controller at PCI slot 00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: ST320413A, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=3D38792/16/63
Partition check:
 hda: hda1 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (1535 buckets, 12280 max) - 292 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

--------------

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : 3c509 PnP
0230-023f : 3c509 PnP
02f8-02ff : serial(set)
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5c20-5c3f : ALi Corporation M7101 PMU
d800-d80f : ALi Corporation M5229 IDE
  d800-d807 : ide0
  d808-d80f : ide1

--------------

# cat /proc/cpuinfo
processor	: 0
vendor_id	: CyrixInstead
cpu family	: 6
model		: 2
model name	: 6x86MX 3x Core/Bus Clock
stepping	: 6
cpu MHz		: 200.458
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: yes
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu de tsc msr cx8 pge cmov mmx cyrix_arr ds_cpl est
cid
bogomips	: 399.76

--------------

# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-00efffff : System RAM
  00100000-002066c9 : Kernel code
  002066ca-002440c7 : Kernel data
00f00000-00ffffff : reserved
01000000-0bffbfff : System RAM
0bffc000-0bffefff : ACPI Tables
0bfff000-0bffffff : ACPI Non-volatile Storage
e4800000-e480ffff : Trident Microsystems TGUI 9440
e5000000-e51fffff : Trident Microsystems TGUI 9440
e5800000-e5800fff : ALi Corporation USB 1.1 Controller
e6000000-e6ffffff : ALi Corporation M1541
ffff0000-ffffffff : reserved

--------------

--=20
Arnaud Fontaine <arnaud@andesi.org> - http://www.andesi.org/
GnuPG Public Key available on pgp.mit.edu
Fingerprint: D792 B8A5 A567 B001 C342 2613 BDF2 A220 5E36 19D3

--
Future looks spotty.  You will spill soup in late evening.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/4Wu1vfKiIF42GdMRAjAcAKCElQ84y202UfLWceKCkw4ieZ2GCACfdQ3X
a55yIfUW5NhC6ThBwAF/xIg=
=Djtq
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
