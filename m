Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUFBQEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUFBQEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUFBQDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:03:51 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:41965 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263596AbUFBQC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:02:28 -0400
Subject: Re: [PATCH] 5/5: Device-mapper: dm-zero
From: Christophe Saout <christophe@saout.de>
To: Alasdair G Kergon <agk@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040602154605.GR6302@agk.surrey.redhat.com>
References: <20040602154605.GR6302@agk.surrey.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-odYIcnCBBSJ19oLjDCR8"
Date: Wed, 02 Jun 2004 18:02:21 +0200
Message-Id: <1086192141.4659.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-odYIcnCBBSJ19oLjDCR8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mi, den 02.06.2004 um 16:46 Uhr +0100 schrieb Alasdair G Kergon:

> +	bio_for_each_segment(bv, bio, i) {
> +		char *data =3D bvec_kmap_irq(bv, &flags);
> +		memset(data, 0, bv->bv_len);

I just noticed, there's a

		flush_dcache_page(bv->bv_page);

missing here.

> +		bvec_kunmap_irq(bv, &flags);
> +	}


--=-odYIcnCBBSJ19oLjDCR8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvfoNZCYBcts5dM0RAjZtAKCksFXPRXG8dGbHVmPAaAtjegWUNACdF/aa
Nyz0BjD9rJQ6iSRcRXtMwkQ=
=+nKV
-----END PGP SIGNATURE-----

--=-odYIcnCBBSJ19oLjDCR8--

