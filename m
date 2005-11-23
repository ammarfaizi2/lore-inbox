Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVKWFCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVKWFCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 00:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVKWFCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 00:02:18 -0500
Received: from zlynx.org ([199.45.143.209]:47885 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S1030199AbVKWFCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 00:02:14 -0500
Subject: Re: Linux 2.6.15-rc2
From: Zan Lynx <zlynx@acm.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, jeffrey.hundstad@mnsu.edu, ak@muc.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	 <43829ED2.3050003@mnsu.edu> <20051122150002.26adf913.akpm@osdl.org>
	 <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
	 <20051122170507.37ebbc0c.akpm@osdl.org>
	 <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0E5phJvoDLelRgSWMXLB"
Date: Tue, 22 Nov 2005 22:01:37 -0700
Message-Id: <1132722097.9906.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0E5phJvoDLelRgSWMXLB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-11-22 at 17:39 -0800, Linus Torvalds wrote:
>=20
> On Tue, 22 Nov 2005, Andrew Morton wrote:
> > >=20
> > > Why does it happen at all, though?
> >=20
> > davem recently merged a patch which adds ext3 ioctls to fs/compat_ioctl=
.c.=20
> > That required inclusion of ext3 and jbd header files.  Those files expl=
ode
> > unpleasantly when CONFIG_JBD=3Dn.
>=20
> Oh. How about just making jbd.h do the rigt thing, and not care about the=
=20
> configuration?
>=20
> If we include jbd.h, we want the jbd data structures. There's never any=20
> reason to care whether jbd is enabled or not afaik.
>=20
> Ie maybe just something like this?
>=20
> (Untested, obviously. I'm just assuming that anything that actually=20
> _needs_ the jbd functionality should have made sure that jdb is enabled.)
>=20
> Zan, Jeffrey?
[snip patch]

Yes, that also works for me.  It compiled and is running just fine.
--=20
Zan Lynx <zlynx@acm.org>

--=-0E5phJvoDLelRgSWMXLB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDg/exG8fHaOLTWwgRAjf2AKCEteNXw2hlHc/okJJzmjWA+Ki/7gCgm8xW
uB0zgf0FbiWpE3PxIGn33Ik=
=RcRs
-----END PGP SIGNATURE-----

--=-0E5phJvoDLelRgSWMXLB--

