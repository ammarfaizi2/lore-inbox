Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTJaNKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJaNKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:10:50 -0500
Received: from p62.246.105.71.tisdip.tiscali.de ([62.246.105.71]:2944 "EHLO
	dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S263299AbTJaNK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:10:26 -0500
Date: Fri, 31 Oct 2003 14:10:19 +0100
From: Thunder Anklin <thunder@keepsake.ch>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test*] Timer interrupts not fired at all? (With a remark to Framebuffers)
Message-ID: <20031031131019.GA780@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
X-Location: Dorndorf-Steudnitz, TH (Germany)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

I happened to notice that under Linux 2.6.0-test[1-9] timer interrupts
appear not to  be fired at all unless  another interrupt happens. This
has been shown by some weird behaviors:

1. sleeps on boot can take an  infinite amount of time, but if I press
   any key, the booting will continue at once.

2. If I call date on a console  when the PC is idle, each call to date
   will show exactly one second more, even if I waited ten seconds.

3. When I do something like playing ogg streams, the clock runs at its
   usual rate.

I didn't  see any of these problems  on Linux 2.4 or  FreeBSD 4.8, but
FreeBSD  5.* behaves  in a  strange way,  too: the  clock will  run at
double speed.

(Another  probably bad  thing: The  NVidia framebuffer  driver doesn't
appear to work  well for me: if I switch to  more than 800x600@85, the
monitor switches itself  off. Note, however, that 2.4  is working well
at 1024x768@100.)

thunder@dbintra:/tmp$ sudo lspci -vvv
Password:
00:00.0 Host bridge: ALi Corporation M1541 (rev 04)
	Subsystem: ALi Corporation ALI M1541 Aladdin V/V+ AGP System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=3D32M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=3D29 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D<no=
ne>

00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04) (p=
rog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e1000000-e1ffffff
	Prefetchable memory behind bridge: e5f00000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-i=
f 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e0800000 (32-bit, non-prefetchable) [size=3D4K]

00:03.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: ALi Corporation ALI M7101 Power Management Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

00:06.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodriv=
e (rev 01)
	Subsystem: ESS Technology Solo-1 Audio Adapter
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d800 [size=3D64]
	Region 1: I/O ports at d400 [size=3D16]
	Region 2: I/O ports at d000 [size=3D16]
	Region 3: I/O ports at b800 [size=3D4]
	Region 4: I/O ports at b400 [size=3D4]
	Capabilities: [c0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (r=
ev c3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:09.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev =
01)
	Subsystem: Tekram Technology Co.,Ltd. TRM-S1040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at b000 [size=3D256]
	Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C=
/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a800 [size=3D256]
	Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=3D32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
 01)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a000 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0d.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH =
A1 ISDN [Fritz] (rev 02)
	Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN =
Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=3D32]
	Region 1: I/O ports at 9800 [size=3D32]

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c1) (prog-if 8a [Mast=
er SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 9400 [size=3D16]

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Mod=
el 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at e6000000 (32-bit, prefetchable) [size=3D32M]
	Expansion ROM at e5ff0000 [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA- ITACoh- GART64- HTrans- 64bit=
- FW- AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D<no=
ne>

thunder@dbintra:/tmp$=20

				Thunder

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ol87ygQNIN66kP8RAtNgAJ9ZhyRuQEvNi0GCuM7nLAEfuSRH3gCgomzv
rx1HcvY24wF4Da3Oz+K4DMY=
=WB4m
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
