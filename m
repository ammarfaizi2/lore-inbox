Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTDQIfC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 04:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTDQIfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 04:35:02 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:40174 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261276AbTDQIe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 04:34:59 -0400
Subject: Re: [BK+PATCH] remove __constant_memcpy
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304161904170.1534-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304161904170.1534-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0LcoXh2vGjUH+1yaiPKX"
Organization: Red Hat, Inc.
Message-Id: <1050569207.1412.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 17 Apr 2003 10:46:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0LcoXh2vGjUH+1yaiPKX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-04-17 at 04:06, Linus Torvalds wrote:
> On Wed, 16 Apr 2003, Jeff Garzik wrote:
> >=20
> > gcc's __builtin_memcpy performs the same function (and more) as the=20
> > kernel's __constant_memcpy.  So, let's remove __constant_memcpy, and le=
t=20
> > the compiler do it.
>=20
> Please don't.
>=20
> There's no way gcc will EVER get the SSE2 cases right. It just cannot do=20
> it. In fact, I live in fear that we will have to turn off the compiler=20
> intrisics entirely some day just because there is always the worry that=20
> gcc will start using FP.

it can do that ANYWAY for all kinds of things.
We really should ask the gcc folks to add a
-fdontyoudareusefloatingpoint flag (well different name probably) to
make sure it never ever will generate FP code. (would also help catch
abusers of FP code in the kernel as a bonus ;)

--=-0LcoXh2vGjUH+1yaiPKX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+nmn3xULwo51rQBIRAmPgAJ4nz7N0lG2S83NCBFREN0+afhg5tACfe1tv
nFz5TLGFmBrGA77WkLbEWiM=
=BJJ2
-----END PGP SIGNATURE-----

--=-0LcoXh2vGjUH+1yaiPKX--
