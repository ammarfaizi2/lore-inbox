Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUEMMfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUEMMfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbUEMMfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:35:10 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:8466 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S264170AbUEMMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:35:01 -0400
Date: Thu, 13 May 2004 14:34:40 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AES i586 optimized
Message-ID: <20040513123440.GA8487@ghanima.endorphin.org>
References: <20040513110110.GA8491@ghanima.endorphin.org>
	<20040513040732.75c5999c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20040513040732.75c5999c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1085315681.622c@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2004 at 04:07:32AM -0700, Andrew Morton wrote:

> >  The following patch adds an i586 optimized implementation of AES aka
> >  Rijndael. It's following an integration strategy similiar to recent
> >  s390/z990 integration for DES/SHA1. aes-i586-glue.c, a glue layer for
> >  CryptoAPI, and aes-i586-asm.S, the actual implementation, are added to
> >  arch/i386/crypto, as well as a config section to crypto/Kconfig.
>=20
> Some benchmark figures would be useful.  Cache-cold and cache-hot.

In addition to my last mail: It recurred to me that Christian Kujau
benchmarked this patch already.

aes, C impl.,
http://nerdbynature.de/bench/prinz/2.6.0-test6/crypto/test_1/prinz-2.6.0-te=
st6-aes.txt
aes-i586,
http://nerdbynature.de/bench/prinz/2.6.0-test6/crypto/test_2/prinz-2.6.0-te=
st6-aes.txt

20% - 50% throughput gain. Avg. latency is also much better.

Just for reference: http://nerdbynature.de/bench/prinz/readme.txt

Regards, Clemens

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAo2tgW7sr9DEJLk4RAldtAKCOgB75jOWW0H4yDyHGndEWcQBkwgCfU27D
P5GZWJhwdqA1Zgbg0MF0fHA=
=63al
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
