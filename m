Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTJRO0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 10:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTJRO0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 10:26:22 -0400
Received: from D714e.d.pppool.de ([80.184.113.78]:47763 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261598AbTJRO0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 10:26:21 -0400
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
From: Daniel Egger <degger@fhm.edu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, rob@landley.net
In-Reply-To: <3F90CFE5.5000801@cyberone.com.au>
References: <200310180018.21818.rob@landley.net>
	 <3F90CFE5.5000801@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/PpnUPVp30c3q8EvrIyV"
Message-Id: <1066477155.5606.34.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 18 Oct 2003 13:39:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/PpnUPVp30c3q8EvrIyV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, den 18.10.2003 schrieb Nick Piggin um 07:30:

> This came up on the list a while back. IIRC the conclusion was that
> runtime memory usage and speed, and not so significant compression
> improvement over gzip.

I quick test with a PowerPC kernel and the normal vmlinux image reveals
that this is nonsense.=20

-rwxr-xr-x    1 root     root      2766490 2003-09-27 22:29 vmlinux
-rwxr-xr-x    1 root     root      1149410 2003-09-27 22:29 vmlinux.gz
-rwxr-xr-x    1 root     root      1062999 2003-09-27 22:29 vmlinux.bz2

This is a 86411 bytes or 8.1% reduction, seems significant to me...

Granted, it takes 9 times as long to decompress the kernel and ca. 900kb
more memory but considering an embedded DSL router I'm working with
which has 16MB RAM but only 4MB Flash this is certainly worth it. At
least when the target is an embedded device.

--=20
Servus,
       Daniel

--=-/PpnUPVp30c3q8EvrIyV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/kSZjchlzsq9KoIYRAhRQAKClhBbiqWoA+1lfWSRCcP12wDcBPACg25Fq
Y1gaUl0YmtCTvTWkpGY+XoM=
=9yAp
-----END PGP SIGNATURE-----

--=-/PpnUPVp30c3q8EvrIyV--

