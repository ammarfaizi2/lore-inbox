Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759618AbWLCKeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759618AbWLCKeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 05:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759619AbWLCKeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 05:34:10 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:37536 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1759618AbWLCKeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 05:34:08 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 05:30:34 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] configfs.h: Remove dead macro definitions.
Message-ID: <Pine.LNX.4.64.0612030524100.2655@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_GF 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Delete the __ATTR-related macro definitions since these are now
defined in include/linux/sysfs.h.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index a7f0150..fef6f3d 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -160,31 +160,6 @@ struct configfs_group_operations {
 	void (*drop_item)(struct config_group *group, struct config_item *item);
 };

-
-
-/**
- * Use these macros to make defining attributes easier. See include/linux/device.h
- * for examples..
- */
-
-#if 0
-#define __ATTR(_name,_mode,_show,_store) { \
-	.attr = {.ca_name = __stringify(_name), .ca_mode = _mode, .ca_owner = THIS_MODULE },	\
-	.show	= _show,					\
-	.store	= _store,					\
-}
-
-#define __ATTR_RO(_name) { \
-	.attr	= { .ca_name = __stringify(_name), .ca_mode = 0444, .ca_owner = THIS_MODULE },	\
-	.show	= _name##_show,	\
-}
-
-#define __ATTR_NULL { .attr = { .name = NULL } }
-
-#define attr_name(_attr) (_attr).attr.name
-#endif
-
-
 struct configfs_subsystem {
 	struct config_group	su_group;
 	struct semaphore	su_sem;
