Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272739AbRIMDo3>; Wed, 12 Sep 2001 23:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRIMDoU>; Wed, 12 Sep 2001 23:44:20 -0400
Received: from static24-72-34-179.reverse.accesscomm.ca ([24.72.34.179]:15824
	"HELO zed.dlitz.net") by vger.kernel.org with SMTP
	id <S272739AbRIMDoK>; Wed, 12 Sep 2001 23:44:10 -0400
Date: Wed, 12 Sep 2001 21:44:30 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Roberto Jung Drebes <drebes@inf.ufrgs.br>, linux-kernel@vger.kernel.org
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel crash)
Message-ID: <20010912214430.A2866@zed.dlitz.net>
In-Reply-To: <a05100303b7c3a4283667@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <a05100303b7c3a4283667@[192.168.239.101]>
User-Agent: Mutt/1.3.20i
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID: 0xE272C3C3
X-PGP-Fingerprint: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2001 at 12:21:22PM +0100, Jonathan Morton wrote:
> >Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo KT13=
3A
> >chipset). The kernel I had (2.4.9) started crashing on boot with an
> >invalid page fault, usually right after starting init. I tryed a i686
> >kernel and noticed it works OK, so I recompiled my crashy kernel only
> >switching the processor type and it also worked. changed it back to
> >Athlon/K7/Duron and it starts crashing.
> >
> >Anyone else experiencing this?
>=20
> BINGO!
>=20
> This problem is known about, but this is the first report we've had=20
> of it on a Duron (as opposed to Athlon), and you've successfully=20
> tracked it down to the updated BIOS.
>=20
> We need the versions of your old and new BIOSes, as accurately as you=20
> can make it.

I don't have time to do a full oops trace right now (I've never done one
before, so it would take some time, and I am somewhat busy with school work
right now), but I will confirm that I have an AMD Thunderbird 1200MHz with
a KT133A board, and it works fine with CONFIG_MK6 set, but CONFIG_MK7 craps
out with an oops soon after init starts.  I'm running kernel 2.4.8
(including the stock emu10k1 drivers) patched with the Debian FreeS/WAN
patch (though those are modules, and are not actually being loaded).

My BIOS code is the newest available from my motherboard manufacturer (the
board is a Future Power FP-KT133A, whose specs are at:
http://www.futurepowerusa.com/products/FP-kt133.htm )

I suppose if anyone's really interested, I can allocate some time to report
more on this problem.  Ask away!

Anyway, here's my current /proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1200.017
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov =
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06

And lspci -vv:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev =
03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D15 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (p=
rog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	Memory behind bridge: d6000000-d7ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at d000 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 0=
7)
	Subsystem: Creative Labs: Unknown device 8061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at dc00 [size=3D32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at e000 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev =
10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400 [size=3D256]
	Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=3D256]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) =
(prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at d4000000 (32-bit, prefetchable) [size=3D32M]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=3D31 SBA- 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>


--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjugK54ACgkQ+Zi22OJyw8PUkACePan1Z6sL6o+JgMM99mpbjMY7
Xz0AnReVtgG0inekpHFwY8pnUUyK5G93
=BEwa
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
