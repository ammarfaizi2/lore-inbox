Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVBGWCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVBGWCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVBGWCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:02:23 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:11685 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261343AbVBGWBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:01:04 -0500
Subject: Re: [PATCH] Filesystem linking protections
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Valdis.Kletnieks@vt.edu
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <200502072145.j17LjFDr025558@turing-police.cc.vt.edu>
References: <1107802626.3754.224.camel@localhost.localdomain>
	 <200502071914.j17JEbjQ018534@turing-police.cc.vt.edu>
	 <1107804873.3754.232.camel@localhost.localdomain>
	 <200502072145.j17LjFDr025558@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Kcc29qXBJ6xHUeIyFeD/"
Date: Mon, 07 Feb 2005 23:00:33 +0100
Message-Id: <1107813633.3754.245.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Kcc29qXBJ6xHUeIyFeD/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 07-02-2005 a las 16:45 -0500, Valdis.Kletnieks@vt.edu escribi=F3:
> On Mon, 07 Feb 2005 20:34:33 +0100, Lorenzo =3D?ISO-8859-1?Q?Hern=3DE1nde=
z_?=3D =3D?ISO-8859-1?Q?Garc=3DEDa-Hierro?=3D said:
>=20
> > But It's better to give users a "secure-by-default" status, at least on
> > those parts that don't affect negatively the stability or the
> > performance itself.
>=20
> It's still policy, and should be put someplace where users can manage it.
> You're changing the behavior from what POSIX specifies, and that's in gen=
eral
> a no-no for mainline kernel code.

A sysctl can be a good option, creating a CTL_SECURITY and then
registering stuff under it, but this requires to have the kernel hackers
agree with implementing a new security suite and such.
In short, re-inventing the wheel.

> Like an LSM, which happens to be there so users can impose policy without
> making any code changes to the kernel.  Implementing a policy that result=
s in
> non-POSIXy behavior in an LSM is perfectly OK.. ;)

It's currently made in vSecurity :)

> > The LSM hook call is before the check, so, LSM framework still has the
> > control over it, until it releases the operation giving control back to
> > the standard function.
>=20
> Right.. Which means LSM can stop that particular attack even faster than
> your patch.. ;)

At least I don't interfere with LSM, so, if no LSM hook adds it's own
security checks, then it gets used.

> > If users must rely on LSM or other external solutions for applying basi=
c
> > security checks (as the framework itself only provides the way to apply
> > them, the checks need to be implemented in a module), then we are makin=
g
> > them unable to be protected using the "default" configuration.
>=20
> You're making the very rash assumption that a hard-coded one-size-fits al=
l
> "default" that behaves differently than POSIX is suitable for all sites,
> including sites that run software that gets broken by this change, and
> things like embedded systems where it's not a concern at all, and sites t=
hat
> already implement some *other* system to ensure that it's not an issue (f=
or
> instance, by using an SELinux policy...)

Good point, then the solution is to make it config-dependent, and that's
a thing that kernel hackers seem to dislike.

Lemme know what's the final thought on this, so, I could work out it and
give what you want, without time loss and we all can feel happy with
it :)

Cheers and thanks for the comments,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-Kcc29qXBJ6xHUeIyFeD/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB+UBDcEopW8rLewRAsIkAJ4nPX1btaI0cyBvqJJzi7AESd0cigCgu1Nd
JT5jOoxn0RGUJDDYRSmQX4k=
=O5QT
-----END PGP SIGNATURE-----

--=-Kcc29qXBJ6xHUeIyFeD/--

