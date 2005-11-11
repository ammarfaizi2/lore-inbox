Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVKKIKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVKKIKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVKKIKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:10:46 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:17566 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751256AbVKKIKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:10:46 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] Cleanup kmem_cache_create()
Date: Fri, 11 Nov 2005 09:10:24 +0100
User-Agent: KMail/1.7.2
Cc: Matthew Dobson <colpatch@us.ibm.com>, kernel-janitors@lists.osdl.org,
       manfred@colorfullife.com, Pekka J Enberg <penberg@cs.helsinki.fi>
References: <4373DD82.8010606@us.ibm.com> <4373E011.9070508@us.ibm.com>
In-Reply-To: <4373E011.9070508@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1722313.OTyhkiMz6n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511110910.38350.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1722313.OTyhkiMz6n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 11 November 2005 01:04, Matthew Dobson wrote:
> - if (size < 4096 || fls(size - 1) =3D=3D fls(size - 1 + 3 * BYTES_PER_WO=
RD))
> + if (size < RED_ZONE_LIMIT ||
> +	fls(size - 1) =3D=3D fls(size - 1 + 3 * BYTES_PER_WORD))
>              flags |=3D SLAB_RED_ZONE|SLAB_STORE_USER;

I would suggest sth. like

if (size < RED_TONE_LIMIT
    || fls(size - 1) =3D fls(size - 1 + 3 * BYTES_PER_WORD))
	flags |=3D SLAB_RED_ZONE | SLAB_STORE_USER


Reason: A binary operator in front is a huge hint=20
	that this is a continued line.

Just compare when you go to a store next time.

	1
+	2
=2D	3
*	4

is much more readable then

1	+
2	-
3	*
4

right?


Regards

Ingo Oeser



--nextPart1722313.OTyhkiMz6n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdFH+U56oYWuOrkARAu/zAKC84MBIOYcpFRv2iZb6QkZmL8aDJwCeOndu
PeTYW02XkeVFe8ne3MeerO0=
=9BIp
-----END PGP SIGNATURE-----

--nextPart1722313.OTyhkiMz6n--
