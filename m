Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTAJSkd>; Fri, 10 Jan 2003 13:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAJSjq>; Fri, 10 Jan 2003 13:39:46 -0500
Received: from [193.158.237.250] ([193.158.237.250]:34697 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265777AbTAJSaQ>; Fri, 10 Jan 2003 13:30:16 -0500
Date: Fri, 10 Jan 2003 19:38:52 +0100
Message-Id: <200301101838.h0AIcqc05949@mail.intergenia.de>
To: davem@ninka.net
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Subject: Some 2.5.55 compile problems [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave: (hope i'm addressing this issue to the right person!)

When making bzImage with the current BK I receive the following during=20
the final link process:

net/built-in.o(.text+0x4ba22): In function `xfrm_probe_algs':
: undefined reference to `crypto_alg_available'
net/built-in.o(.text+0x4ba68): In function `xfrm_probe_algs':
: undefined reference to `crypto_alg_available'

this is because ipv4 seems to depend on some Cryptographic API stuff...=20
that doesn't sound right though! Anyway, I added base Cryptographic API
support to shut it up, and the link went fine.

But this was definitely not added until recently - I was able to =20
compile all 2.5.54 BK cleanly. What's the deal now?

Regards
Josh

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HovZ6TRUxq22Mx4RAgy7AJ9562vM9zS09EFq5b3r6xM/DHZ1bgCgvf0N
0awrVgvTCn1st7U20vlKm1c=
=XugU
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

