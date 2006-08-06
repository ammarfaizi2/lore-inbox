Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWHFKbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWHFKbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 06:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHFKbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 06:31:46 -0400
Received: from lug-owl.de ([195.71.106.12]:35260 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750834AbWHFKbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 06:31:45 -0400
Date: Sun, 6 Aug 2006 12:31:43 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Om N." <xhandle@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: writing portable code based on BITS_PER_LONG?
Message-ID: <20060806103143.GR20586@lug-owl.de>
Mail-Followup-To: "Om N." <xhandle@gmail.com>,
	linux-kernel@vger.kernel.org
References: <6de39a910608052316x37ae7268j5ea18b6ea26219c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/YnR2r17TIEndSCI"
Content-Disposition: inline
In-Reply-To: <6de39a910608052316x37ae7268j5ea18b6ea26219c5@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/YnR2r17TIEndSCI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-08-05 23:16:29 -0700, Om N. <xhandle@gmail.com> wrote:
> I am trying to port a driver written for IA32. This is a pci driver
> and has a chipset doing PCI <-> local bus data transfer, where local
> bus is 16 bit. So a number of values are converted by right/left
> shifting by 16 bits.
>=20
> Now that I am doing porting, I would like to make it fully portable
> across AMD64 and IA32. What is the best method for this? Should I do
> something like,
>=20
> #if  BITS_PER_LONG =3D 64
> shiftwidth =3D 48
> #else if BITS_PER_LONG =3D 32
> shiftwidth =3D 16
> #endif

I'd probably write some macros that access the parts of the longs you
want to have/set and put these into some header file.

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
Signature of:                  Tr=C3=A4ume nicht von Dein Leben: Lebe Deine=
n Traum!
the second  :

--/YnR2r17TIEndSCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE1cUPHb1edYOZ4bsRAl7XAKCM63QpnBhaB/zljvVo69riSMEuNACfc2+n
elVRMeE/wysnuyTzADvHeqU=
=h+o5
-----END PGP SIGNATURE-----

--/YnR2r17TIEndSCI--
