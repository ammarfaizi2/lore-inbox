Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292748AbSCDWB7>; Mon, 4 Mar 2002 17:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292931AbSCDWBv>; Mon, 4 Mar 2002 17:01:51 -0500
Received: from [217.79.102.244] ([217.79.102.244]:1788 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S292748AbSCDWBl>; Mon, 4 Mar 2002 17:01:41 -0500
Subject: Re: sungem card fails to find it's mac address
From: Beezly <beezly@beezly.org.uk>
To: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1015277575.1961.12.camel@monkey>
In-Reply-To: <1015277575.1961.12.camel@monkey>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-l0sGVSL05/b+86/QA5AM"
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 22:00:42 +0000
Message-Id: <1015279242.1961.15.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l0sGVSL05/b+86/QA5AM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I don the dunce's hat.

I forgot to say what kernel I'm running;

monkey:/# uname -a
Linux monkey 2.4.19pre1 #1 Mon Feb 25 21:48:03 GMT 2002 i686 unknown


On Mon, 2002-03-04 at 21:32, Beezly wrote:
> Hi all,
>=20
> I've just been trying out a Sun Gigabit Ethernet card on my PC. As the
> sungem module loads it prints out:
>=20
> Mar  4 20:40:10 monkey kernel: sungem.c:v0.96 11/17/01 David S. Miller
> (davem@redhat.com)
> Mar  4 20:40:10 monkey kernel: PCI: Enabling device 00:0a.0 (0014 ->
> 0016)
> Mar  4 20:40:10 monkey kernel: PCI: Found IRQ 5 for device 00:0a.0
> Mar  4 20:40:10 monkey kernel: PCI: Sharing IRQ 5 with 00:0b.1
> Mar  4 20:40:10 monkey kernel: eth0: Sun GEM (PCI) 10/100/1000BaseT
> Ethernet 00:00:00:00:00:00=20
>=20
> and the card fails to establish a link with the switch (an extreme
> networks summit 48). If I then "encourage" the card to have a mac
> address (I used one stolen from a 3COM 3c905B!) the link is established
> straight away;
>=20
> (immediately after doing "ifconfig eth0 hw ether 00:10:5A:41:E6:14")
>=20
> Mar  4 21:06:27 monkey kernel: eth0: Link is up at 1000 Mbps,
> full-duplex.
> Mar  4 21:06:27 monkey kernel: eth0: PCS AutoNEG complete.
> Mar  4 21:06:27 monkey kernel: eth0: PCS link is now up.
> Mar  4 21:06:28 monkey kernel: eth0: Link is up at 1000 Mbps,
> full-duplex.
>=20
> After doing this, the card functions as expected, except I get a message
> to syslog around once every second saying;
>=20
> Mar  4 21:18:25 monkey kernel: eth0: Link is up at 1000 Mbps,
> full-duplex.
>=20
> I'm guess this could be the switch forcing a renegotiation every second
> and I may be able to turn it off - on the other hand, it could be useful
> information for someone;
>=20
> If any more info is needed please contact me ;)
>=20
> Also attached is the output of lspci -v
>=20
> monkey:/var/log# lspci -vv
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
> (rev 02)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 8033
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 8
> 	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=3D32M]
> 	Capabilities: [a0] AGP version 2.0
> 		Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2
> 		Command: RQ=3D0 SBA- AGP+ 64bit- FW+ Rate=3D<none>
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
> 	Memory behind bridge: d5000000-d65fffff
> 	Prefetchable memory behind bridge: d7f00000-e5ffffff
> 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 22)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 8033
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
>=20
> 00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
> (prog-if 8a [Master SecP PriP])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 4: I/O ports at d800 [size=3D16]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> (prog-if 00 [UHCI])
> 	Subsystem: Unknown device 0925:1234
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 9
> 	Region 4: I/O ports at d400 [size=3D32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> (prog-if 00 [UHCI])
> 	Subsystem: Unknown device 0925:1234
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 9
> 	Region 4: I/O ports at d000 [size=3D32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
> 30)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 8033
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin ? routed to IRQ 9
> 	Capabilities: [68] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
> 02)
> 	Subsystem: Hauppauge computer works Inc. WinTV/GO
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (4000ns min, 10000ns max)
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at d7000000 (32-bit, prefetchable) [size=3D4K]
>=20
> 00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
> 	Subsystem: Hauppauge computer works Inc. WinTV/GO
> 	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (1000ns min, 63750ns max)
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at d6800000 (32-bit, prefetchable) [disabled]
> [size=3D4K]
>=20
> 00:0a.0 Ethernet controller: Sun Microsystems Computer Corp. GEM (rev
> 01)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dslow >TAbort- <TAbort=
-
> <MAbort- >SERR- <PERR-
> 	Latency: 32 (16000ns min, 16000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: Memory at d4800000 (32-bit, non-prefetchable) [size=3D2M]
> 	Expansion ROM at <unassigned> [disabled] [size=3D1M]
>=20
> 00:0b.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
> NCR) 53c875 (rev 14)
> 	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device
> 1000
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 72 (4250ns min, 16000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: I/O ports at a400 [size=3D256]
> 	Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=3D256]
> 	Region 2: Memory at d3800000 (32-bit, non-prefetchable) [size=3D4K]
> 	Expansion ROM at <unassigned> [disabled] [size=3D64K]
>=20
> 00:0b.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly
> NCR) 53c875 (rev 14)
> 	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device
> 1000
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 72 (4250ns min, 16000ns max), cache line size 08
> 	Interrupt: pin B routed to IRQ 5
> 	Region 0: I/O ports at a000 [size=3D256]
> 	Region 1: Memory at d3000000 (32-bit, non-prefetchable) [size=3D256]
> 	Region 2: Memory at d2800000 (32-bit, non-prefetchable) [size=3D4K]
> 	Expansion ROM at <unassigned> [disabled] [size=3D64K]
>=20
> 00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
> 05)
> 	Subsystem: Creative Labs CT4850 SBLive! Value
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 5000ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at 9800 [size=3D32]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:0c.1 Input device controller: Creative Labs SB Live! (rev 05)
> 	Subsystem: Creative Labs Gameport Joystick
> 	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 0: I/O ports at 9400 [disabled] [size=3D8]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
> (rev 02)
> 	Subsystem: Promise Technology, Inc.: Unknown device 4d33
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: I/O ports at 9000 [size=3D8]
> 	Region 1: I/O ports at 8800 [size=3D4]
> 	Region 2: I/O ports at 8400 [size=3D8]
> 	Region 3: I/O ports at 8000 [size=3D4]
> 	Region 4: I/O ports at 7800 [size=3D64]
> 	Region 5: Memory at d2000000 (32-bit, non-prefetchable) [size=3D128K]
> 	Expansion ROM at <unassigned> [disabled] [size=3D64K]
> 	Capabilities: [58] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
> (rev a1) (prog-if 00 [VGA])
> 	Subsystem: CardExpert Technology: Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 248 (1250ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=3D16M]
> 	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=3D128M]
> 	Expansion ROM at d7ff0000 [disabled] [size=3D64K]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [44] AGP version 2.0
> 		Status: RQ=3D31 SBA- 64bit- FW+ Rate=3Dx1,x2
> 		Command: RQ=3D31 SBA- AGP+ 64bit- FW+ Rate=3D<none>
>=20
>=20


--=-l0sGVSL05/b+86/QA5AM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8g+6KXu4ZFsMQjPgRAijtAKDFJVA74udTVkUOTh8s93BiexZxngCfR8oj
iDBMYyiAcGOJb2pDf9Vw/jo=
=qtTo
-----END PGP SIGNATURE-----

--=-l0sGVSL05/b+86/QA5AM--
