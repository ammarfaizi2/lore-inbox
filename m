Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285848AbRLHGgG>; Sat, 8 Dec 2001 01:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285849AbRLHGf4>; Sat, 8 Dec 2001 01:35:56 -0500
Received: from [63.85.124.165] ([63.85.124.165]:37637 "EHLO
	aerospace.fries.net") by vger.kernel.org with ESMTP
	id <S285848AbRLHGfm>; Sat, 8 Dec 2001 01:35:42 -0500
Date: Sat, 8 Dec 2001 00:31:52 -0600
From: David Fries <dfries@mail.win.org>
To: linux-kernel@vger.kernel.org
Subject: two many zlib's in the kernel
Message-ID: <20011208003152.A8299@aerospace.fries.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Seems someone duplicated the zlib.  One copy is in ppp the other is in
jffs2 as I listed below they are virtually identical.  The problem is
you can't compile both in the kernel at the same time for obvious
reasons.  Since I don't know the build code maybe someone else would
like to fix it?

=2E/fs/jffs2/zlib.c
=2E/drivers/net/zlib.c

diff ./fs/jffs2/zlib.c ./drivers/net/zlib.c
436c436
<     /* Didn't use ct_data typedef below to supress compiler warning */
---
>     /* Didn't use ct_data typedef below to suppress compiler warning */
692c692
<  * IN  assertion: all calls to to UPDATE_HASH are made with consecutive
---
>  * IN  assertion: all calls to UPDATE_HASH are made with consecutive
703c703
<  * IN  assertion: all calls to to INSERT_STRING are made with consecutive
---
>  * IN  assertion: all calls to INSERT_STRING are made with consecutive
2068c2068
<     static int static_init_done =3D 0;
---
>     static int static_init_done;

--=20
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		| http://fries.net/~david/pgp.txt |
		+---------------------------------+

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjwRs9gACgkQAI852cse6PCrxQCfUGuUIPfOIol2oDonrabzcpn6
l88AoLDF0pi65lYDbcmrLH+UZo+VpYx+
=nttc
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
