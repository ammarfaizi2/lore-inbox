Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUFJWAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUFJWAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUFJWAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:00:18 -0400
Received: from legolas.restena.lu ([158.64.1.34]:25472 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263107AbUFJWAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:00:10 -0400
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
From: Craig Bradney <cbradney@zip.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Lars <terraformers@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200406102356.07920.bzolnier@elka.pw.edu.pl>
References: <ca9jj9$dr$1@sea.gmane.org>
	 <200406101558.54240.bzolnier@elka.pw.edu.pl> <caak85$9vg$1@sea.gmane.org>
	 <200406102356.07920.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Xz+A8MJe6c5fR9l93sIb"
Message-Id: <1086904803.8139.3.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 00:00:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xz+A8MJe6c5fR9l93sIb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-10 at 23:56, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 10 of June 2004 23:36, Lars wrote:
> > thanks
> >
> > after some reading, im using now in rc.local:
> >
> > ### C1 Halt Disconnect Fix for Chip rev. C17
> > setpci -H1 -s 0:0.0 6F=3D1F
> > setpci -H1 -s 0:0.0 6E=3D01
> > echo "Applying C1 Halt Disconnect Fix"
> >
> > this is for an older nforce2 board (a7n8x 1.04) with rev. C17 chip
> > and worked fine so far.
> >
> > for the newer chip revision it should read
> >
> > ### C1 Halt Disconnect Fix for Chip rev. C18D
> > setpci -H1 -s 0:0.0 6F=3D9F
> > setpci -H1 -s 0:0.0 6E=3D01
> > echo "Applying C1 Halt Disconnect Fix"
> >
> > first setpci is for the c1 halt bit and the second one enables the
> > 80ns stability value.
>=20
> Order should be reversed.
>=20
> > i understand that its not good to enable c1 for all boards, but it woul=
d
> > be nice to have the option to force the fixup on boards which
> > work ok but have no bios option to enable c1. (like the a7n8x)
> > an bootoption like "forceC1halt" or something would be nice here.
>=20
> It can be perfectly handled in user-space as you've just showed. :-)
> There is no need to add complexity to the kernel.


Except if people have the trouble when installing Linux.... ok, yes,
they can still be done somehow, but thats just ugly for the "put cd in
and install" users. Surely the kernel should be detecting this stuff and
using various options as required.

Craig

--=-Xz+A8MJe6c5fR9l93sIb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyNnii+pIEYrr7mQRAl2DAJ4+7X+4Sb+50ibHh22rNp9sXU8MPACgmb6p
f14jycxLjUOsyWy0WqQv/xA=
=8eMG
-----END PGP SIGNATURE-----

--=-Xz+A8MJe6c5fR9l93sIb--

