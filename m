Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUD1Vkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUD1Vkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUD1Vii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:38:38 -0400
Received: from gprs214-186.eurotel.cz ([160.218.214.186]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261887AbUD1Vea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:34:30 -0400
Date: Wed, 28 Apr 2004 22:59:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rddunlap@osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: make lkconfig quiet
Message-ID: <20040428205900.GA1678@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ammount of boot messages on my machine is now so big that important
info (like what went wrong with mouse) scroll away. Oops. This kills
some offenders. Please apply,
								Pavel

--- clean/kernel/configs.c	2003-09-28 22:06:44.000000000 +0200
+++ linux/kernel/configs.c	2004-04-28 22:56:49.000000000 +0200
@@ -77,8 +77,10 @@
 {
 	struct proc_dir_entry *entry;
 
+#ifdef MODULE
 	printk(KERN_INFO "ikconfig %s with /proc/config*\n",
 	       IKCONFIG_VERSION);
+#endif
 
 	/* create the current config file */
 	entry = create_proc_entry("config.gz", S_IFREG | S_IRUGO,

-- 
934a471f20d6580d5aad759bf0d97ddc
