Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSLAHHw>; Sun, 1 Dec 2002 02:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSLAHHw>; Sun, 1 Dec 2002 02:07:52 -0500
Received: from viola.sinor.ru ([217.70.106.9]:42973 "EHLO viola.sinor.ru")
	by vger.kernel.org with ESMTP id <S261492AbSLAHHs>;
	Sun, 1 Dec 2002 02:07:48 -0500
Date: Sun, 1 Dec 2002 13:16:12 +0600
From: "Andrey R. Urazov" <coola@ngs.ru>
To: linux-kernel@vger.kernel.org
Subject: a bug in autofs
Message-ID: <20021201071612.GA936@ktulu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-public-key: pub 1024D/02B49FF2
X-PGP-fingerprint: A1CE D50E 0CF3 C0EF BA35  CBEC 87D7 4A2B 02B4 9FF2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm constantly observing a bug in autofs.

[1.] One line summary of the problem:   =20
the system hangs when some operations are performed on autounted volumes

[2.] Full description of the problem/report:
I observed the problem in 2 forms:

1) when I run XMMS and its playlist contains entries laying somewhere
   under /misc/cdrom but there is no cd in the drive or the cd in the
   drive is not the one whose entries are stored in the playlist, it
   takes about half a minute for the system to hang. Before it hangs
   absolutely I get numerous messages "invalid seek on /dev/hdc" on my
   virtual consoles

2) under /misc/summer there resides an ntfs volume with thousands of
   files. And when I run=20

        find /misc/summer

   the system becames unusable after some amount of files is scanned.
   Usually it just hangs. But one time "find" terminated with the
   segmentation fault and then after 5 seconds or so the system hung.

The problem does not existed if the volumes are mounted through "mount".
Only automounting causes problems.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, modules, automounting, autofs


[4.] Kernel version (from /proc/version):

Linux version 2.4.20 (coola@ktulu) (gcc version 3.2 20020903 (Red Hat
Linux 8.0 3.2-7)) #2 Sun Dec 1 12:48:50 NOVT 2002

the problem persists on both 2.4.19 and 2.4.20 and with both versions of
autofs (autofs and autofs4)


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)


[6.] A small shell script or example program which triggers the problem
     (if possible)

find <path to an automounted volume with large amount of files>



[7.] Environment

doesn't matter, I reckon


[7.1.] Software (add the output of the ver_linux script here)

Linux ktulu 2.4.20 #2 Sun Dec 1 12:48:50 NOVT 2002 i686 athlon i386
GNU/Linux
=20
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
PPP                    2.4.1
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         nls_cp866 vfat fat maestro3 ac97_codec soundcore
af_packet


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1340.225
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2673.86



[7.3.] Module information (from /proc/modules):

nls_cp866               4604   0 (autoclean)
vfat                   12908   0 (autoclean)
fat                    38776   0 (autoclean) [vfat]
maestro3               30544   0 (autoclean)
ac97_codec             13576   0 (autoclean) [maestro3]
soundcore               6500   2 (autoclean) [maestro3]
af_packet              15176   0 (autoclean)


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
d800-d81f : 3Com Corporation 3c590 10BaseT [Vortex]
dc00-dcff : ESS Technology ES1988 Allegro-1
  dc00-dcff : maestro3
ff00-ff0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  ff00-ff07 : ide0
  ff08-ff0f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00270240 : Kernel code
  00270241-002ca3bf : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
dec00000-decfffff : PCI Bus #01
df000000-df7fffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
dfe00000-dfefffff : PCI Bus #01
dfffc000-dfffffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
=20
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT333 AGP] (prog-if
   00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge: dec00000-decfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
   [Millennium] (rev 01) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dfffc000 (32-bit, non-prefetchable)
[size=3D16K]
        Region 1: Memory at df000000 (32-bit, prefetchable) [size=3D8M]
        Expansion ROM at dffe0000 [disabled] [size=3D64K]

00:0a.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1
   (rev 10)
        Subsystem: ESS Technology ESS Allegro-1 Audiodrive
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d800 [size=3D32]
        Expansion ROM at dffd0000 [disabled] [size=3D64K]

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
   IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 14
        Region 4: I/O ports at ff00 [size=3D16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: NR-7900A         Rev: 1.23
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem (please
       look in /proc and include all information that you think to be
relevant):


[X.] Other notes, patches, fixes, workarounds:

workaround is to use manual mounting instead of automounting





Best regards,
  Andrey Urazov
--=20
Phasers locked on target, Captain.
--
dimanche 01 d=E9cembre, 2002, 13:00:36 +0600 - Andrey R. Urazov (mailto:coo=
la@ngs.ru)


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE96bc7h9dKKwK0n/IRAj/JAJsFCFEQLfv8ecmf7M++HyA1cfcenQCgyLhy
R8BJoQnfPTGWKLXYXQhlAQk=
=Njnp
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
