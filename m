Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267079AbUBMSGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267099AbUBMSGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:06:52 -0500
Received: from nan-smtp-19.noos.net ([212.198.2.119]:17607 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S267079AbUBMSGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:06:50 -0500
Subject: Re: JFS default behavior (was: UTF-8 in file systems?
	xfs/extfs/etc.)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040213030346.GF25499@mail.shareable.org>
References: <1076604650.31270.20.camel@ulysse.olympe.o2t>
	 <20040213030346.GF25499@mail.shareable.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8UotSnk5Skl9NWm+qFfc"
Organization: Adresse personelle
Message-Id: <1076695606.23795.23.camel@m222.net81-64-248.noos.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Fri, 13 Feb 2004 19:06:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8UotSnk5Skl9NWm+qFfc
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven, 13/02/2004 =E0 03:03 +0000, Jamie Lokier a =E9crit :
> Nicolas Mailhot wrote:
> > But that's not a reason not to fix the core problem - I don't want to
> > spent hours fixing filenames next time someone comes up with a new
> > encoding. Please put valid encoding info somewhere or declare filenames
> > are utf-8 od utf-16 only - changing user locale should not corrupt old
> > data.
>=20
> If you attach encoding to names for a whole filesystem, you will get
> really unpleasant bugs including security holes because some names
> won't be writable, so the fs will either return error codes when those
> names are used, or silently alter the names.

You can have security holes now just by tricking an app into reading
files written by another app which disagreed on the locale.

And as for the filename problems :
- just mangle existing invalid filenames when a default encoding is
agreed upon
- refuse to write new files with invalid filenames just like you would
with the few names forbidden in ascii - apps will learn to cope.

Some convention is needed, expecting it to materialise without os
enforcement is deluding oneself, getting a change like this in place
will definitely be painful but the current situation is far from
painless for a lot of people.

Regards,

--=20
Nicolas Mailhot

--=-8UotSnk5Skl9NWm+qFfc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALRI2I2bVKDsp8g0RAsUQAJ9t2CuQJnxUs1t/6Fe0pIBTUtf1LgCgr9LO
AWU1VXYk/8VKSuHVvORMcFg=
=3cuh
-----END PGP SIGNATURE-----

--=-8UotSnk5Skl9NWm+qFfc--

