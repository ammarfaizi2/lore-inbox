Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWCNU0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWCNU0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWCNU0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:26:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5612 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750834AbWCNU0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:26:38 -0500
Message-Id: <200603142025.k2EKP8Z4010175@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Adrian Bunk <bunk@stusta.de>, davem@davemloft.net,
       linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] crypto/aes.c: array overrun 
In-Reply-To: Your message of "Sat, 11 Mar 2006 13:41:16 +1100."
             <20060311024116.GA21856@gondor.apana.org.au> 
From: Valdis.Kletnieks@vt.edu
References: <20060311010339.GF21864@stusta.de>
            <20060311024116.GA21856@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142367908_9726P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 15:25:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1142367908_9726P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Mar 2006 13:41:16 +1100, Herbert Xu said:

> OK this is not pretty but it is actually correct.  Notice how we only
> overstep the mark for E_KEY but never for D_KEY.  Since D_KEY is only
> initialised after this, it is OK for us to trash the start of D_KEY.

I think a big comment block describing this behavior is called for,
as it carries an implicit requirement that D_KEY and E_KEY remain
adjacent in memory.  Anybody allocating space between them is in for
a rude awakening....


--==_Exmh_1142367908_9726P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEFyakcC3lWbTT17ARAtUpAKDHJCRZ/NSWKPiOGRrujNKyud3LcACeNrMH
1orXSdII+4IR+kbNvSNGwhI=
=eVgV
-----END PGP SIGNATURE-----

--==_Exmh_1142367908_9726P--
