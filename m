Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWJJACg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWJJACg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 20:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWJJACg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 20:02:36 -0400
Received: from meleeweb.net ([88.191.21.131]:61400 "EHLO meleeweb.net")
	by vger.kernel.org with ESMTP id S964848AbWJJACe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 20:02:34 -0400
Date: Tue, 10 Oct 2006 02:02:17 +0200
From: Beber <beber@meleeweb.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Matthias Hentges <oe@hentges.net>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Message-ID: <20061010020217.39786413@meathook.meleeweb.net>
In-Reply-To: <20061008092001.0c83a359@localhost.localdomain>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	<451C5599.80402@garzik.org>
	<20060928161956.5262e5d3@freekitty>
	<1159930628.16765.9.camel@mhcln03>
	<20061003202643.0e0ceab2@localhost.localdomain>
	<1160250529.4575.7.camel@mhcln03>
	<1160314905.4575.21.camel@mhcln03>
	<20061008092001.0c83a359@localhost.localdomain>
Organization: Meleeweb
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Jabber-ID: beber@meleeweb.net
X-Face: G.PnE1JeFGEC4kW,1Gg-k/-;}nX&j:l]${BcY@![=Ca6vO+O,xjm@N!Si\*U4i\@yfWTM.T~]H4|]_"PNHPT7nw,[FNgOe9!U46GnbzUY>5}G@TUhZAB7g2nS'''4o8u-,:CZ&aL<^Wjv!o_lD;qZBuv*zx_-1bBw0T6+dxC]/pnQsu,VCIR2,Kq),~rwyHskyTg}0X4+qBH'($d_47W}x?MU\|/^3"6*[q`T_@(l9DX!03:vha_[!/YMZ^$0_>.Fk=~m[taczSt%n/=}'S682+Uwy1/uQ[=[36&R$J*OFnDJ`L]HMW,n#"<voB8|5scfSOPlb~08H6i3[F
X-Operating-System: Gentoo Base System version 1.12.5
X-GPG-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x39BB8CF4
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zo4WoDAekg=f1n/et2SDAT";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Spam-Score: -1.7 (-)
X-Spam-Report: Spam detection software, running on Meleeweb, has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	webmaster@meleeweb.net for details.
	Content analysis details:   (-1.7 points, 2.6 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 TW_BF                  BODY: Odd Letter Triples with BF
	0.1 TW_XF                  BODY: Odd Letter Triples with XF
	0.1 TW_VV                  BODY: Odd Letter Triples with VV
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.7 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zo4WoDAekg=f1n/et2SDAT
Content-Type: multipart/mixed; boundary=MP_PXpxqjJvMaTEWzM5F0gxOe2

--MP_PXpxqjJvMaTEWzM5F0gxOe2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Sun, 8 Oct 2006 09:20:01 -0700, Stephen Hemminger
<shemminger@osdl.org> a =C3=A9crit :

> On Sun, 08 Oct 2006 15:41:45 +0200
> Matthias Hentges <oe@hentges.net> wrote:
>=20
> > Hi Stephen,
> >=20
> > I believe I have identified the problem. The freeze only happens when
> > your debug patch to work around sky2 PCIe error messages is applied.
> > Without your patch (attached) I get _tons_ of error messages and the NIC
> > dies every few seconds / minutes (reproduceable!), but the system
> > recovers just fine from a NIC crash.
> >=20
> > I have verified this behavior (works fine w/o debug patch, freezes with
> > patch applied) with:
> > - 2.6.19-rc1-git4=20
> > - 2.6.18-git something=20
> > - 2.6.18-mm3
> >  =20
>=20
> Does 2.6.18 work?
>=20
> What is the PCI config of the device (lspci -vvvx)?
>=20
> What is the chip version (dmesg | grep sky2)?

I've got the same issue here since a while (See Message-ID:
<1d7ea2d50604181027o55d9cc43i5a7d912e388387a4@mail.gmail.com> from 18 Apr 2=
006)

I steel get freeze (with non tainted kernel) and getting these messages
at boot :

~ % dmesg | grep -i sky
sky2 v1.7 addr 0xff3fc000 irq 233 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:15:f2:a9:6a:65
sky2 0000:02:00.0: No interrupt was generated using MSI, switching to INTx =
mode. Please report this failure to the PCI maintainer and include system c=
hipset information.
sky2 eth0: enabling interface
sky2 eth0: disabling interface

lspci -vvvx attached

--=20
Beber - E-Mail / Jabber (+GMail) : beber_AT_meleeweb.net
http://www.meleeweb.net

--MP_PXpxqjJvMaTEWzM5F0gxOe2
Content-Type: text/x-log; name=lspci.log
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=lspci.log

00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <access denied>
00: de 10 f4 02 06 01 b0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00

00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: de 10 fa 02 00 01 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: de 10 fe 02 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: de 10 f8 02 00 01 a0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
00: de 10 f9 02 06 01 a0 00 a2 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <access denied>
00: de 10 ff 02 06 01 b0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00

00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: de 10 7f 02 02 01 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 81d2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: de 10 7e 02 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 d2 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (pro=
g-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: ff100000-ff2fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>
00: de 10 fc 02 07 04 10 00 a1 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 71 71 00 00
20: 10 ff 20 ff f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00

00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (pro=
g-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: ff300000-ff3fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>
00: de 10 fd 02 07 04 10 00 a1 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 81 81 00 00
20: 30 ff 30 ff f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00

00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (pro=
g-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 00009000-0000bfff
	Memory behind bridge: ff400000-ff4fffff
	Prefetchable memory behind bridge: 00000000cff00000-00000000dfe00000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <access denied>
00: de 10 fb 02 07 04 10 00 a1 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 91 b1 00 00
20: 40 ff 40 ff f1 cf e1 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 0a 00

00:09.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev =
a4)
	Subsystem: ASUSTeK Computer Inc. Unknown device 815a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <access denied>
00: de 10 5e 00 06 00 b0 00 a4 00 80 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 5a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a4)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
00: de 10 50 00 0f 00 a0 00 a4 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 5a 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ec00 [size=3D32]
	Region 4: I/O ports at 0600 [size=3D64]
	Region 5: I/O ports at 0700 [size=3D64]
	Capabilities: <access denied>
00: de 10 52 00 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 01 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 06 00 00 01 07 00 00 00 00 00 00 43 10 5a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 01

00:0b.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (p=
rog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ff6fe000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <access denied>
00: de 10 5a 00 07 00 b0 00 a2 10 03 0c 00 00 80 00
10: 00 e0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 5a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 01

00:0b.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a4) (p=
rog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 66
	Region 0: Memory at ff6ffc00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: <access denied>
00: de 10 5b 00 06 00 b0 00 a4 20 03 0c 00 00 80 00
10: 00 fc 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 5a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 02 03 01

00:0d.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio C=
ontroller (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 74
	Region 0: I/O ports at e400 [size=3D256]
	Region 1: I/O ports at e000 [size=3D256]
	Region 2: Memory at ff6fd000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <access denied>
00: de 10 59 00 07 00 b0 00 a2 00 01 04 00 00 00 00
10: 01 e4 00 00 01 e0 00 00 00 d0 6f ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 2a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 02 05

00:0f.0 IDE interface: nVidia Corporation CK804 IDE (rev f3) (prog-if 8a [M=
aster SecP PriP])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at ffa0 [size=3D16]
	Capabilities: <access denied>
00: de 10 53 00 05 00 b0 00 f3 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 43 10 5a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01

00:10.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev =
f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. Unknown device 815a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 225
	Region 0: I/O ports at dc00 [size=3D8]
	Region 1: I/O ports at d880 [size=3D4]
	Region 2: I/O ports at d800 [size=3D8]
	Region 3: I/O ports at d480 [size=3D4]
	Region 4: I/O ports at d400 [size=3D16]
	Region 5: Memory at ff6fc000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <access denied>
00: de 10 54 00 07 00 b0 00 f3 85 01 01 00 00 00 00
10: 01 dc 00 00 81 d8 00 00 01 d8 00 00 81 d4 00 00
20: 01 d4 00 00 00 c0 6f ff 00 00 00 00 43 10 5a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01

00:12.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 0=
1 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff500000-ff5fffff
	Prefetchable memory behind bridge: 50000000-500fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: de 10 5c 00 07 00 a0 00 a2 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 40 c0 c0 80 22
20: 50 ff 50 ff 00 50 00 50 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 06

00:13.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ff6fb000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at d080 [size=3D8]
	Capabilities: <access denied>
00: de 10 57 00 07 00 b0 00 a3 00 80 06 00 00 00 00
10: 00 b0 6f ff 81 d0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 41 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 01 14

00:16.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if =
00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>
00: de 10 5d 00 04 04 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 05 05 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00

00:17.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if =
00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <access denied>
00: de 10 5d 00 04 04 10 00 a3 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 06 06 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Hyp=
erTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Capabilities: <access denied>
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Add=
ress Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRA=
M Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Mis=
cellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid I=
I Controller (rev 01)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8177
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ff2ffc00 (64-bit, non-prefetchable) [size=3D128]
	Region 2: Memory at ff2f8000 (64-bit, non-prefetchable) [size=3D16K]
	Region 4: I/O ports at 7c00 [size=3D128]
	Expansion ROM at ff200000 [disabled] [size=3D512K]
	Capabilities: <access denied>
00: 95 10 32 31 07 01 10 00 01 00 04 01 10 00 00 00
10: 04 fc 2f ff 00 00 00 00 04 80 2f ff 00 00 00 00
20: 01 7c 00 00 00 00 00 00 00 00 00 00 43 10 77 81
30: 00 00 20 ff 54 00 00 00 00 00 00 00 0a 01 00 00

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gi=
gabit Ethernet Controller (rev 15)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet controll=
er PCIe (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 233
	Region 0: Memory at ff3fc000 (64-bit, non-prefetchable) [size=3D16K]
	Region 2: I/O ports at 8800 [size=3D256]
	Expansion ROM at ff3c0000 [disabled] [size=3D128K]
	Capabilities: <access denied>
00: ab 11 62 43 07 01 10 00 15 00 00 02 10 00 00 00
10: 04 c0 3f ff 00 00 00 00 01 88 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 42 81
30: 00 00 3c ff 48 00 00 00 00 00 00 00 0a 01 00 00

03:00.0 VGA compatible controller: ATI Technologies Inc R430 [Radeon X800 (=
PCIE)] (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 0970
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0000000 (64-bit, prefetchable) [size=3D128M]
	Region 2: Memory at ff4f0000 (64-bit, non-prefetchable) [size=3D64K]
	Region 4: I/O ports at b000 [size=3D256]
	Expansion ROM at ff4c0000 [disabled] [size=3D128K]
	Capabilities: <access denied>
00: 02 10 4f 55 07 00 10 00 00 00 00 03 10 00 80 00
10: 0c 00 00 d0 00 00 00 00 04 00 4f ff 00 00 00 00
20: 01 b0 00 00 00 00 00 00 00 00 00 00 62 14 70 09
30: 00 00 4c ff 50 00 00 00 00 00 00 00 0a 01 00 00

03:00.1 Display controller: ATI Technologies Inc R430 [Radeon X800 (PCIE) S=
econdary]
	Subsystem: Micro-Star International Co., Ltd. Unknown device 0971
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at ff4e0000 (64-bit, non-prefetchable) [size=3D64K]
	Capabilities: <access denied>
00: 02 10 6f 55 07 00 10 00 00 00 80 03 10 00 00 00
10: 04 00 4e ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 71 09
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 00 00

04:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C=
/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 58
	Region 0: I/O ports at c800 [size=3D256]
	Region 1: Memory at ff5ffc00 (32-bit, non-prefetchable) [size=3D256]
	Expansion ROM at 50000000 [disabled] [size=3D64K]
	Capabilities: <access denied>
00: ec 10 39 81 07 01 90 02 10 00 00 02 00 40 00 00
10: 01 c8 00 00 00 fc 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 5e ff 50 00 00 00 00 00 00 00 0a 01 20 40

04:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000=
 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ff5ff000 (32-bit, non-prefetchable) [size=3D2K]
	Region 1: Memory at ff5f8000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: <access denied>
00: 4c 10 23 80 16 01 10 02 00 10 00 0c 10 40 00 00
10: 00 f0 5f ff 00 80 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 8b 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 02 04


--MP_PXpxqjJvMaTEWzM5F0gxOe2--

--Sig_/Zo4WoDAekg=f1n/et2SDAT
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFKuMJibjJUzm7jPQRAlIJAKCNbM/4d39dDEi5ECSJAnl0/kBSqgCfT2gd
dAcYw8CIOMs2gfcyGHX8/+s=
=FUg9
-----END PGP SIGNATURE-----

--Sig_/Zo4WoDAekg=f1n/et2SDAT--
