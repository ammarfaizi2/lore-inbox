Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVEYUeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVEYUeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEYUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:34:09 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:48792 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S261550AbVEYUeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:34:03 -0400
Subject: Re: NFS corruption on 2.6.11.7
From: Kenneth Johansson <ken@kenjo.org>
To: "David S.Miller" <davem@davemloft.net>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
In-Reply-To: <20050525.131616.59655785.davem@davemloft.net>
References: <1116929711.6237.8.camel@tiger>
	 <1116936088.10707.39.camel@lade.trondhjem.org>
	 <1117052007.9884.10.camel@tiger>
	 <20050525.131616.59655785.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7wzjPmMhINxi3v1e0EsM"
Date: Wed, 25 May 2005 22:34:01 +0200
Message-Id: <1117053241.9884.18.camel@tiger>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7wzjPmMhINxi3v1e0EsM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-05-25 at 13:16 -0700, David S.Miller wrote:
> From: Kenneth Johansson <ken@kenjo.org>
> Date: Wed, 25 May 2005 22:13:27 +0200
>=20
> > Is there some fundamental difference in how nfs over upd and tcp is
> > handled regarding the packet contents like tcp using the tcp checksum
> > and udp not using the udp checksum or something like that?
> >=20
> > Are there any counters for checksum errors in udp and tcp that can be
> > read ?? I faild to spot anything in /proc.
>=20
> If you are on a gigabit or faster network, IPv4 fragment sequence
> numbers can wrap and if you are very unlucky the checksums will
> match as well corrupting your data.  This is a fatal limitation of
> the small 16-bit IPv4 framgent ID.
>=20
> Use TCP for NFS unless you want NFS data corruption.
>=20

Unlikely to be the case this time. I get a sequence of 28 bytes that is
wrong in the data and often the wrong data is a copy from data 64 or 128
byte earlier in the file. If this was not on a PC with cache coherency I
would guess that someone forgot to do a cache invalidate/flush. But I do
wonder why I only see this problem with nfs over udp.=20





--=-7wzjPmMhINxi3v1e0EsM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBClOE4mDGOmJIy9x8RAjBtAJwPJyP0b9Qvd9R/iFJplU0yZMZd+ACfeEAk
POokAzyzB1Xdwa4WjeMoVZE=
=nQLg
-----END PGP SIGNATURE-----

--=-7wzjPmMhINxi3v1e0EsM--

