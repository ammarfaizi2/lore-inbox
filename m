Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbTHJUVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270645AbTHJUVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:21:55 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:9351 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270641AbTHJUVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:21:53 -0400
Date: Sun, 10 Aug 2003 22:21:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Small cleanups
Message-ID: <20030810202130.GA14001@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Few small cleanups, please apply.
						Pavel

--- /usr/src/tmp/linux/kernel/power/console.c	2003-08-10 21:23:36.000000000 +0200
+++ /usr/src/linux/kernel/power/console.c	2003-08-10 22:07:12.000000000 +0200
@@ -1,3 +1,9 @@
+/*
+ * drivers/power/process.c - Functions for saving/restoring console.
+ *
+ * Originally from swsusp.
+ */
+
 #include <linux/vt_kern.h>
 #include <linux/kbd_kern.h>
 #include "power.h"
@@ -14,13 +20,13 @@
 #ifdef SUSPEND_CONSOLE
 	orig_fgconsole = fg_console;
 
-	if(vc_allocate(SUSPEND_CONSOLE))
+	if (vc_allocate(SUSPEND_CONSOLE))
 	  /* we can't have a free VC for now. Too bad,
 	   * we don't want to mess the screen for now. */
 		return 1;
 
-	set_console (SUSPEND_CONSOLE);
-	if(vt_waitactive(SUSPEND_CONSOLE)) {
+	set_console(SUSPEND_CONSOLE);
+	if (vt_waitactive(SUSPEND_CONSOLE)) {
 		pr_debug("Suspend: Can't switch VCs.");
 		return 1;
 	}
@@ -34,7 +40,7 @@
 {
 	console_loglevel = orig_loglevel;
 #ifdef SUSPEND_CONSOLE
-	set_console (orig_fgconsole);
+	set_console(orig_fgconsole);
 #endif
 	return;
 }
--- /usr/src/tmp/linux/kernel/power/swsusp.c	2003-08-10 21:23:36.000000000 +0200
+++ /usr/src/linux/kernel/power/swsusp.c	2003-08-10 22:08:09.000000000 +0200
@@ -504,7 +508,7 @@
 		device_resume(RESUME_ENABLE);
 	}
   	if (flags & RESUME_PHASE2) {
-		if(pm_suspend_state) {
+		if (pm_suspend_state) {
 			if(pm_send_all(PM_RESUME,(void *)0))
 				printk(KERN_WARNING "Problem while sending resume event\n");
 			pm_suspend_state=0;
@@ -715,7 +719,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if (drivers_suspend()==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
