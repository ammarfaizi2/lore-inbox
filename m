Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264631AbUEDVOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264631AbUEDVOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUEDVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:14:53 -0400
Received: from legolas.restena.lu ([158.64.1.34]:31189 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264631AbUEDVO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:14:28 -0400
Subject: RE: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040504203840.GA2102@tesore.local>
References: <20040504203840.GA2102@tesore.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5+2TtRLZbz5+vSLtxVFW"
Message-Id: <1083705265.696.5.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 23:14:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5+2TtRLZbz5+vSLtxVFW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-05-04 at 22:38, Jesse Allen wrote:
> Allen Martin wrote:
> > This will require changing the value for register at bus:0 dev:0 func:0
> > offset 6c.
> >
> > Chip   Current Value   New Value
> > C17       1F0FFF01     1F01FF01
> > C18D      9F0FFF01     9F01FF01
> >
> > Northbridge chip version may be determined by reading the PCI revision
> > ID (offset 8) of the host bridge at bus:0 dev:0 func:0.  C1 or greater
> > is C18D.
>=20
> I believe I have confirmed that the Shuttle AN35N BIOS indeed has this fi=
x as
> of Dec 5th 03 version.
>=20
> lspci -xxx -vvv
> 00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)=20
> (rev c1)
> ...
> 60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 01 9f

I can confirm on my Asus A7N8X Deluxe v2.0 with BIOS 1007 (the latest),
that its reporting

60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 0f 9f

So, it looks like it needs the new value as per the note.

I haven't applied that patch that was posted yesterday, am awaiting more
reaction from Len, Ross and all.

Craig

--=-5+2TtRLZbz5+vSLtxVFW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmAewi+pIEYrr7mQRAjn7AJ9aziqlMe9mu7cRzmJ2aLy12R8FXACggEcm
JaNC2eSOUnKHGSNhL51KR5w=
=oal1
-----END PGP SIGNATURE-----

--=-5+2TtRLZbz5+vSLtxVFW--

