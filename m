Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUG1NbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUG1NbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 09:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUG1NbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 09:31:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266864AbUG1Na5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 09:30:57 -0400
Subject: Re: allow recursive die() on i386
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Keith Owens <kaos@ocs.com.au>
Cc: jmoyer@redhat.com, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <9424.1091020297@ocs3.ocs.com.au>
References: <9424.1091020297@ocs3.ocs.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/dwDGsX6+j8DApcAnK+U"
Organization: Red Hat UK
Message-Id: <1091021430.2795.28.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 15:30:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/dwDGsX6+j8DApcAnK+U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-28 at 15:11, Keith Owens wrote:
> On Wed, 28 Jul 2004 08:35:39 -0400,=20
> Jeff Moyer <jmoyer@redhat.com> wrote:
> >This patch allows for a recursive die() on i386.  This closely resembles
> >what is done on x86_64, fwiw.
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2=
.6.8-rc2-mm1/broken-out/make-i386-die-more-resilient-against-recursive-erro=
rs.patch
>=20
> does this and more, it also guards against too many recursive calls to
> die.  The patch is already in Andrew's tree.
+	static struct {
+		spinlock_t lock;
+		u32 lock_owner;
+		int lock_owner_depth;
+	} die =3D {
+		.lock =3D			SPIN_LOCK_UNLOCKED,
+		.lock_owner =3D		-1,
+		.lock_owner_depth =3D	0
+	};


humm... am I the only one who considers this a little bit ugly ???

--=-/dwDGsX6+j8DApcAnK+U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBB6p2xULwo51rQBIRAqaNAJ99KG1PL0r5Q1QfQjtDVkSVazvOJwCePBUY
F7SxVFFtg3gxcNh7YZHFoK0=
=2cXw
-----END PGP SIGNATURE-----

--=-/dwDGsX6+j8DApcAnK+U--

