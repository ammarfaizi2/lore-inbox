Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSKTJuO>; Wed, 20 Nov 2002 04:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbSKTJuN>; Wed, 20 Nov 2002 04:50:13 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:27658 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S264705AbSKTJuM>;
	Wed, 20 Nov 2002 04:50:12 -0500
Date: Wed, 20 Nov 2002 12:56:18 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Pavel Jan?k <Pavel@Janik.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
Message-ID: <20021120095618.GB319@pazke.ipt>
Mail-Followup-To: Pavel Jan?k <Pavel@Janik.cz>,
	linux-kernel@vger.kernel.org
References: <m3smxx1aaf.fsf@Janik.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <m3smxx1aaf.fsf@Janik.cz>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=92=D1=82=D1=80, =D0=9D=D0=BE=D1=8F 19, 2002 at 11:09:44 +0100, Pavel=
 Jan?k wrote:
> Hi,
>=20
> I have a PCI card with two serial ports on it. It has PLX Technology
> PCI9052 and HOLTEK HT6552IR chips. Pictures of that card are at
> http://www.janik.cz/tmp/pci9052/.
>=20
> lspci:
>=20
> 00:08.0 Network controller: PLX Technology, Inc. PCI <-> IOBus Bridge (re=
v 02)
> 	Subsystem: Unknown device d841:0200
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at e400b000 (32-bit, non-prefetchable) [size=3D128]
> 	Region 1: I/O ports at d400 [size=3D128]
> 	Region 2: I/O ports at d800 [size=3D8]
> 	Region 3: I/O ports at dc00 [size=3D8]
> 00: b5 10 50 90 03 00 80 02 02 00 80 02 08 00 00 00
> 10: 00 b0 00 e4 01 d4 00 00 01 d8 00 00 01 dc 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 41 d8 00 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
>=20
> Is this card supported? Tim?

First we need to know is it 8250 compatible. You need to make some
experiments with setserial to test compatibility.

For example:
setserial /dev/ttyS5 port=3D0xd800 irq=3D11

then try to open /dev/ttyS5 with minicom or other terminal program.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE921xCBm4rlNOo3YgRAh2CAJwPPXyB1A9Y15JiDGPQTiROAahk5QCfSFmc
ndzfJCsGACRuQYO+BTcEFT4=
=x2x6
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
