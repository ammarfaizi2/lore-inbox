Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUJCNZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUJCNZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 09:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUJCNZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 09:25:32 -0400
Received: from uk134.internetdsl.tpnet.pl ([80.55.140.134]:5386 "EHLO
	mail.piramida.slask.pl") by vger.kernel.org with ESMTP
	id S267930AbUJCNZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 09:25:29 -0400
From: Krzysztof Taraszka <dzimi@pld-linux.org>
Organization: PLD Linux
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s/whirlpool_tv_template/wp512_tv_template/g
Date: Sun, 3 Oct 2004 15:24:06 +0200
User-Agent: KMail/1.7
References: <200410031310.13666.dzimi@pld-linux.org>
In-Reply-To: <200410031310.13666.dzimi@pld-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_21/XB86f0b/tANy"
Message-Id: <200410031524.06208.dzimi@pld-linux.org>
X-MIME-Warning: Serious MIME defect detected ()
X-Scan-Signature: 477c8830eb91e5710893b652c0b7da47
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_21/XB86f0b/tANy
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dnia niedziela, 3 pa=BCdziernika 2004 13:10, Krzysztof Taraszka napisa=B3:
> patch for 2.4.28-pre3-bk6, fix compilation error

uuuuups, my fault, there still exist compilation error, here is right patch.

=2D-=20
Krzysztof Taraszka                                   (dzimi@pld-linux.org)
http://cyborg.kernel.pl/~dzimi/
http://dzimi.jogger.pl/

--Boundary-00=_21/XB86f0b/tANy
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="patch-2.4.28-pre3-bk6-wp512-tcrypt.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-2.4.28-pre3-bk6-wp512-tcrypt.c.patch"

--- linux-2.4.28-pre3-bk6.orig/crypto/tcrypt.c	2004-10-03 13:03:26.000000000 +0200
+++ linux-2.4.28-pre3-bk6/crypto/tcrypt.c	2004-10-03 15:21:39.315299736 +0200
@@ -581,7 +581,7 @@
 
 		test_hash("sha384", sha384_tv_template, SHA384_TEST_VECTORS);
 		test_hash("sha512", sha512_tv_template, SHA512_TEST_VECTORS);
-		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
+		test_hash("whirlpool", wp512_tv_template, WP512_TEST_VECTORS);
 		test_deflate();		
 #ifdef CONFIG_CRYPTO_HMAC
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
@@ -688,7 +688,7 @@
 		test_cipher ("khazad", MODE_ECB, DECRYPT, khazad_dec_tv_template, KHAZAD_DEC_TEST_VECTORS);
 		break;
 	case 22:
-		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
+		test_hash("whirlpool", wp512_tv_template, WP512_TEST_VECTORS);
 		break;
 
 #ifdef CONFIG_CRYPTO_HMAC

--Boundary-00=_21/XB86f0b/tANy--
