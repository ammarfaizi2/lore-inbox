Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWIIElh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWIIElh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 00:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWIIElh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 00:41:37 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:63125 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S932138AbWIIElg
	(ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 00:41:36 -0400
Message-Id: <200609090437.k894bJFr019043@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3 crypto issues with encrypted disks
In-Reply-To: Your message of "Wed, 06 Sep 2006 16:15:53 +1000."
             <20060906061553.GA20723@gondor.apana.org.au>
From: Valdis.Kletnieks@vt.edu
References: <200609041602.k84G2SYc005390@turing-police.cc.vt.edu>
            <20060906061553.GA20723@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1157776630_12358P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 00:37:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1157776630_12358P
Content-Type: text/plain; charset=us-ascii

On Wed, 06 Sep 2006 16:15:53 +1000, Herbert Xu said:
>
> Thanks for the report!  I set the wrong default when I changed the
> cryptoloop init code.  This patch should fix the problem.

> -		mode = "ecb";
> +		mode = "cbc";

Confirming that this does indeed fix it, thanks.

--==_Exmh_1157776630_12358P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFAkT2cC3lWbTT17ARAopIAKDvXUCusIm+K33G6aCJ1fxAcKCcuACgzBwK
I1/3p4TR76iVcNsho9WPR84=
=qXVD
-----END PGP SIGNATURE-----

--==_Exmh_1157776630_12358P--
