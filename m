Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSHHWHz>; Thu, 8 Aug 2002 18:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSHHWHy>; Thu, 8 Aug 2002 18:07:54 -0400
Received: from ppp-217-133-219-100.dialup.tiscali.it ([217.133.219.100]:28069
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318027AbSHHWHx>; Thu, 8 Aug 2002 18:07:53 -0400
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Luca Barbieri <ldb@ldb.ods.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208082357170.8911-100000@serv>
References: <Pine.LNX.4.44.0208082357170.8911-100000@serv>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-K6l+RS9sDatQluOl+1sb"
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 00:11:21 +0200
Message-Id: <1028844681.1669.80.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K6l+RS9sDatQluOl+1sb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Why did you change m68k? It was fine before.

- Didn't implement atomic_{add,sub,inc,dec}_return. This is currently
not used in the generic kernel but it can be useful.
- Had inline assembly for things the compiler should be able to generate
on its own
- Didn't work on SMP (irrelevant in practice, but we already need that
in asm-generic/atomic.h for parisc so m68k gets it for free)

The actual assembly generated should be the same and the header is
shorter.

The only problem is that it may introduce bugs. Does it work on m68k?


--=-K6l+RS9sDatQluOl+1sb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UuyJdjkty3ft5+cRAo40AJ4sgAJVFr2yzNSfCFeyB8USvjq8XgCbBohB
/HD18mau4j/0baybE2bOd+c=
=I+4X
-----END PGP SIGNATURE-----

--=-K6l+RS9sDatQluOl+1sb--
