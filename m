Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbULYRjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbULYRjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbULYRjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:39:11 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:53120 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261549AbULYRiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:38:55 -0500
Date: Sat, 25 Dec 2004 18:35:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: kill unused variable
Message-ID: <20041225173503.GA10117@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Variable used only for writing is bad idea, please apply,
                                                                Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-cvs/kernel/power/swsusp.c	2004-12-14 20:43:42.000000000 +0100
+++ linux-cvs/kernel/power/swsusp.c	2004-12-14 20:48:31.000000000 +0100
@@ -786,7 +768,6 @@
 
 int suspend_prepare_image(void)
 {
-	unsigned int nr_needed_pages;
 	int error;
 
 	pr_debug("swsusp: critical section: \n");
@@ -799,7 +780,6 @@
 	drain_local_pages();
 	count_data_pages();
 	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
-	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 
 	error = swsusp_alloc();
 	if (error)

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
