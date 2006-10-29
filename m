Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWJ2MRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWJ2MRl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWJ2MRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:17:41 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55691 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932306AbWJ2MRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:17:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: Fix freezer.h breakage
Date: Sun, 29 Oct 2006 13:16:06 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610291316.07182.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make swsusp compile again.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
---
 kernel/power/disk.c |    1 +
 kernel/power/main.c |    1 +
 kernel/power/user.c |    1 +
 3 files changed, 3 insertions(+)

Index: linux-2.6.19-rc2-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/power/disk.c
+++ linux-2.6.19-rc2-mm2/kernel/power/disk.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
Index: linux-2.6.19-rc2-mm2/kernel/power/main.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/power/main.c
+++ linux-2.6.19-rc2-mm2/kernel/power/main.c
@@ -10,6 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/delay.h>
Index: linux-2.6.19-rc2-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/power/user.c
+++ linux-2.6.19-rc2-mm2/kernel/power/user.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
