Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313385AbSC2ID2>; Fri, 29 Mar 2002 03:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313386AbSC2IDU>; Fri, 29 Mar 2002 03:03:20 -0500
Received: from wsip68-15-171-164.no.no.cox.net ([68.15.171.164]:12808 "EHLO
	resonant.org") by vger.kernel.org with ESMTP id <S313385AbSC2IDG>;
	Fri, 29 Mar 2002 03:03:06 -0500
Date: Fri, 29 Mar 2002 02:03:05 -0600
From: Zed Pobre <zed@resonant.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: invalid operand 0000 (2.4.19-pre2, P2-266 SMP)
Message-ID: <20020329080305.GA16625@resonant.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(I wrote this shortly after I had the crash, and then got busy for a
few weeks when my first attempt to subscribe to the list failed.  I
hope it is still useful.)

[1.] Summary

My window manager (enlightenment) crashed out on me, and left this in
the logs.  I've treated it as an oops, since I'm not sure exactly what
it is.  This is my first time submitting an oops report, so please let
me know if I'm handling any part of this incorrectly.


[2.] Description

The damage from the crash was the loss of the window manager (which
could not be restarted), an inability to use ps (it froze on me after
displaying one process), some miscellaneous other breakage (gnome
panel stopped working as well, though the panel stayed up and
clickable).

The crash occurred while I was cloning a (6GB or 10GB depending on
whether you asked the ext2 or the reiser side -- still trying to
figure out if that's related) filesystem from an ext2 partition to a
reiserfs partition via "find . -xdev | cpio -pum".  That command was
being executed on the console (I saw the kernel message before I
realized I had lost my window manager in X11).  The copy apparantly
completed successfully.  I haven't yet rebooted to find out for sure.


[3.] keywords: kernel


[4.] Version

Linux version 2.4.19-pre2 (root@singularity) (gcc version 2.95.4 20011002 (=
Debian prerelease)) #1 SMP Fri Mar 8 20:56:42 CST 2002


[5.] ksymoops was run on the same machine with no options set shortly
     after the crash, but it still issued warnings.  I'm not sure why, or
     if I need to do something different.

ksymoops 2.4.3 on i686 2.4.19-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre2/ (default)
     -m /boot/System.map-2.4.19-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base say=
s c0239040, System.map says c015a890.  Ignoring ksyms_base entry
Mar  9 11:54:09 resonant kernel: invalid operand: 0000
Mar  9 11:54:09 resonant kernel: CPU:    1
Mar  9 11:54:09 resonant kernel: EIP:    0010:[do_mmap_pgoff+589/1216]    N=
ot tainted
Mar  9 11:54:09 resonant kernel: EFLAGS: 00010a86
Mar  9 11:54:09 resonant kernel: eax: c2172095   ebx: c2173f5c   ecx: c4181=
828   edx: c4181830
Mar  9 11:54:09 resonant kernel: esi: c2173f60   edi: c2173f64   ebp: c75a3=
400   esp: c2173f34
Mar  9 11:54:09 resonant kernel: ds: 0018   es: 0018   ss: 0018
Mar  9 11:54:09 resonant kernel: Process gkrellm (pid: 2111, stackpage=3Dc2=
173000)
Mar  9 11:54:09 resonant kernel: Stack: b80ce2c1 c2172075 c2172000 00000022=
 00000000 00000000 00000001 00000000
Mar  9 11:54:09 resonant kernel:        00000073 c32f1890 c4181810 c4181830=
 c4181828 c010d19e 00000000 401a2000
Mar  9 11:54:09 resonant kernel:        00001000 00000003 00000022 00000000=
 c2172000 08165e10 00001000 bffff38c
Mar  9 11:54:09 resonant kernel: Call Trace: [old_mmap+238/304] [system_cal=
l+51/64]=20
Mar  9 11:54:09 resonant kernel: Code: ff ff 21 e0 03 54 24 38 3b 90 28 03 =
00 00 77 d7 8b 44 24 18=20
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff                        (bad) =20
Code;  00000000 Before first symbol
   1:   ff 21                     jmp    *(%ecx)
Code;  00000002 Before first symbol
   3:   e0 03                     loopne 8 <_EIP+0x8> 00000008 Before first=
 symbol
Code;  00000004 Before first symbol
   5:   54                        push   %esp
Code;  00000006 Before first symbol
   6:   24 38                     and    $0x38,%al
Code;  00000008 Before first symbol
   8:   3b 90 28 03 00 00         cmp    0x328(%eax),%edx
Code;  0000000e Before first symbol
   e:   77 d7                     ja     ffffffe7 <_EIP+0xffffffe7> ffffffe=
6 <END_OF_CODE+37784064/????>
Code;  00000010 Before first symbol
  10:   8b 44 24 18               mov    0x18(%esp,1),%eax

Mar  9 11:54:09 resonant kernel:  invalid operand: 0000
Mar  9 11:54:09 resonant kernel: CPU:    1
Mar  9 11:54:09 resonant kernel: EIP:    0010:[do_mmap_pgoff+589/1216]    N=
ot tainted
Mar  9 11:54:09 resonant kernel: EFLAGS: 00010286
Mar  9 11:54:09 resonant kernel: eax: c00580f5   ebx: c0059f40   ecx: c24ec=
888   edx: c24ec890
Mar  9 11:54:09 resonant kernel: esi: c0059f44   edi: c0059f48   ebp: c1baf=
0e0   esp: c0059f18
Mar  9 11:54:09 resonant kernel: ds: 0018   es: 0018   ss: 0018
Mar  9 11:54:09 resonant kernel: Process enlightenment (pid: 2100, stackpag=
e=3Dc0059000)
Mar  9 11:54:09 resonant kernel: Stack: b80ce2c1 c0058075 c0058000 00000000=
 00000a00 05ad0000 00000001 00000000
Mar  9 11:54:09 resonant kernel:        000000fb c7f6b480 c24ec870 c24ec890=
 c24ec888 c01cd87c c53dd270 40080000
Mar  9 11:54:09 resonant kernel:        00001000 00000003 00000001 00000000=
 00000000 00000000 00000000 bfffd6dc
Mar  9 11:54:09 resonant kernel: Call Trace: [sys_shmat+444/672] [sys_ipc+4=
18/640] [math_state_restore+25/64] [system_call+51/64]=20
Mar  9 11:54:09 resonant kernel: Code: ff ff 21 e0 03 54 24 38 3b 90 28 03 =
00 00 77 d7 8b 44 24 18=20

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff                        (bad) =20
Code;  00000000 Before first symbol
   1:   ff 21                     jmp    *(%ecx)
Code;  00000002 Before first symbol
   3:   e0 03                     loopne 8 <_EIP+0x8> 00000008 Before first=
 symbol
Code;  00000004 Before first symbol
   5:   54                        push   %esp
Code;  00000006 Before first symbol
   6:   24 38                     and    $0x38,%al
Code;  00000008 Before first symbol
   8:   3b 90 28 03 00 00         cmp    0x328(%eax),%edx
Code;  0000000e Before first symbol
   e:   77 d7                     ja     ffffffe7 <_EIP+0xffffffe7> ffffffe=
6 <END_OF_CODE+37784064/????>
Code;  00000010 Before first symbol
  10:   8b 44 24 18               mov    0x18(%esp,1),%eax


2 warnings issued.  Results may not be reliable.


[6.] Script to reproduce

I cannot reproduce this on command.


[7.] Environment
[7.1] ver_linux

Linux moebius 2.4.19-pre2 #1 SMP Fri Mar 8 20:56:42 CST 2002 i686 unknown
=20
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.25
reiserfsprogs          3.x.0j
cardmgr: not found
pppd: not found
isdnctrl: not found
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         soundcore nls_iso8859-15 nls_cp437


[7.2] cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 3
cpu MHz		: 265.915
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips	: 530.84

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 3
cpu MHz		: 265.915
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips	: 530.84


[7.3] modules

soundcore               3972   0 (autoclean)
nls_iso8859-15          3392   3 (autoclean)
nls_cp437               4384   3 (autoclean)


[7.4] ioports, iomem

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
e800-e8ff : Adaptec AIC-7881U
ec00-ecff : 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5
ee80-eebf : 3Com Corporation 3c905 100BaseTX [Boomerang]
  ee80-eebf : 00:0e.0
ffa0-ffaf : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-002d18d1 : Kernel code
  002d18d2-0035037f : Kernel data
e8000000-efffffff : 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5
f8000000-fbffffff : 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5
febef000-febeffff : Adaptec AIC-7881U
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffe0000-ffffffff : reserved


[7.5] lspci

00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 0=
1)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (pr=
og-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=3D16]

00:0b.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 4 / Voodoo=
 5 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 0003
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=3D64M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
	Region 2: I/O ports at ec00 [size=3D256]
	Expansion ROM at febf0000 [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0d.0 SCSI storage controller: Adaptec AIC-7881U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at e800 [size=3D256]
	Region 1: Memory at febef000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at febd0000 [disabled] [size=3D64K]

00:0e.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at ee80 [size=3D64]
	Expansion ROM at febc0000 [disabled] [size=3D64K]


[7.6] scsi

Attached devices: none



--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6

iQEVAwUBPKQfuB0207zoJUw5AQFsbQf+Pc/yDAdhJfX2CVUqWjpvV6f2s7ao3Bj9
4XPUGw6Fu/jpd+HE7UynBkvUlJgQO2u/mHRR7vWVprRPUVggwqM2Vf/TiLisYLXd
UVVT/COO6LLGZim9BFHsTJ2kiJhbPNSvKXcepyUC5dpLkGAuVQPAJgw3czX+wwuE
PEMz0LwxrtqAOpCc++KkPAXIdeyccYkXG7IiIWyvCW3Ougpldb8rHbiQUgxE9BYr
z5yQNYwgSn9jL5jLGu4kSSw1tl27rXrtdFtk2L99VqhTHAXi/YQO3xRr2itvYN3I
le8anUPlTgDm4DI0uMuPbgt7BXxwkXqG0agS4VGqLaMWCx7xNCwA/g==
=pAui
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
