Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUH1Qwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUH1Qwf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUH1QwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:52:23 -0400
Received: from mout1.freenet.de ([194.97.50.132]:62693 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S267457AbUH1QvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:51:14 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Date: Sat, 28 Aug 2004 18:50:11 +0200
User-Agent: KMail/1.7
References: <20040828151137.GA12772@fs.tum.de> <098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com> <20040828162633.GG12772@fs.tum.de>
In-Reply-To: <20040828162633.GG12772@fs.tum.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1763697.7q3zpjptaG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408281850.17463.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1763697.7q3zpjptaG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Adrian Bunk <bunk@fs.tum.de>:
> > Anything you put in BUG_ON() must *NOT* have side effects.
> >...
>=20
> I'd have said exactly the same some time ago, but I was convinced by=20
> Arjan that if done correctly, a BUG_ON() with side effects is possible =20
> with no extra cost even if you want to make BUG configurably do nothing.

#if is_debugging_on
# define BUG_ON(x) do { if (unlikely(x)) BUG(); } while (0)
#else
# define BUG_ON(x) do { if (x) { /* nothing */ } } while (0)
#endif

> cu
> Adrian
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


--nextPart1763697.7q3zpjptaG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMLfJFGK1OIvVOP4RAsbNAKCjbQGytDmfcm3iLByo69IsUw55bgCgzRE7
ysXOy5YeXsEp3Rf0aGhfqO0=
=G3Jn
-----END PGP SIGNATURE-----

--nextPart1763697.7q3zpjptaG--
