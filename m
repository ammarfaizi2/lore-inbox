Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUJCLLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUJCLLl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 07:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUJCLLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 07:11:41 -0400
Received: from uk134.internetdsl.tpnet.pl ([80.55.140.134]:50186 "EHLO
	mail.piramida.slask.pl") by vger.kernel.org with ESMTP
	id S267792AbUJCLLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 07:11:39 -0400
From: Krzysztof Taraszka <dzimi@pld-linux.org>
Organization: PLD Linux
To: linux-kernel@vger.kernel.org
Subject: [PATCH] s/whirlpool_tv_template/wp512_tv_template/g
Date: Sun, 3 Oct 2004 13:10:13 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V49XBxJyHPHPLOU"
Message-Id: <200410031310.13666.dzimi@pld-linux.org>
X-MIME-Warning: Serious MIME defect detected ()
X-Scan-Signature: f2498c739a08eb396ea26c4028c8770a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_V49XBxJyHPHPLOU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

patch for 2.4.28-pre3-bk6, fix compilation error

-- 
Krzysztof Taraszka                                   (dzimi@pld-linux.org)
http://cyborg.kernel.pl/~dzimi/
http://dzimi.jogger.pl/

--Boundary-00=_V49XBxJyHPHPLOU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.4.28-pre3-bk6-wp512-tcrypt.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-2.4.28-pre3-bk6-wp512-tcrypt.c.patch"

--- linux-2.4.28-pre3-bk6.orig/crypto/tcrypt.c	2004-10-03 13:03:26.000000000 +0200
+++ linux-2.4.28-pre3-bk6/crypto/tcrypt.c	2004-10-03 13:07:49.266052776 +0200
@@ -581,7 +581,7 @@
 
 		test_hash("sha384", sha384_tv_template, SHA384_TEST_VECTORS);
 		test_hash("sha512", sha512_tv_template, SHA512_TEST_VECTORS);
-		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
+		test_hash("whirlpool", wp512_tv_template, WHIRLPOOL_TEST_VECTORS);
 		test_deflate();		
 #ifdef CONFIG_CRYPTO_HMAC
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
@@ -688,7 +688,7 @@
 		test_cipher ("khazad", MODE_ECB, DECRYPT, khazad_dec_tv_template, KHAZAD_DEC_TEST_VECTORS);
 		break;
 	case 22:
-		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
+		test_hash("whirlpool", wp512_tv_template, WHIRLPOOL_TEST_VECTORS);
 		break;
 
 #ifdef CONFIG_CRYPTO_HMAC

--Boundary-00=_V49XBxJyHPHPLOU--
