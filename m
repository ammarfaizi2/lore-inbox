Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318893AbSH1QMV>; Wed, 28 Aug 2002 12:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318894AbSH1QMV>; Wed, 28 Aug 2002 12:12:21 -0400
Received: from ppp-217-133-221-76.dialup.tiscali.it ([217.133.221.76]:21405
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318893AbSH1QMQ>; Wed, 28 Aug 2002 12:12:16 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Luca Barbieri <ldb@ldb.ods.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <15724.61927.221405.274843@kim.it.uu.se>
References: <1030506106.1489.27.camel@ldb> 
	<15724.61927.221405.274843@kim.it.uu.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ec5sNgfm9qlkownYNeeB"
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 18:16:30 +0200
Message-Id: <1030551390.1489.63.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ec5sNgfm9qlkownYNeeB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I've tried this sort of thing before (unsynchronised cross-modifying code),
> but I had to abandon it due to Pentium III Erratum E49 and similar errata
> for all Intel P6 CPUs. Have you verified that you're not hitting this erratum?
It is indeed completely hitting it.
However, we can work around this by simply stopping all other CPUs in
interrupt context with an IPI (while this may sound horrible, it
shouldn't significantly impact performance unless the response time is
excessively long).

I'll write some code to this. However I don't have the hardware to test
it, so it might require multiple iterations to get it right.

As for the "all Intel P6 CPUs" are really _all_ Intel P6 CPU broken? 
Do you know of any other CPU that would need the workaround?


--=-ec5sNgfm9qlkownYNeeB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bPdedjkty3ft5+cRAskXAJ9wPmv57EmeMfie+txqpneM7drXnwCgqK2F
sedMXPTrO+MyHsZHosspBkA=
=T9OB
-----END PGP SIGNATURE-----

--=-ec5sNgfm9qlkownYNeeB--
