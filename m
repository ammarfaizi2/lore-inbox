Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUFDUFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUFDUFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUFDUFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:05:35 -0400
Received: from bart.ott.istop.com ([66.11.172.99]:49029 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S265962AbUFDUF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:05:26 -0400
Date: Fri, 4 Jun 2004 16:05:22 -0400
From: Bart Trojanowski <bart@jukie.net>
To: Sharma Sushant <sushant@cs.unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modifying struct sk_buff
Message-ID: <20040604200522.GM29389@jukie.net>
References: <40BFCA4C.2000904@cs.unm.edu> <20040604123652.GI29389@jukie.net> <Pine.LNX.4.56.0406041233120.6320@chawla.cs.unm.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tBhgiDt8dP1efIIJ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406041233120.6320@chawla.cs.unm.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Sharma Sushant <sushant@cs.unm.edu> [040604 14:48]:
> >        uint32_t                skBufId; /* by sushant */
> >        char                    cb[48];
>=20
> skBufId is the variable i added and I want to assign unique value
> to this id whenever alloc_skb is called.
> Do you think it will be fine to modify alloc_skb(..)
> and just assigning a unique value to this new variable which I added
> or will there be some side effects of this.

Looks like you can start using skBufId anytime after memset(skb, ...)
call.  I didn't look at the version of the sources you are using.  In
2.4.7-rc2 it looks fine.

-Bart

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--tBhgiDt8dP1efIIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwNYC/zRZ1SKJaI8RAvK+AJ0RNJpSuBTeiggz2nX62J7ZM0ZH3wCg7atx
6MyoAmCR4JdQbRSxtdhxLeA=
=+UVq
-----END PGP SIGNATURE-----

--tBhgiDt8dP1efIIJ--
