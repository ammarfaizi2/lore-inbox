Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUGZW7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUGZW7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUGZW7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:59:43 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:59915 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S266149AbUGZW7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:59:38 -0400
Subject: Re: [PATCH] Delete cryptoloop
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41054966.2D74437E@users.sourceforge.net>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
	<41039CAC.965AB0AA@users.sourceforge.net>
	<1090761870.10988.71.camel@ghanima>
	<4103ED18.FF2BC217@users.sourceforge.net>
	<1090778567.10988.375.camel@ghanima>
	<4104E2CC.D8CBA56@users.sourceforge.net>
	<1090845926.13338.98.camel@ghanima>
	<41054966.2D74437E@users.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-l6kmttw3kDoJGVfwf5Gu"
Message-Id: <1090882773.13338.128.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jul 2004 00:59:33 +0200
From: Fruhwirth Clemens <clemens-dated-1091746774.c9dd@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l6kmttw3kDoJGVfwf5Gu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-26 at 20:11, Jari Ruusu wrote:

> Fruhwirth, what you have failed to understand is that the exploit does do=
es
> not exploit flaws in any cipher, but cryptoloop's and dm-crypt's insecure
> use of those ciphers. Any block cipher that encrypts two identical plaint=
ext
> blocks using same key and produces two identical ciphertext blocks will d=
o.
> It is all about tricking a cipher to encrypt two identical plaintext bloc=
ks,
> which, after encryption will show up as two identical ciptext blocks. And
> those identical ciphertext blocks can be easily detected and counted.

Rusuu, you failed to understand that I not only understood your attack,
but also disregard it as minor imperfection (warning: personal opinion).

Reason:
This watermarking evidence can't be used at court, because it does not
reveal the content (at least not in my country!). Even if the
watermarking domain has a bigger cardinality than 32, I doubt the
practical implications.

However, if you haven't understood it already, one more time just for
you: I vote for changing the IV scheme, see my posting from 23.2.2004
[1]. But as you might not know (because you never contributed anything
substantial to the kernel): Kernel developers try to get things right,
and using CryptoAPI for hashing IVs results in some problems if one
wants to avoid reinitializing the context every call:=20

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107721067317841&w=3D2

[1] http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107749648717666&w=3D=
2
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-l6kmttw3kDoJGVfwf5Gu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBYzVW7sr9DEJLk4RAi7cAJ9uYxWP9pjnK0tE0SusUrLOMKs1VACdHef2
a6glk/D9zGT+6QTf0TxT7fQ=
=7SIF
-----END PGP SIGNATURE-----

--=-l6kmttw3kDoJGVfwf5Gu--
