Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVC0UfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVC0UfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVC0UfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:35:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18704 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261528AbVC0Uej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:34:39 -0500
Date: Sun, 27 Mar 2005 22:34:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix NCR53C9x.c compile warning
Message-ID: <20050327203437.GU4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning:

  CC [M]  drivers/scsi/NCR53C9x.o
drivers/scsi/NCR53C9x.c: In function `esp_do_data':
drivers/scsi/NCR53C9x.c:1838: warning: unused variable `flags'

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

---

This patch was already sent on:
- 12 Aug 2004
- 20 Dec 2003

--- linux-2.6.0-test11-mm1-modular-no-smp/drivers/scsi/NCR53C9x.c.old	2003-12-19 23:26:15.000000000 +0100
+++ linux-2.6.0-test11-mm1-modular-no-smp/drivers/scsi/NCR53C9x.c	2003-12-19 23:27:10.000000000 +0100
@@ -1835,7 +1835,10 @@
 		/* loop */
 		while (hmuch) {
 			int j, fifo_stuck = 0, newphase;
-			unsigned long flags, timeout;
+			unsigned long timeout;
+#if 0
+			unsigned long flags;
+#endif
 #if 0
 			if ( i % 10 )
 				ESPDATA(("\r"));



