Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWDCX7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWDCX7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWDCX7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:59:53 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:33463 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964898AbWDCX7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:41 -0400
Date: Tue, 4 Apr 2006 02:00:24 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 11/13] isdn4linux: Siemens Gigaset drivers - remove forward references
Message-ID: <gigaset307x.2006.04.04.001.11@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.7@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.8@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.9@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.10@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.10@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch removes four unnecessary forward function declarations
and an obsolete E-mail address from the Siemens Gigaset drivers.
Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/asyncdata.c   |    2 
 drivers/isdn/gigaset/bas-gigaset.c |    4 -
 drivers/isdn/gigaset/common.c      |  106 +++++++++++++++++--------------------
 drivers/isdn/gigaset/ev-layer.c    |    2 
 drivers/isdn/gigaset/gigaset.h     |    2 
 drivers/isdn/gigaset/i4l.c         |    6 +-
 drivers/isdn/gigaset/proc.c        |    2 
 drivers/isdn/gigaset/usb-gigaset.c |    7 --
 8 files changed, 60 insertions(+), 71 deletions(-)

--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:44:06.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:44:29.000000000 +0200
@@ -2,7 +2,7 @@
  * Siemens Gigaset 307x driver
  * Common header file for all connection variants
  *
- * Written by Stefan Eilers <Eilers.Stefan@epost.de>
+ * Written by Stefan Eilers
  *        and Hansjoerg Lipp <hjlipp@web.de>
  *
  * =====================================================================
--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/common.c	2006-04-02 18:43:41.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/common.c	2006-04-02 18:44:29.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * Stuff used by all variants of the driver
  *
- * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>,
+ * Copyright (c) 2001 by Stefan Eilers,
  *                       Hansjoerg Lipp <hjlipp@web.de>,
  *                       Tilman Schmidt <tilman@imap.cc>.
  *
@@ -19,7 +19,7 @@
 #include <linux/moduleparam.h>
 
 /* Version Information */
-#define DRIVER_AUTHOR "Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>, Stefan Eilers <Eilers.Stefan@epost.de>"
+#define DRIVER_AUTHOR "Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>, Stefan Eilers"
 #define DRIVER_DESC "Driver for Gigaset 307x"
 
 /* Module parameters */
@@ -28,15 +28,7 @@ EXPORT_SYMBOL_GPL(gigaset_debuglevel);
 module_param_named(debug, gigaset_debuglevel, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(debug, "debug level");
 
-/*======================================================================
-  Prototypes of internal functions
- */
-
-static struct cardstate *alloc_cs(struct gigaset_driver *drv);
-static void free_cs(struct cardstate *cs);
-static void make_valid(struct cardstate *cs, unsigned mask);
-static void make_invalid(struct cardstate *cs, unsigned mask);
-
+/* driver state flags */
 #define VALID_MINOR	0x01
 #define VALID_ID	0x02
 #define ASSIGNED	0x04
@@ -400,6 +392,52 @@ static void gigaset_freebcs(struct bc_st
 	}
 }
 
+static struct cardstate *alloc_cs(struct gigaset_driver *drv)
+{
+	unsigned long flags;
+	unsigned i;
+	static struct cardstate *ret = NULL;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	for (i = 0; i < drv->minors; ++i) {
+		if (!(drv->flags[i] & VALID_MINOR)) {
+			drv->flags[i] = VALID_MINOR;
+			ret = drv->cs + i;
+		}
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
+	return ret;
+}
+
+static void free_cs(struct cardstate *cs)
+{
+	unsigned long flags;
+	struct gigaset_driver *drv = cs->driver;
+	spin_lock_irqsave(&drv->lock, flags);
+	drv->flags[cs->minor_index] = 0;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+
+static void make_valid(struct cardstate *cs, unsigned mask)
+{
+	unsigned long flags;
+	struct gigaset_driver *drv = cs->driver;
+	spin_lock_irqsave(&drv->lock, flags);
+	drv->flags[cs->minor_index] |= mask;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+
+static void make_invalid(struct cardstate *cs, unsigned mask)
+{
+	unsigned long flags;
+	struct gigaset_driver *drv = cs->driver;
+	spin_lock_irqsave(&drv->lock, flags);
+	drv->flags[cs->minor_index] &= ~mask;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+
 void gigaset_freecs(struct cardstate *cs)
 {
 	int i;
@@ -1117,52 +1155,6 @@ out1:
 }
 EXPORT_SYMBOL_GPL(gigaset_initdriver);
 
-static struct cardstate *alloc_cs(struct gigaset_driver *drv)
-{
-	unsigned long flags;
-	unsigned i;
-	static struct cardstate *ret = NULL;
-
-	spin_lock_irqsave(&drv->lock, flags);
-	for (i = 0; i < drv->minors; ++i) {
-		if (!(drv->flags[i] & VALID_MINOR)) {
-			drv->flags[i] = VALID_MINOR;
-			ret = drv->cs + i;
-		}
-		if (ret)
-			break;
-	}
-	spin_unlock_irqrestore(&drv->lock, flags);
-	return ret;
-}
-
-static void free_cs(struct cardstate *cs)
-{
-	unsigned long flags;
-	struct gigaset_driver *drv = cs->driver;
-	spin_lock_irqsave(&drv->lock, flags);
-	drv->flags[cs->minor_index] = 0;
-	spin_unlock_irqrestore(&drv->lock, flags);
-}
-
-static void make_valid(struct cardstate *cs, unsigned mask)
-{
-	unsigned long flags;
-	struct gigaset_driver *drv = cs->driver;
-	spin_lock_irqsave(&drv->lock, flags);
-	drv->flags[cs->minor_index] |= mask;
-	spin_unlock_irqrestore(&drv->lock, flags);
-}
-
-static void make_invalid(struct cardstate *cs, unsigned mask)
-{
-	unsigned long flags;
-	struct gigaset_driver *drv = cs->driver;
-	spin_lock_irqsave(&drv->lock, flags);
-	drv->flags[cs->minor_index] &= ~mask;
-	spin_unlock_irqrestore(&drv->lock, flags);
-}
-
 /* For drivers without fixed assignment device<->cardstate (usb) */
 struct cardstate *gigaset_getunassignedcs(struct gigaset_driver *drv)
 {
--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/ev-layer.c	2006-04-02 18:42:01.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/ev-layer.c	2006-04-02 18:44:29.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * Stuff used by all variants of the driver
  *
- * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>,
+ * Copyright (c) 2001 by Stefan Eilers,
  *                       Hansjoerg Lipp <hjlipp@web.de>,
  *                       Tilman Schmidt <tilman@imap.cc>.
  *
--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/i4l.c	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/i4l.c	2006-04-02 18:44:29.000000000 +0200
@@ -1,9 +1,9 @@
 /*
  * Stuff used by all variants of the driver
  *
- * Copyright (c) 2001 by Stefan Eilers (Eilers.Stefan@epost.de),
- *                       Hansjoerg Lipp (hjlipp@web.de),
- *                       Tilman Schmidt (tilman@imap.cc).
+ * Copyright (c) 2001 by Stefan Eilers,
+ *                       Hansjoerg Lipp <hjlipp@web.de>,
+ *                       Tilman Schmidt <tilman@imap.cc>.
  *
  * =====================================================================
  *	This program is free software; you can redistribute it and/or
--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/proc.c	2006-04-02 18:43:41.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/proc.c	2006-04-02 18:44:29.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * Stuff used by all variants of the driver
  *
- * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>,
+ * Copyright (c) 2001 by Stefan Eilers,
  *                       Hansjoerg Lipp <hjlipp@web.de>,
  *                       Tilman Schmidt <tilman@imap.cc>.
  *
--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:43:01.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:44:29.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2001 by Hansjoerg Lipp <hjlipp@web.de>,
  *                       Tilman Schmidt <tilman@imap.cc>,
- *                       Stefan Eilers <Eilers.Stefan@epost.de>.
+ *                       Stefan Eilers.
  *
  * Based on usb-gigaset.c.
  *
@@ -26,7 +26,7 @@
 #include <linux/moduleparam.h>
 
 /* Version Information */
-#define DRIVER_AUTHOR "Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>, Stefan Eilers <Eilers.Stefan@epost.de>"
+#define DRIVER_AUTHOR "Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>, Stefan Eilers"
 #define DRIVER_DESC "USB Driver for Gigaset 307x"
 
 
--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:43:04.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:44:31.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * USB driver for Gigaset 307x directly or using M105 Data.
  *
- * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>
+ * Copyright (c) 2001 by Stefan Eilers
  *                   and Hansjoerg Lipp <hjlipp@web.de>.
  *
  * This driver was derived from the USB skeleton driver by
@@ -25,7 +25,7 @@
 #include <linux/moduleparam.h>
 
 /* Version Information */
-#define DRIVER_AUTHOR "Hansjoerg Lipp <hjlipp@web.de>, Stefan Eilers <Eilers.Stefan@epost.de>"
+#define DRIVER_AUTHOR "Hansjoerg Lipp <hjlipp@web.de>, Stefan Eilers"
 #define DRIVER_DESC "USB Driver for Gigaset 307x using M105"
 
 /* Module parameters */
@@ -816,9 +816,6 @@ error:
 	return retval;
 }
 
-/**
- *	skel_disconnect
- */
 static void gigaset_disconnect(struct usb_interface *interface)
 {
 	struct cardstate *cs;
--- linux-2.6.16-gig-skb/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:44:06.000000000 +0200
+++ linux-2.6.16-gig-cleanup2/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:44:29.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2005 by Tilman Schmidt <tilman@imap.cc>,
  *                       Hansjoerg Lipp <hjlipp@web.de>,
- *                       Stefan Eilers <Eilers.Stefan@epost.de>.
+ *                       Stefan Eilers.
  *
  * =====================================================================
  *	This program is free software; you can redistribute it and/or
