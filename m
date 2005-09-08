Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVIHBBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVIHBBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVIHBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:01:23 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:17057 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932479AbVIHBBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:01:22 -0400
Date: Thu, 8 Sep 2005 11:01:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Milton Miller <miltonm@bga.com>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       edwardsg@sgi.com, anton@samba.org, torvalds@osdl.org
Subject: Re: [PATCH] ppc64: iSeries early printk breakage
Message-Id: <20050908110115.1f1bce0c.sfr@canb.auug.org.au>
In-Reply-To: <ccb92a396938e8c1d00b46d122d6583c@bga.com>
References: <20050907195238.5523dada.sfr@canb.auug.org.au>
	<ccb92a396938e8c1d00b46d122d6583c@bga.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__8_Sep_2005_11_01_15_+1000_2F0zdbv9zg9AwGFe"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__8_Sep_2005_11_01_15_+1000_2F0zdbv9zg9AwGFe
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Sep 2005 06:04:36 -0500 Milton Miller <miltonm@bga.com> wrote:
>
> Does anything actually break without this patch?

Yes, an iSeries box will not boot.

> My reading of unregister_console says we will acquire
> the console semaphore, walk the list, fail to find the
> console, relase the semaphore, and return.

Consider the case that console_drivers =3D=3D NULL (because we have never c=
alled register_console).
unregister_console dereferences console_drivers ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__8_Sep_2005_11_01_15_+1000_2F0zdbv9zg9AwGFe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDH41gFdBgD/zoJvwRAsEOAJ42kO14aOD5vtrMBvqqpuIObSxmnACgnhPC
pQEJnpwPwxr9QmVqKs2PNkE=
=LCEE
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Sep_2005_11_01_15_+1000_2F0zdbv9zg9AwGFe--
