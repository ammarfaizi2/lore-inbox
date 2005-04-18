Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVDRUYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDRUYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDRUXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:23:09 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:63958 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262204AbVDRUVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:21:01 -0400
Subject: Re: [PATCH 0/7] procfs privacy
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Rik van Riel <riel@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0504181600480.11251@chimarrao.boston.redhat.com>
References: <1113849977.17341.68.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504181526280.11251@chimarrao.boston.redhat.com>
	 <1113853561.17341.111.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504181600480.11251@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eArni7axcT8Ui8R4Hw8o"
Date: Mon, 18 Apr 2005 22:18:05 +0200
Message-Id: <1113855485.17341.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eArni7axcT8Ui8R4Hw8o
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 18-04-2005 a las 16:01 -0400, Rik van Riel escribi=F3:
> On Mon, 18 Apr 2005, Lorenzo Hern=E1ndez Garc=EDa-Hierro wrote:
>=20
> > Adding a "trusted user group"-like configuration option could be useful=
,
> > as it's done within grsecurity, among that the whole thing might be goo=
d
> > to depend on a config. option, but that implies using weird ifdef's and
> > the other folks.
>=20
> I'd rather see something like this implemented as an LSM
> module - or better yet, an SELinux security policy.

For this purpose I (re)submitted a patch originally made by Serge E.
Hallyn that adds a hook in order to catch task lookups, thus, providing
an easy way to handle and determine when a task can lookup'ed.

It's at:
http://pearls.tuxedo-es.org/patches/lsm/lsm-task_lookup-hook.patch

vSecurity currently provides support for it (optional).

SELinux policy can handle in a much more fine-grained these
restrictions, just that it's still something that not all people can
deploy without some special effort and "tweak up" (if their system
doesn't provide support for it, of course, currently Red Hat has done a
great job in that terms).

>=20
> There's no need to sprinkle security policy all over the
> kernel.

I completely agree.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-eArni7axcT8Ui8R4Hw8o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZBX9DcEopW8rLewRAmzYAJ94o7t6UzZP4Ul61lW6KjyGXQ0I+QCgsUtW
2at1aL7tbd4EtMvv1PzIePs=
=CwCA
-----END PGP SIGNATURE-----

--=-eArni7axcT8Ui8R4Hw8o--

