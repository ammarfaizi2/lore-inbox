Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSJKOPw>; Fri, 11 Oct 2002 10:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbSJKOPv>; Fri, 11 Oct 2002 10:15:51 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:38638 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262500AbSJKOPu>; Fri, 11 Oct 2002 10:15:50 -0400
Subject: Re: [PATCH] 2.5.41, cciss (3 of 3)
From: Arjan van de Ven <arjanv@redhat.com>
To: steve.cameron@hp.com
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20021011081031.C1911@zuul.cca.cpqcorp.net>
References: <20021011081031.C1911@zuul.cca.cpqcorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-M21IVxaMW8U+nC3DHJVN"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Oct 2002 16:21:43 +0200
Message-Id: <1034346103.1910.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M21IVxaMW8U+nC3DHJVN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-10-11 at 16:10, Stephen Cameron wrote:
>=20
> Wait up to 20 seconds for polled commands to complete.  A certain multipo=
rt
> storage box needs this.
>=20
> diff -urN linux-2.5.41-p/drivers/block/cciss.c linux-2.5.41-q/drivers/blo=
ck/cciss.c
> --- linux-2.5.41-p/drivers/block/cciss.c	Wed Oct  9 15:22:14 2002
> +++ linux-2.5.41-q/drivers/block/cciss.c	Wed Oct  9 15:54:35 2002
> @@ -1318,9 +1318,9 @@
>          unsigned long done;
>          int i;
> =20
> -        /* Wait (up to 2 seconds) for a command to complete */
> +        /* Wait (up to 20 seconds) for a command to complete */
> =20
> -        for (i =3D 200000; i > 0; i--) {
> +        for (i =3D 2000000; i > 0; i--) {
>                  done =3D hba[ctlr]->access.command_completed(hba[ctlr]);
>                  if (done =3D=3D FIFO_EMPTY) {
>                          udelay(10);     /* a short fixed delay */

ugh 20 seconds udelay....

why can't you sleep here ?
(and yes 20 seconds WILL trigger watchdogs!)


--=-M21IVxaMW8U+nC3DHJVN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9pt53xULwo51rQBIRAnylAJ4hNzS475fxr0cyUEpSCprZQZcHnQCeIoPm
qXRKqXooA9yhfnMYx9KPHm0=
=TukI
-----END PGP SIGNATURE-----

--=-M21IVxaMW8U+nC3DHJVN--

