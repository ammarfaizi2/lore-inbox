Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVA1Se6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVA1Se6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVA1Se5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:34:57 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:9430 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261523AbVA1ScY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:32:24 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.co,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com
In-Reply-To: <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y21AUM5I1YFNeKUSUniW"
Date: Fri, 28 Jan 2005 19:31:50 +0100
Message-Id: <1106937110.3864.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y21AUM5I1YFNeKUSUniW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 28-01-2005 a las 10:02 -0800, Stephen Hemminger escribi=F3:
> > Attached you can find a split up patch ported from grSecurity [1], as
> > Linus commented that he wouldn't get a whole-sale patch, I was working
> > on it and also studying what features of grSecurity can be implemented
> > without a development or maintenance overhead, aka less-invasive
> > implementations.
> >=20
> > It adds support for advanced networking-related randomization, in
> > concrete it adds support for TCP ISNs randomization, RPC XIDs
> > randomization, IP IDs randomization and finally a sub-key under the
> > Cryptographic options menu for Linux PRNG [2] enhancements (useful now
> > and also for future patch submissions), which currently has an only-one
> > option for poll sizes increasing (x2).
> >=20
> > As it's impact is minimal (in performance and development/maintenance
> > terms), I recommend to merge it, as it gives a basic prevention for the
> > so-called system fingerprinting (which is used most by "kids" to know
> > how old and insecure could be a target system, many time used as the
> > first, even only-one, data to decide if attack or not the target host)
> > among other things.
> >=20
> > There's only a missing feature that is present on grSecurity, the
> > sources ports randomization which seems achieved now by some changes
> > that can be checked out in the Linux BKBits repository:
> > http://linux.bkbits.net:8080/linux-2.6/diffs/net/ipv4/tcp_ipv4.c@1.105?=
nav=3Dindex.html|src/|src/net|src/net/ipv4|hist/net/ipv4/tcp_ipv4.c
> > (net/ipv4/tcp_ipv4.c@1.105)
> >=20
> > I'm not sure of the effectiveness of that changes, but I just prefer to
> > keep it as most simple as possible.If there are thoughts on reverting t=
o
> > the old schema, and using obsd_rand.c code instead, just drop me a line
> > and I will modify the patch.
>=20
> Okay, but:
> * Need to give better explanation of why this is required,=20
>   existing randomization code in network is compromise between
>   performance and security. So you need to quantify the performance
>   impact of this, and the security threat reduction.

Performance impact is none AFAIK.
I've explained them in an early reply to Adrian [1].

> * Why are the OpenBSD random functions better? because they have more
>   security coolness factor?

I'm not an OpenBSD user, and no intention to being a one.
I just recognize that the functions do the same job better, as explained
in the Kconfig diffs.

> * It is hard to have two levels of security based on config options.
>   Think of a distro vendor, do they ship the fast or the secure system??
>=20
> As always:
> * Send networking stuff to netdev@oss.sgi.com

Added to CC list.

> * Please split up patches.

If you talk about removing the pool sizes increasing, then i will do it,
but i would like to know if this has any chances to get merged.

[1]: http://lkml.org/lkml/2005/1/28/139

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-Y21AUM5I1YFNeKUSUniW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB+oUWDcEopW8rLewRAv0sAKCzfxCJAD/tbDg4V+mAYIaFn3UYSgCfXsXH
BiBdnJqOOEnVcsLqhHApLw0=
=SOGW
-----END PGP SIGNATURE-----

--=-Y21AUM5I1YFNeKUSUniW--

