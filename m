Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbTJAOou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJAOot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:44:49 -0400
Received: from [199.45.143.209] ([199.45.143.209]:57860 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262236AbTJAOoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:44:17 -0400
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
From: Zan Lynx <zlynx@acm.org>
To: Vitaly Fertman <vitaly@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <200309302006.32584.vitaly@namesys.com>
References: <1064936688.4222.14.camel@localhost.localdomain>
	 <200309302006.32584.vitaly@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PJ2Kpl2b84d670zsdxBi"
Organization: 
Message-Id: <1065019441.4226.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2003 08:44:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PJ2Kpl2b84d670zsdxBi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-09-30 at 10:06, Vitaly Fertman wrote:
> Hi
>=20
> On Tuesday 30 September 2003 19:44, Zan Lynx wrote:
> > I was interested in the contents of the files in /proc/fs/reiserfs/sda1=
,
> > so I did these commands:
> >
> > cd /proc/fs/reiserfs/sda1
> > grep . *
> >
> > (I like using the grep . * because it labels the contents of each file
> > with the filename.)
> >
> > I did this as a regular user and also as root.  Both times the system
> > crashed and immediately rebooted.  I tried it again as root and the
> > system froze instead.
>=20
> which kernel do you use? some patches? could you look into syslog and
> send us all relevant information.
>=20
> would you also run cat on all files there separately to detect the fault =
one.
>=20

The kernel is 2.6.0-test6 from kernel.org.  No other patches.

Okay, I did cat file > /dev/null on each one.  It looks like the problem
is with oidmap.  The other files do not crash.
--=20
Zan Lynx <zlynx@acm.org>

--=-PJ2Kpl2b84d670zsdxBi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/eugwG8fHaOLTWwgRAngcAJ9Qfg8JjLMHUgip9cQvTyxqf278vgCfdlvr
0LZUcA9VDHrjyHe6HJryyuI=
=1waQ
-----END PGP SIGNATURE-----

--=-PJ2Kpl2b84d670zsdxBi--

