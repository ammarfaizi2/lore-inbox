Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbTGCPyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTGCPyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:54:47 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:54268 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264590AbTGCPxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:53:53 -0400
Date: Thu, 3 Jul 2003 18:08:11 +0200 (MEST)
Message-Id: <200307031608.h63G8B1r006911@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.5.74] correct gcc bug comment in <linux/spinlock.h>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch updates include/linux/spinlock.h's comment regarding gcc
bugs for empty struct initializers, to correctly state that the bug
is present also in 2.95.x and at least early versions of 2.96 (as
reported by one Mandrake user).

/Mikael

--- linux-2.5.74/include/linux/spinlock.h.~1~	2003-07-03 12:32:46.000000000 +0200
+++ linux-2.5.74/include/linux/spinlock.h	2003-07-03 16:07:59.772534704 +0200
@@ -144,7 +144,7 @@
 	} while (0)
 #else
 /*
- * gcc versions before ~2.95 have a nasty bug with empty initializers.
+ * gcc versions up to 2.95, and early versions of 2.96, have a nasty bug with empty initializers.
  */
 #if (__GNUC__ > 2)
   typedef struct { } spinlock_t;
