Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTDKXXq (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTDKXWM (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:22:12 -0400
Received: from wooledge.org ([209.142.155.49]:62550 "HELO pegasus.wooledge.org")
	by vger.kernel.org with SMTP id S262502AbTDKXTt (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:19:49 -0400
Date: Fri, 11 Apr 2003 19:31:32 -0400
From: Greg Wooledge <greg@wooledge.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: NFS client hangs when X is running (2.4.20)
Message-ID: <20030411233132.GA15999@pegasus.wooledge.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: OpenBSD 3.2
X-www.distributed.net: 106 packets (106.00 stats units) [2,978,397 keys/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[1.] NFS client hangs when X is running (2.4.20)

[2.] The NFS client is running Linux 2.4.20 (but I also saw this same
problem on another system running 2.4.18).  The NFS server is running
OpenBSD 3.2.  Both are i386 systems.  I mount /home from the OpenBSD
system onto the Linux system with option "nolock".  Everything is
OK until I start X.  About 15 to 30 seconds after X starts, the NFS
mount hangs.  Any process which attempts to do anything to any file
on the NFS file system goes into catatonia and cannot be killed
(even with -9; ps shows 'D' for state).

This problem does not occur with any 2.2.x kernel.  I have tried building
2.4.20 with and without CONFIG_NFS_V3 enabled; same results.

[3.] Keywords: NFS client 2.4.20 OpenBSD XFree86 hang lock crash catatonic

[4.] Linux version 2.4.20 (root@griffon) (gcc version 2.95.4 20011002 (Debi=
an prerelease)) #1 Fri Apr 11 18:37:04 EDT 2003

[5.] nfs: server pegasus not responding, still trying
However, this is erroneous.  Pegasus (the OpenBSD box) responds
perfectly to ping, showmount -e, ssh and so on.  Any existing ssh
connections to pegasus continue working, even ones I started in an
rxvt window in the 15-30 second period when the NFS subsystem hadn't
locked up yet.  No other errors are reported.

[6.] mount /home; startx; sleep 30

[7.1] (Note: I modified Makefile to use gcc 2.95 instead of 3.2)
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.33-WIP
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.10
Modules Loaded         serial 3c59x

[7.2]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2000+
stepping        : 0
cpu MHz         : 1667.388
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3329.22

[7.3]
serial                 42436   0 (autoclean)
3c59x                  25040   1

[7.4]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : PCI device 1002:4966 (ATI Technologies Inc)
d000-d01f : Creative Labs SB Live! EMU10k1
d400-d407 : Creative Labs SB Live! MIDI/Game Port
d800-d87f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  d800-d87f : 00:0b.0
dc00-dc1f : VIA Technologies, Inc. USB
e000-e01f : VIA Technologies, Inc. USB (#2)
e400-e41f : VIA Technologies, Inc. USB (#3)
e800-e80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  e800-e807 : ide0
  e808-e80f : ide1
ec00-ecff : VIA Technologies, Inc. VT6102 [Rhine-II]

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00243dd0 : Kernel code
  00243dd1-002c3e23 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
c0000000-cfffffff : PCI device 1106:3189 (VIA Technologies, Inc.)
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : PCI device 1002:4966 (ATI Technologies Inc)
  d8000000-dfffffff : PCI device 1002:496e (ATI Technologies Inc)
e0000000-e00fffff : PCI Bus #01
  e0020000-e002ffff : PCI device 1002:4966 (ATI Technologies Inc)
  e0030000-e003ffff : PCI device 1002:496e (ATI Technologies Inc)
e0120000-e012007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
e0121000-e01210ff : VIA Technologies, Inc. USB 2.0
  e0121000-e01210ff : ehci-hcd
e0122000-e01220ff : VIA Technologies, Inc. VT6102 [Rhine-II]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5]
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Subsystem: ABIT Computer Corp.: Unknown device 1401
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW- AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D<n=
one>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [N=
ormal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e0000000-e00fffff
	Prefetchable memory behind bridge: d0000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
	Subsystem: Creative Labs: Unknown device 8065
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at d000 [size=3D32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
 0a)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at d400 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev=
 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size=3D128]
	Region 1: Memory at e0120000 (32-bit, non-prefetchable) [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UH=
CI])
	Subsystem: ABIT Computer Corp.: Unknown device 1401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at dc00 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UH=
CI])
	Subsystem: ABIT Computer Corp.: Unknown device 1401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 3
	Region 4: I/O ports at e000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UH=
CI])
	Subsystem: ABIT Computer Corp.: Unknown device 1401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 4: I/O ports at e400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20=
 [EHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at e0121000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Ma=
ster IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at e800 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev =
74)
	Subsystem: ABIT Computer Corp.: Unknown device 1401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec00 [size=3D256]
	Region 1: Memory at e0122000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Rad=
eon 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7197
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: I/O ports at c000 [size=3D256]
	Region 2: Memory at e0020000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=3D48 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW+ AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP- GART64- 64bit- FW- Rate=3D<no=
ne>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] =
(Secondary) (rev 01)
	Subsystem: PC Partner Limited: Unknown device 7196
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled] [size=3D128=
M]
	Region 1: Memory at e0030000 (32-bit, non-prefetchable) [disabled] [size=
=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

[7.6] cat: /proc/scsi/scsi: No such file or directory

[7.7] The NFS client is a Debian unstable system.
ii  nfs-common     1.0.3-1        NFS support files common to client and se=
rve
ii  portmap        5-2            The RPC portmapper

--=20
Greg Wooledge                  |   "Truth belongs to everybody."
greg@wooledge.org              |    - The Red Hot Chili Peppers
http://wooledge.org/~greg/     |

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (OpenBSD)

iD8DBQE+l1BUkAkqAYpL9t8RArtkAJ91S6fg4Q44Nv4jbk07zKBS4/NF1ACgj2Ow
zg0PeTuKvtjX+HZ9tKAtuiw=
=nGZD
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
