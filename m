Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSHLO2V>; Mon, 12 Aug 2002 10:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSHLO2V>; Mon, 12 Aug 2002 10:28:21 -0400
Received: from ppp-217-133-217-5.dialup.tiscali.it ([217.133.217.5]:19869 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S318059AbSHLO2U>;
	Mon, 12 Aug 2002 10:28:20 -0400
Subject: Re: [patch] tls-2.5.31-D4
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>
In-Reply-To: <Pine.LNX.4.44.0208121809340.20532-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121809340.20532-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-VXMkk8DMjZ5RpQKX5yAv"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 16:32:05 +0200
Message-Id: <1029162725.4531.75.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VXMkk8DMjZ5RpQKX5yAv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> the ability to change the default CS and DS segments
> as well.
This does not make any sense.
The user is free to load any selector in %cs/%ds/%es/%ss so the default
flat segments should be left alone so that a process can have the flat
segments _plus_ all the tls entries.

> although i suspect Wine needs a 16-bit entry, while
> the APM one is a 32-bit entry ...
AFAIK this only matters for code and stack segments and anyway the APM
one should be a 16-bit entry since it exists because the BIOS wrongly
assumes that it is a real-mode segment.

Anyway, isn't it better to put the user segments in a cacheline that
doesn't already lose one entry to the null selector? (and leave the
first one either empty or for BIOS/boot selectors)


--=-VXMkk8DMjZ5RpQKX5yAv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9V8bldjkty3ft5+cRAqU5AJ4xy0OvOrZjOjR6ypkXQO3t0lbWuwCgrXRg
OTuObXz1j9nOdLAXPAtBJq8=
=WntD
-----END PGP SIGNATURE-----

--=-VXMkk8DMjZ5RpQKX5yAv--
