Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUFAFcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUFAFcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 01:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUFAFck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 01:32:40 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:38338 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S264891AbUFAFcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 01:32:32 -0400
Subject: Re: 2.6 kernel OOPs with Nomad MuVo MP3 player
From: Derek Witt <dwitt1@kc.rr.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1085816432.11120.18.camel@saiya-jin>
References: <1085816432.11120.18.camel@saiya-jin>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E+fu3Bvy0fn1p+2X225z"
Message-Id: <1086067934.11936.1.camel@saiya-jin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Jun 2004 00:32:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E+fu3Bvy0fn1p+2X225z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good morning all. I have noticed that my issue's already been resolved.=20
I upgraded to 2.6.7-rc2-bk1 and it works like a charm (with preempt and
deadline enabled). It no longer times out or is rendered read only.
:)

On Sat, 2004-05-29 at 02:40, Derek Witt wrote:
> Good morning.
>=20
> I am attempting to mount my Creative Nomad MuVo MP3 Player. However,
> every time I try to mount or copy to the drive, I constantly get a
> Kernel oops. I am currently running 2.6.6-rc1 under Gentoo 1.4. SuSE 9.0
> running vanilla 2.6.5  returns the same problem.
>=20
> My dump indicates a problem with usb-storage trying to preempt parts of
> itself.
>=20
> The included dump is during a copy attempt.
>=20
> I am quite puzzled by this.. I'm going to rebuild my kernel sans preempt
> and see what happens.
>=20
> Here's my information below.
>=20
> cat /proc/bus/usb/devices (for my Nomad):
>=20
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  4 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D041e ProdID=3D4106 Rev=3D 0.01
> S:  Manufacturer=3DCreative Tech
> S:  Product=3DNOMAD MuVo
> S:  SerialNumber=3D000000000000
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D100mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50
> Driver=3Dusb-storage
> E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>=20
>=20
> cat /proc/ioports:
>=20
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vga+
> 03e8-03ef : serial
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 5000-500f : 0000:00:07.4
> 6000-607f : 0000:00:07.4
> d000-d00f : 0000:00:07.1
> d400-d41f : 0000:00:07.2
>   d400-d41f : uhci_hcd
> d800-d81f : 0000:00:07.3
>   d800-d81f : uhci_hcd
> dc00-dc1f : 0000:00:0a.0
>   dc00-dc1f : EMU10K1
> e000-e007 : 0000:00:0a.1
> e400-e4ff : 0000:00:0b.0
>   e400-e4ff : 8139too
>=20
> cat /proc/interrupts:
>=20
>            CPU0
>   0:   89597648          XT-PIC  timer
>   1:      26427          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   3:     436611          XT-PIC  EMU10K1
>   4:          0          XT-PIC  acpi
>   8:          2          XT-PIC  rtc
>  10:    6019061          XT-PIC  nvidia
>  11:    1906902          XT-PIC  uhci_hcd, uhci_hcd, eth0
>  12:     229068          XT-PIC  i8042
>  14:     240778          XT-PIC  ide0
>  15:         38          XT-PIC  ide1
> NMI:          0
> LOC:   89597802
> ERR:        184
> MIS:          0
>=20
> lspci:
>=20
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
> PRO133x] (rev c4)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 8
>         Region 0: Memory at d8000000 (32-bit, prefetchable) [size=3D64M]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART6=
4-
> HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2
>                 Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit=
- FW-
> Rate=3Dx2
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
> MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: dc000000-ddffffff
>         Prefetchable memory behind bridge: d0000000-d7ffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40)
>         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:07.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc.
> VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Region 4: I/O ports at d000 [size=3D16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 16) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at d400 [size=3D32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 16) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at d800 [size=3D32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
> 40)
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin ? routed to IRQ 4
>         Capabilities: [68] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
>=20
>=20
>=20
> Derek J Witt,
dwitt1@kc.rr.com.
Derek J Witt,
dwitt1@kc.rr.com.


--=-E+fu3Bvy0fn1p+2X225z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvBTe2lgVX+zXThwRAkC9AJ44hCwwvo48uF9znJm1z5Jc599p0ACgj830
YwANjSwD5cKnmlAuI2mwEJY=
=ijWb
-----END PGP SIGNATURE-----

--=-E+fu3Bvy0fn1p+2X225z--

