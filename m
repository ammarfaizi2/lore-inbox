Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFTNZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTFTNZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:25:58 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:48551
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S261414AbTFTNZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:25:49 -0400
Date: Fri, 20 Jun 2003 15:38:16 +0200
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c
Message-ID: <20030620133816.GA3634@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrew Morton wrote:

> Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org> wrote:
>>
>> If this bug is fixed, we can go ahead and add cryptoloop which is ready
>> and tested.
>
> Does it use the crypto framework which is present in the 2.5 kernel?

Yes.

> If it does not then the cryptoloop implementation which you mention
> is inappropriate for inclusion.
>=20
> If it does then it would be nice to see the full patchset.

http://therapy.endorphin.org/patches/cryptoloop-0.2-2.5.58.diff

It's basically a stub. The lock of the cipher_context can be removed since
post-2.5.58 a new call has been added which makes the IV an argument.
However, that's a minor change.

In case you want to test it, you need to patch losetup too, since it needs
to parse /proc/crypto.=20

http://therapy.endorphin.org/patches/losetup-2.5.diff

Regards, Clemens

p.s.: Andrew please send me carbon copies of your mails. Thanks.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+8w5IW7sr9DEJLk4RAq4QAJ0SrcZLBAHCVAwQ6Lnx5Ljfvb+dCACeKBvf
L1UULrdY1foYO+9LcvqFZ/Y=
=asJ+
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
