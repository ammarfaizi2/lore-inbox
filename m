Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUBKT33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUBKT33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:29:29 -0500
Received: from starcraft.mweb.co.za ([196.2.45.78]:56963 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S263695AbUBKT3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:29:25 -0500
Date: Wed, 11 Feb 2004 21:28:58 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Mark de Vries <m.devries@nl.tiscali.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About highmem in 2.6
Message-Id: <20040211212858.2ce1a17d.bonganilinux@mweb.co.za>
In-Reply-To: <402A7EC6.7010003@nl.tiscali.com>
References: <1o6EZ-2zO-27@gated-at.bofh.it>
	<1o7AZ-3PD-9@gated-at.bofh.it>
	<402A7EC6.7010003@nl.tiscali.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__11_Feb_2004_21_28_58_+0200_pHG9.8AkYhWal6tA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__11_Feb_2004_21_28_58_+0200_pHG9.8AkYhWal6tA
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Feb 2004 20:13:10 +0100
Mark de Vries <m.devries@nl.tiscali.com> wrote:

> Dave McCracken wrote:
> > --On Wednesday, February 11, 2004 18:47:04 +0100 Luis Miguel Garc=EDa
> > <ktech@wanadoo.es> wrote:
> >=20
> >=20
> >>When I first installed 2.4, someone told me that if I had 1 gb ram it w=
as
> >>better to not use highmem because those extra aditional mb was not worth
> >>the speed penalty of using the feature.
> >>
> >>Sorry for my ignorance (and my sucking english) but must I enable highm=
em
> >>now with 2.6? or have it any speed penalty althought?
> >=20
> >=20
> > I don't know if anyone has actually measured the relative performance, =
but
> > I'd expect the answer to be the same as 2.4.  There is a small but
> > measurable performance penalty for enabling highmem which is higher than
> > the benefit of the extra 128 meg of memory you get when you have 1G.  If
> > you have more than 1G it's better to enable highmem.
> >=20
>=20
> I've been using this patch for a while now on my box (with 1GB):
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23a=
a1/00_3.5G-address-space-5
> (kernel is 'vanilla' otherwise)
>=20
> This allows you to use your full 1GB w/out highmem support.... (2G/2G=20
> user/kernel addr space split, or something..)
>=20
> Anything (potentially) wrong/bad about this patch??
>=20
> Is there a simmilar patch for 2.6??
>=20

There is nothing wrong with that patch, the problem with Highmem support on=
 x86 is that is uses an Intel hack to address the full 1Gb of memory, which=
 make memory access a bit slower. The question is, does the 128Mb additiona=
l memory worth that penalty?

--Signature=_Wed__11_Feb_2004_21_28_58_+0200_pHG9.8AkYhWal6tA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAKoKF+pvEqv8+FEMRAuOAAJ9OMuA8EMwBDl5hD/NdnqRKnu4ExACeLDAt
rDg90+qFxvsJagYZ9gCxf3U=
=un51
-----END PGP SIGNATURE-----

--Signature=_Wed__11_Feb_2004_21_28_58_+0200_pHG9.8AkYhWal6tA--
