Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUFJWdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUFJWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUFJWdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:33:15 -0400
Received: from legolas.restena.lu ([158.64.1.34]:10120 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263159AbUFJWcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:32:54 -0400
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
From: Craig Bradney <cbradney@zip.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Lars <terraformers@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200406110026.34006.bzolnier@elka.pw.edu.pl>
References: <ca9jj9$dr$1@sea.gmane.org>
	 <200406102356.07920.bzolnier@elka.pw.edu.pl>
	 <1086904803.8139.3.camel@amilo.bradney.info>
	 <200406110026.34006.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RVCcCKR4s505xcdM/5uP"
Message-Id: <1086906770.10033.6.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 00:32:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RVCcCKR4s505xcdM/5uP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-11 at 00:26, Bartlomiej Zolnierkiewicz wrote:
> On Friday 11 of June 2004 00:00, Craig Bradney wrote:
> > On Thu, 2004-06-10 at 23:56, Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday 10 of June 2004 23:36, Lars wrote:
> > > > thanks
> > > >
> > > > after some reading, im using now in rc.local:
> > > >
> > > > ### C1 Halt Disconnect Fix for Chip rev. C17
> > > > setpci -H1 -s 0:0.0 6F=3D1F
> > > > setpci -H1 -s 0:0.0 6E=3D01
> > > > echo "Applying C1 Halt Disconnect Fix"
> > > >
> > > > this is for an older nforce2 board (a7n8x 1.04) with rev. C17 chip
> > > > and worked fine so far.
> > > >
> > > > for the newer chip revision it should read
> > > >
> > > > ### C1 Halt Disconnect Fix for Chip rev. C18D
> > > > setpci -H1 -s 0:0.0 6F=3D9F
> > > > setpci -H1 -s 0:0.0 6E=3D01
> > > > echo "Applying C1 Halt Disconnect Fix"
> > > >
> > > > first setpci is for the c1 halt bit and the second one enables the
> > > > 80ns stability value.
> > >
> > > Order should be reversed.
> > >
> > > > i understand that its not good to enable c1 for all boards, but it
> > > > would be nice to have the option to force the fixup on boards which
> > > > work ok but have no bios option to enable c1. (like the a7n8x)
> > > > an bootoption like "forceC1halt" or something would be nice here.
> > >
> > > It can be perfectly handled in user-space as you've just showed. :-)
> > > There is no need to add complexity to the kernel.
> >
> > Except if people have the trouble when installing Linux.... ok, yes,
>=20
> What trouble are you talking about?
>=20
> Fix is in the kernel and is applied when C1 Halt Disconnect is enabled.
> If  C1 H.D. is disabled you need to enable it somehow from user-space,
> thus you can apply fixup from user-space at the same time.
>=20
> > they can still be done somehow, but thats just ugly for the "put cd in
> > and install" users. Surely the kernel should be detecting this stuff an=
d
> > using various options as required.
>=20
> If you think that kernel should have options for all PCI tweaks
> available than sorry but you are wrong (grab powertweak instead).


Well.. no.. I dont suggest that the kernel apply fixes for all the buggy
motherboards and other h/w out there.. but I guess the distro builders
need to make sure these post boot options are being set based on
hardware detected, or something. :)

Craig

--=-RVCcCKR4s505xcdM/5uP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyOGSi+pIEYrr7mQRAv8NAJ0d6cq3jHwCWfBUjrknu6XvD7oHNwCeLLeg
GwoSWEjXGnrx+LT1hGzs/gc=
=sLtg
-----END PGP SIGNATURE-----

--=-RVCcCKR4s505xcdM/5uP--

