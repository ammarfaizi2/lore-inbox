Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbTAJI4J>; Fri, 10 Jan 2003 03:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTAJI4J>; Fri, 10 Jan 2003 03:56:09 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4576
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S264702AbTAJI4I>; Fri, 10 Jan 2003 03:56:08 -0500
Date: Fri, 10 Jan 2003 01:01:13 -0800
To: davem@ninka.net
Cc: linux-kernel@vger.kernel.org
Subject: Some 2.5.55 compile problems
Message-ID: <20030110090113.GA5114@kamui>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
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
