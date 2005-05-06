Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVEFVd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVEFVd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEFVd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:33:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59397 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261265AbVEFVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:32:51 -0400
Date: Fri, 6 May 2005 23:32:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] net/ieee80211/: make two functions static
Message-ID: <20050506213238.GS3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ieee80211/ieee80211_crypt_ccmp.c |    4 ++--
 net/ieee80211/ieee80211_tx.c         |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc3-mm2-full/net/ieee80211/ieee80211_crypt_ccmp.c.old	2005-05-05 02:29:22.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/ieee80211/ieee80211_crypt_ccmp.c	2005-05-05 02:29:35.000000000 +0200
@@ -59,8 +59,8 @@
 	u8 rx_b0[AES_BLOCK_LEN], rx_b[AES_BLOCK_LEN], rx_a[AES_BLOCK_LEN];
 };
 
-void ieee80211_ccmp_aes_encrypt(struct crypto_tfm *tfm,
-			     const u8 pt[16], u8 ct[16])
+static void ieee80211_ccmp_aes_encrypt(struct crypto_tfm *tfm,
+				       const u8 pt[16], u8 ct[16])
 {
 	struct scatterlist src, dst;
 
--- linux-2.6.12-rc3-mm2-full/net/ieee80211/ieee80211_tx.c.old	2005-05-05 02:29:51.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/ieee80211/ieee80211_tx.c	2005-05-05 02:29:59.000000000 +0200
@@ -211,8 +211,8 @@
 	kfree(txb);
 }
 
-struct ieee80211_txb *ieee80211_alloc_txb(int nr_frags, int txb_size,
-					  int gfp_mask)
+static struct ieee80211_txb *ieee80211_alloc_txb(int nr_frags, int txb_size,
+						 int gfp_mask)
 {
 	struct ieee80211_txb *txb;
 	int i;

