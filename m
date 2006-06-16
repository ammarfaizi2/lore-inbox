Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWFPL7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWFPL7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWFPL7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:59:24 -0400
Received: from mout2.freenet.de ([194.97.50.155]:13229 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751306AbWFPL7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:59:22 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH  2/4] Twofish cipher - priority fix
Date: Fri, 16 Jun 2006 13:59:19 +0200
User-Agent: KMail/1.9.1
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, ak@suse.de
References: <200606041516.32969.jfritschi@freenet.de>
In-Reply-To: <200606041516.32969.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161359.19665.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patch due to the new twofish_common patch

Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

diff -uprN linux-2.6.17-rc5.twofish/crypto/twofish.c linux-2.6.17-rc5.twofish2/crypto/twofish.c
--- linux-2.6.17-rc5.twofish/crypto/twofish.c	2006-06-11 15:58:20.315984114 +0200
+++ linux-2.6.17-rc5.twofish2/crypto/twofish.c	2006-06-11 16:02:17.848687953 +0200
@@ -182,6 +182,8 @@ static void twofish_decrypt(void *cx, u8
 
 static struct crypto_alg alg = {
 	.cra_name           =   "twofish",
+	.cra_driver_name    =   "twofish-generic",
+	.cra_priority       =   100,
 	.cra_flags          =   CRYPTO_ALG_TYPE_CIPHER,
 	.cra_blocksize      =   TF_BLOCK_SIZE,
 	.cra_ctxsize        =   sizeof(struct twofish_ctx),

