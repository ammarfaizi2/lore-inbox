Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbULXXgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbULXXgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 18:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbULXXgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 18:36:46 -0500
Received: from faye.voxel.net ([69.9.164.210]:21732 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261459AbULXXgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 18:36:44 -0500
Subject: Re: [PATCH] kernel_read result fixes
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1103873064.5994.6.camel@localhost>
References: <1103873064.5994.6.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0tzzbDcEXdNfy+0FdYgl"
Date: Fri, 24 Dec 2004 18:36:36 -0500
Message-Id: <1103931396.6224.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0tzzbDcEXdNfy+0FdYgl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-12-24 at 02:24 -0500, Andres Salomon wrote:
> Hi,
>=20
> A few potential vulnerabilities were pointed out by Katrina Tsipenyuk in
> <http://seclists.org/lists/linux-kernel/2004/Dec/1878.html>.  I haven't
> seen any discussion or fixes of the issue yet, so here's a patch
> (against 2.6.9).  The fixes are along the same lines as the previous
> binfmt_elf fixes.  There's one additional place (inside fs/binfmt_som.c)
> that a fix could be applied, but since that doesn't compile anyways, I
> didn't see a point in patching it.
>=20
>=20

Ok, you can ignore this; I believe the original advisory is bogus.
prepare_binprm ensures a 128 byte buffer that kernel_read data is copied
to; in case something smaller is copied in, the rest of the space is
zero'd out.  Thus, <128 reads are fine, and in many cases (as in
binfmt_script w/ tiny scripts less than 128 bytes in total) perfectly
valid.


--=20
Andres Salomon <dilinger@voxel.net>

--=-0tzzbDcEXdNfy+0FdYgl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBzKgD78o9R9NraMQRApQ2AJ0V6ZbssJJ3nOU0rYoeLdDdSOIjEQCfeWvf
Wv6O2eKO674GgBNvgdNy8P0=
=bmq6
-----END PGP SIGNATURE-----

--=-0tzzbDcEXdNfy+0FdYgl--

