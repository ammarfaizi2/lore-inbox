Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWFGThg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWFGThg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWFGThg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:37:36 -0400
Received: from mout0.freenet.de ([194.97.50.131]:56462 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932388AbWFGThf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:37:35 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH  2/4] Twofish cipher - priority fix
Date: Wed, 7 Jun 2006 21:37:32 +0200
User-Agent: KMail/1.9.1
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, ak@suse.de
References: <200606041516.32969.jfritschi@freenet.de>
In-Reply-To: <200606041516.32969.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606072137.32628.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
> This patch adds a proper driver name and priority to the generic c 
> implemtation to allow coexistance of c and assembler modules.
My first mail was wordwrapped. This one should be unwrapped and working:

Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

diff -uprN linux-2.6.17-rc5.twofish/crypto/twofish_c.c linux-2.6.17-rc5.twofish2/crypto/twofish_c.c
--- linux-2.6.17-rc5.twofish/crypto/twofish_c.c	2006-05-30 15:38:14.627954845 +0200
+++ linux-2.6.17-rc5.twofish2/crypto/twofish_c.c	2006-05-30 19:54:54.713680651 +0200
@@ -182,6 +182,8 @@ static void twofish_decrypt(void *cx, u8

 static struct crypto_alg alg = {
 	.cra_name           =   "twofish",
+	.cra_driver_name    =   "twofish-generic",
+	.cra_priority       =   100,
 	.cra_flags          =   CRYPTO_ALG_TYPE_CIPHER,
 	.cra_blocksize      =   TF_BLOCK_SIZE,
 	.cra_ctxsize        =   sizeof(struct twofish_ctx),
