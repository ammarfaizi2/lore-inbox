Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUEUKJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUEUKJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 06:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUEUKJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 06:09:23 -0400
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:14722 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265477AbUEUKJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 06:09:21 -0400
Date: Fri, 21 May 2004 12:09:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: kill unneccessary debugging
Message-ID: <20040521100913.GA908@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is no longer neccessary. We have enough pauses elsewhere, and it
works well enough that this is not needed. Please apply,
								Pavel


--- tmp/linux/kernel/power/process.c	2004-05-20 23:08:36.000000000 +0200
+++ linux/kernel/power/process.c	2004-05-21 11:50:31.000000000 +0200
@@ -13,12 +13,6 @@
 #include <linux/suspend.h>
 #include <linux/module.h>
 
-#ifdef DEBUG_SLOW
-#define MDELAY(a) mdelay(a)
-#else
-#define MDELAY(a)
-#endif
-
 /* 
  * Timeout for stopping processes
  */
@@ -121,7 +115,6 @@
 	read_unlock(&tasklist_lock);
 	schedule();
 	printk( " done\n" );
-	MDELAY(500);
 }
 
 EXPORT_SYMBOL(refrigerator);

-- 
934a471f20d6580d5aad759bf0d97ddc
