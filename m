Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTKFVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTKFVSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:18:09 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:9612 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263378AbTKFVSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:18:04 -0500
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "David S. Miller" <davem@redhat.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031106122723.5cbe1b6d.davem@redhat.com>
References: <1068140199.12287.246.camel@nosferatu.lan>
	 <20031106093746.5cc8066e.davem@redhat.com>
	 <1068143563.12287.264.camel@nosferatu.lan>
	 <1068144179.12287.283.camel@nosferatu.lan>
	 <20031106113716.7382e5d2.davem@redhat.com>
	 <1068149368.12287.331.camel@nosferatu.lan>
	 <20031106120548.097ccc7c.davem@redhat.com>
	 <1068150552.12287.349.camel@nosferatu.lan>
	 <20031106122723.5cbe1b6d.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4Ple0ApkmA87fVJrpMO7"
Message-Id: <1068153535.12287.355.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 23:18:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4Ple0ApkmA87fVJrpMO7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 22:27, David S. Miller wrote:
> On Thu, 06 Nov 2003 22:29:12 +0200
> Martin Schlemmer <azarah@gentoo.org> wrote:
>=20
> > If you look at asm/types.h, u64 is kernel only namespace, so in
> > theory that code will not be in userspace.
>=20
> Replace u64 with __u64 in my examples, the point still stances.
>=20
>=20
> > #else
> > <code without __u64>
> > ..
> > #endif
>=20
> This may not be possible.  You cannot account for every internal
> thing that kernel header routines might need to do or work with.
> Many structures, which the userspace can't control the layout
> of etc., makes use of the __u64 type, and we can't just turn off
> all those things just because -ansi was specified.
>=20
> We're talking about things like structures that define the userspace
> ABI into the kernel, they use things like __u64.  So what effectively
> this means is that when you compile with -ansi you are effectively
> turning off access to several userspace ABIs into the kernel.
>=20
> And this isn't going to be only some obscrure feature like some
> CDROM ioctl or whatever, things like "struct stat" use the 64-bit types
> either directly or indirectly.

Ok - say for instance then you were to write the abi headers - how would
you handle a case like this that -ansi forbid type long long, but it
have to be in the struct userspace uses to pass data to the
kernel/device ?


Thanks,

--=20

Martin Schlemmer




--=-4Ple0ApkmA87fVJrpMO7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qrq/qburzKaJYLYRApVfAKCK1BpSweqkIOriiE45ScZEAdKVKACeLdSA
laywnfETfJnRoYK6HNcTxNM=
=oa99
-----END PGP SIGNATURE-----

--=-4Ple0ApkmA87fVJrpMO7--

