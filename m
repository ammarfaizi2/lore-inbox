Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbSKCVVu>; Sun, 3 Nov 2002 16:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSKCVVu>; Sun, 3 Nov 2002 16:21:50 -0500
Received: from ua133d34hel.dial.kolumbus.fi ([62.248.232.133]:50987 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S262488AbSKCVVt>; Sun, 3 Nov 2002 16:21:49 -0500
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is
	ugly
From: Jussi Laako <jussi.laako@kolumbus.fi>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200211031925.gA3JPHp29128@Port.imtp.ilyichevsk.odessa.ua>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
	<1036340272.26281.5.camel@vaarlahti.uworld> 
	<200211031925.gA3JPHp29128@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-67TaTHsFZ60+ikLrNS58"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 23:28:05 +0200
Message-Id: <1036358886.26281.19.camel@vaarlahti.uworld>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-67TaTHsFZ60+ikLrNS58
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-11-04 at 02:17, Denis Vlasenko wrote:

> Alignment does not eliminate jump. It only moves jump target to 16 byte
> boundary.=20

Exactly. And P4 cache is _very_ bad at anything not 16-byte aligned. The
speed penalty is big. This seems to be problem only with Intel CPU's, no
such large effects on AMD ones.

> This _probably_ makes execution slightly faster but on average
> it costs you 7,5 bytes. This price is too high when you take into account
> L1 instruction cache wastage and current bus/core clock ratios.

7.5 bytes is not much compared to possibility of trashed cache or
pipeline flush.
Do you have execution time numbers of jump to 16-byte aligned address vs
unaligned address?


	- Jussi Laako

--=-67TaTHsFZ60+ikLrNS58
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9xZTlS3txJU4L5RQRAvvhAKC2fZBUjHjjt66FBckzET0Gd6DjRACfbkem
uFIfBVhaGXV/hLHgrREcpnc=
=2ZBM
-----END PGP SIGNATURE-----

--=-67TaTHsFZ60+ikLrNS58--

