Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUHEN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUHEN5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUHENzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:55:55 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:2797 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S267702AbUHENwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:52:12 -0400
Message-ID: <41123B7E.2060601@suse.cz>
Date: Thu, 05 Aug 2004 15:51:58 +0200
From: Michal Ludvig <mludvig@suse.cz>
Organization: SuSE CR, s.r.o.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040606
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: [PATCH]
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD6FCB184F04727152A68D972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6FCB184F04727152A68D972
Content-Type: multipart/mixed;
 boundary="------------090909080804020304010009"

This is a multi-part message in MIME format.
--------------090909080804020304010009
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi James,

the aes-i586 patch recently added to BK breaks compilation of AES on
non-i586 platforms. Attached patch fixes it.

BTW Why was the config option renamed to CRYPTO_AES_GENERIC? The
optimized implementations had their own names anyway (e.g.
CRYPTO_AES_586) and wouldn't collide. Couldn't we revert this little change?

Michal Ludvig
-- 
SUSE Labs                    mludvig@suse.cz
(+420) 296.542.396        http://www.suse.cz
Personal homepage http://www.logix.cz/michal

--------------090909080804020304010009
Content-Type: text/plain;
 name="build-crypto-aes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build-crypto-aes"

Index: linux-2.6.7/crypto/Makefile
===================================================================
--- linux-2.6.7.orig/crypto/Makefile	2004-08-05 17:44:32.428599792 +0200
+++ linux-2.6.7/crypto/Makefile	2004-08-05 17:46:07.589133192 +0200
@@ -18,7 +18,7 @@
 obj-$(CONFIG_CRYPTO_BLOWFISH) += blowfish.o
 obj-$(CONFIG_CRYPTO_TWOFISH) += twofish.o
 obj-$(CONFIG_CRYPTO_SERPENT) += serpent.o
-obj-$(CONFIG_CRYPTO_AES) += aes.o
+obj-$(CONFIG_CRYPTO_AES_GENERIC) += aes.o
 obj-$(CONFIG_CRYPTO_CAST5) += cast5.o
 obj-$(CONFIG_CRYPTO_CAST6) += cast6.o
 obj-$(CONFIG_CRYPTO_ARC4) += arc4.o

--------------090909080804020304010009--

--------------enigD6FCB184F04727152A68D972
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBEjuFDDolCcRbIhgRAmfEAJ9/s/UeSbmL4CQOyiM/pQ9J/gMQQgCgxRu8
yXcpoTIrXpVDnBaP8CADnnQ=
=2SNr
-----END PGP SIGNATURE-----

--------------enigD6FCB184F04727152A68D972--
