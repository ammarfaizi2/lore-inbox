Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWFTVXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWFTVXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFTVXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:23:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:13790 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751135AbWFTVXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:23:15 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 3/12] Add codes for additional ciphers
Message-Id: <E1Fsngj-00078s-R0@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:23:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few codes for additional ciphers to be supported by eCryptfs,
enabled by future patches in this set.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

339e1f091cdadd99ee536c058f31ba28682fac88
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 5de537c..c278c20 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1018,10 +1018,14 @@ struct ecryptfs_cipher_code_str_map_elem
 /* List in order of probability. */
 static struct ecryptfs_cipher_code_str_map_elem
 ecryptfs_cipher_code_str_map[] = {
-	{"aes", 0x07},
+	{"aes", 0x07}, /* AES-128 */
 	{"blowfish", 0x04},
 	{"des3_ede", 0x02},
-	{"cast5", 0x03}
+	{"cast5", 0x03},
+	{"twofish", 0x0a},
+	{"cast6", 0x0b},
+	{"aes", 0x08}, /* AES-192 */
+	{"aes", 0x09} /* AES-256 */
 };
 
 /**
-- 
1.3.3

