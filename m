Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVKTXKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVKTXKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVKTXKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:10:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932113AbVKTXKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:10:01 -0500
Date: Mon, 21 Nov 2005 00:10:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bcollins@debian.org, scjody@steamballoon.com
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/ieee1394/csr1212.c: remove dead code
Message-ID: <20051120231000.GE16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted that the same check was already done above.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/csr1212.c.old	2005-11-20 22:50:14.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/csr1212.c	2005-11-20 22:50:36.000000000 +0100
@@ -1616,12 +1616,8 @@
 	 * and make cache regions for them */
 	for (dentry = csr->root_kv->value.directory.dentries_head;
 	     dentry; dentry = dentry->next) {
-		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
+		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM)
 			csr1212_get_keyval(csr, dentry->kv);
-
-			if (ret != CSR1212_SUCCESS)
-				return ret;
-		}
 	}
 
 	return CSR1212_SUCCESS;

