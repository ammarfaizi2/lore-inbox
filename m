Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWFZU1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFZU1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWFZU1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:27:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22029 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751116AbWFZU05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:26:57 -0400
Date: Mon, 26 Jun 2006 22:26:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/base/bus.c: cleanups
Message-ID: <20060626202656.GZ23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make the needlessly global bus_subsys static
- #if 0 the unused find_bus()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/base/bus.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm2-full/drivers/base/bus.c.old	2006-06-26 19:46:11.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/base/bus.c	2006-06-26 20:19:01.000000000 +0200
@@ -130,7 +130,7 @@
 
 };
 
-decl_subsys(bus, &ktype_bus, NULL);
+static decl_subsys(bus, &ktype_bus, NULL);
 
 
 #ifdef CONFIG_HOTPLUG
@@ -599,12 +599,13 @@
  *
  *	Note that kset_find_obj increments bus' reference count.
  */
-
+#if 0
 struct bus_type * find_bus(char * name)
 {
 	struct kobject * k = kset_find_obj(&bus_subsys.kset, name);
 	return k ? to_bus(k) : NULL;
 }
+#endif  /*  0  */
 
 
 /**

