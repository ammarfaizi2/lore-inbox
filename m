Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTA3RiS>; Thu, 30 Jan 2003 12:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTA3RiS>; Thu, 30 Jan 2003 12:38:18 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:44733
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267569AbTA3RiR>; Thu, 30 Jan 2003 12:38:17 -0500
Subject: Re: Secure usage of netfilter hooks
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Abhishek Singh <abhi@cc.gatech.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301301229130.22137-100000@novascotia-lnx.cc.gatech.edu>
References: <Pine.LNX.4.44.0301301229130.22137-100000@novascotia-lnx.cc.gatech.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-5XhnoakRM5n4De64J8xs"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Jan 2003 17:47:51 +0000
Message-Id: <1043948872.720.28.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5XhnoakRM5n4De64J8xs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-01-30 at 17:33, Abhishek Singh wrote:
> Is it possible for a netfilter hook registered during module insertion=20
> time to be removed by a userspace application (such as iptables) without=20
> the insertion of a new module?=20

Yeah, remove all rules using it and rmmod the module.

> What I am trying to do is implement a hook for secure packet processing=20
> using netfilter. If however an attacker can remove this hook without=20
> inserting a new module or compromising the kernel in some way then the=20
> security level of this hook is compromised.=20

You gotta be root to manipulate iptables. If a user could manipulate ANY
iptables rules security would already be compromised because any user
could fuck with firewall rules.

HTH

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-5XhnoakRM5n4De64J8xs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+OWVHkbV2aYZGvn0RAm0+AJ0b/3IEyAt0ZgsZS2s/xtbcrVxfcgCeMDEm
5RXQdXLDdYydHZpY+yLza58=
=4N2U
-----END PGP SIGNATURE-----

--=-5XhnoakRM5n4De64J8xs--

