Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTFXJ5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFXJ5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:57:01 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:63703 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261411AbTFXJ4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:56:47 -0400
Date: Tue, 24 Jun 2003 12:10:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Small cleanups for input
Message-ID: <20030624101017.GD159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are some small cleanups, please apply,
						Pavel
Index: linux/include/linux/serio.h
===================================================================
--- linux.orig/include/linux/serio.h	2003-06-24 11:54:39.000000000 +0200
+++ linux/include/linux/serio.h	2003-05-06 00:51:25.000000000 +0200
@@ -18,10 +18,7 @@
 
 #include <linux/list.h>
 
-struct serio;
-
 struct serio {
-
 	void *private;
 	void *driver;
 	char *name;
@@ -46,7 +43,6 @@
 };
 
 struct serio_dev {
-
 	void *private;
 	char *name;
 
Index: linux/drivers/input/power.c
===================================================================
--- linux.orig/drivers/input/power.c	2003-06-24 11:54:39.000000000 +0200
+++ linux/drivers/input/power.c	2003-04-18 16:19:02.000000000 +0200
@@ -45,9 +45,7 @@
 static int suspend_button_pushed = 0;
 static void suspend_button_task_handler(void *data)
 {
-        //extern void pm_do_suspend(void);
         udelay(200); /* debounce */
-        //pm_do_suspend();
         suspend_button_pushed = 0;
 }
 
@@ -67,8 +65,6 @@
 			case KEY_SUSPEND:
 				printk("Powering down entire device\n");
 
-				//pm_send_all(PM_SUSPEND, dev);
-
 				if (!suspend_button_pushed) {
                 			suspend_button_pushed = 1;
                         		schedule_work(&suspend_button_task);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
