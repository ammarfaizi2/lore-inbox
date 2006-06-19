Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWFSONA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWFSONA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWFSONA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:13:00 -0400
Received: from mout0.freenet.de ([194.97.50.131]:56721 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932448AbWFSOM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:12:59 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH  2/4] Twofish cipher - priority fix
Date: Mon, 19 Jun 2006 16:12:42 +0200
User-Agent: KMail/1.9.1
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, ak@suse.de
References: <200606041516.32969.jfritschi@freenet.de>
In-Reply-To: <200606041516.32969.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191612.42754.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is now based on the cryptodev tree.

Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

 crypto/twofish.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/crypto/twofish.c b/crypto/twofish.c
index d5ef89a..9c7f19f 100644
--- a/crypto/twofish.c
+++ b/crypto/twofish.c
@@ -181,6 +181,8 @@ static void twofish_decrypt(struct crypt
 
 static struct crypto_alg alg = {
 	.cra_name           =   "twofish",
+	.cra_driver_name    =   "twofish-generic",
+	.cra_priority       =   100,
 	.cra_flags          =   CRYPTO_ALG_TYPE_CIPHER,
 	.cra_blocksize      =   TF_BLOCK_SIZE,
 	.cra_ctxsize        =   sizeof(struct twofish_ctx),
