Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTICQaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTICQ3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:29:16 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:19086 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263898AbTICQ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:27:42 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Message-Id: <1062606456.1780.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 18:27:36 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: [PATCH] PowerMac: Fix build of via-pmu driver with some .config's
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

This patch fixes build of the via-pmu.c driver when
CONFIG_PMAC_PBOOK is not set. Please apply.

Regards,
Ben.

diff -urN for-linus-ppc/drivers/macintosh/via-pmu.c linuxppc-2.5-benh/drivers/macintosh/via-pmu.c
--- for-linus-ppc/drivers/macintosh/via-pmu.c	2003-09-03 16:10:36.000000000 +0200
+++ linuxppc-2.5-benh/drivers/macintosh/via-pmu.c	2003-09-03 18:25:59.000000000 +0200
@@ -1391,10 +1391,10 @@
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
-	} else
+	} else {
 	       pmu_pass_intr(data, len);
-
 #endif /* CONFIG_PMAC_PBOOK */
+	}
 	goto next;
 }
 


