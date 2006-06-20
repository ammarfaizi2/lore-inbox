Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWFTVYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFTVYj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWFTVYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:24:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:52665 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751136AbWFTVYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:24:05 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 8/12] Check for weak keys
Message-Id: <E1FsnhX-00079t-VX@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:23:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check for weak keys.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

54bfaad87b42a4bfe9bb0890eebc3a69d877d03e
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 966426d..5292220 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -739,7 +739,8 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 		goto out;
 	}
 	crypt_stat->tfm = crypto_alloc_tfm(crypt_stat->cipher,
-					   ECRYPTFS_DEFAULT_CHAINING_MODE);
+					   ECRYPTFS_DEFAULT_CHAINING_MODE
+					   | CRYPTO_TFM_REQ_WEAK_KEY);
 	if (crypt_stat->tfm == NULL) {
 		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): Error "
 				"initializing cipher [%s]\n",
-- 
1.3.3

