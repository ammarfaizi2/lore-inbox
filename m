Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTAJHZr>; Fri, 10 Jan 2003 02:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTAJHYy>; Fri, 10 Jan 2003 02:24:54 -0500
Received: from dp.samba.org ([66.70.73.150]:7404 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263589AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] MODULE_FORCE_UNLOAD must depend on MODULE_UNLOAD 
In-reply-to: Your message of "Wed, 08 Jan 2003 00:07:42 BST."
             <20030107230742.GO6626@fs.tum.de> 
Date: Wed, 08 Jan 2003 23:05:04 +1100
Message-Id: <20030110073328.DEED32C407@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030107230742.GO6626@fs.tum.de> you write:
> Thanks for spotting this, after reading kernel/module.c it seems obvious 
> to me that you are right. The following simple patch fixes it:

Yep.  Linus, please apply.

From: Adrian Bunk <bunk@fs.tum.de>
--- linux-2.5.54/init/Kconfig.old	2003-01-08 00:05:12.000000000 +0100
+++ linux-2.5.54/init/Kconfig	2003-01-08 00:05:38.000000000 +0100
@@ -127,7 +127,7 @@
 
 config MODULE_FORCE_UNLOAD
 	bool "Forced module unloading"
-	depends on MODULES && EXPERIMENTAL
+	depends on MODULE_UNLOAD && EXPERIMENTAL
 	help
 	  This option allows you to force a module to unload, even if the
 	  kernel believes it is unsafe: the kernel will remove the module

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
