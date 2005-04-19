Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVDSAp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVDSAp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVDSAp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:45:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34572 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261226AbVDSAp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:45:27 -0400
Date: Tue, 19 Apr 2005 02:45:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: bcollins@debian.org, scjody@steamballoon.com
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/ieee1394/ieee1394_transactions.c: possible cleanups
Message-ID: <20050419004523.GK5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- #if 0 the following unused global functions:
  - hpsb_lock
  - hpsb_send_gasp
- ieee1394_transactions.h: remove the stale hpsb_lock64 prototype

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ieee1394/ieee1394_transactions.c |    3 +++
 drivers/ieee1394/ieee1394_transactions.h |    7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.h.old	2005-04-19 00:24:13.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.h	2005-04-19 00:25:00.000000000 +0200
@@ -53,12 +53,5 @@
 	      u64 addr, quadlet_t *buffer, size_t length);
 int hpsb_write(struct hpsb_host *host, nodeid_t node, unsigned int generation,
 	       u64 addr, quadlet_t *buffer, size_t length);
-int hpsb_lock(struct hpsb_host *host, nodeid_t node, unsigned int generation,
-	      u64 addr, int extcode, quadlet_t *data, quadlet_t arg);
-int hpsb_lock64(struct hpsb_host *host, nodeid_t node, unsigned int generation,
-		u64 addr, int extcode, octlet_t *data, octlet_t arg);
-int hpsb_send_gasp(struct hpsb_host *host, int channel, unsigned int generation,
-                   quadlet_t *buffer, size_t length, u32 specifier_id,
-                   unsigned int version);
 
 #endif /* _IEEE1394_TRANSACTIONS_H */
--- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.c.old	2005-04-19 00:24:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.c	2005-04-19 00:24:51.000000000 +0200
@@ -535,6 +535,7 @@
         return retval;
 }
 
+#if 0
 
 int hpsb_lock(struct hpsb_host *host, nodeid_t node, unsigned int generation,
 	      u64 addr, int extcode, quadlet_t *data, quadlet_t arg)
@@ -599,3 +600,5 @@
 
 	return retval;
 }
+
+#endif  /*  0  */

