Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbUKVBwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUKVBwH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUKVBwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:52:07 -0500
Received: from monk.area614.net ([64.46.156.22]:61069 "EHLO monk.area614.net")
	by vger.kernel.org with ESMTP id S261892AbUKVBwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:52:01 -0500
Subject: Re: [patch 1/3] lsm: add bsdjail module
From: Colin Walters <walters@verbum.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LWpEl6QsAkNpLx76XQZf"
Date: Sun, 21 Nov 2004 20:51:55 -0500
Message-Id: <1101088315.3987.40.camel@nexus.verbum.private>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LWpEl6QsAkNpLx76XQZf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[ Sorry for the lack of References, I'm not on this list and had to grab
the message from the web archives ]

> On Iau, 2004-10-07 at 00:26, Andrew Morton wrote:
> > I don't recall anyone requesting this feature.  Tell me why we should a=
dd
> > it to Linux?
>=20
> Subject to the code cleanups and stuff you've noted I'd actually like to
> see BSD jail stuff in our security modules because it has the virtue of
> simplicity. If it can be extended to do all of vserver even better. J
> Random Admin has a good chance at configuring BSD jails etups. J Random
> Admin needs some serious tools that don't exist to set up SELinux the
> same way.
>=20
> In the security world simplicity is often a virtue, both in code and
> concepts.

BSD jails are a kind of halfway point on the=20
"access control <-> virtualization" sliding scale.  Certainly, using
SELinux for virtualization is not trivial, and I think that's fine; it
is not its intended purpose.  But let's be honest - using BSD jails for
strong access control ("security") has its own downsides.  For example,
now J Random Admin has N rpm/dpkg databases to manage on the same system
instead of one.  Or they have hand-rolled chroots which need their own
special treatment, scripts, etc.

In other words, BSD jails and SELinux are certainly not the same thing.
This becomes more obvious when you realize that hey - SELinux is still
useful inside a BSD jail.  Why should the cracked sendmail daemon be
able to destroy your configuration and the rest of the chroot?  You
might even want BSD jails to enforce different SELinux policies.


--=-LWpEl6QsAkNpLx76XQZf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBoUY6OIkJWWp2WGURAlHTAKCBaok6/slZeFVzt7BBLCNyygsE+gCdGnZV
NFDhpKOFOJ7t5dIzz6u4GEQ=
=zw5s
-----END PGP SIGNATURE-----

--=-LWpEl6QsAkNpLx76XQZf--

