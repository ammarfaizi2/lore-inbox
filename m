Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424868AbWKQBUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424868AbWKQBUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424869AbWKQBUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:20:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59656 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424873AbWKQBTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:19:52 -0500
Date: Fri, 17 Nov 2006 02:19:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jordan Crouse <jordan.crouse@amd.com>,
       herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [-mm patch] make geode_aes_crypt() static
Message-ID: <20061117011950.GT31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-cryptodev.patch
>...
>  git trees
>...

This patch makes the needlessly global geode_aes_crypt() static.
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/crypto/geode-aes.c |    2 +-
 drivers/crypto/geode-aes.h |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/crypto/geode-aes.h.old	2006-11-16 23:17:43.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/crypto/geode-aes.h	2006-11-16 23:17:57.000000000 +0100
@@ -37,6 +37,4 @@
 	u8 iv[AES_IV_LENGTH];
 };
 
-unsigned int geode_aes_crypt(struct geode_aes_op *);
-
 #endif
--- linux-2.6.19-rc5-mm2/drivers/crypto/geode-aes.c.old	2006-11-16 23:17:12.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/crypto/geode-aes.c	2006-11-16 23:17:38.000000000 +0100
@@ -97,7 +97,7 @@
 	return counter ? 0 : 1;
 }
 
-unsigned int
+static unsigned int
 geode_aes_crypt(struct geode_aes_op *op)
 {
 

