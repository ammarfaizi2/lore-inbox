Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVE3VI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVE3VI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVE3U5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:57:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22798 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261750AbVE3U4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:44 -0400
Date: Mon, 30 May 2005 22:56:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] net/ieee80211/: make two functions static
Message-ID: <20050530205641.GT10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 May 2005

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

