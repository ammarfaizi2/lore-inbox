Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTDRHMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbTDRHMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:12:08 -0400
Received: from dp.samba.org ([66.70.73.150]:34262 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262903AbTDRHME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:12:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] SET_MODULE_OWNER comment
Date: Fri, 18 Apr 2003 17:23:38 +1000
Message-Id: <20030418072401.8C3E52C016@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-xmit.  This should clarify when to use SET_MODULE_OWNER: some
people thought it was the One True Way to do the owner assignment.

Linus, pleae apply.
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67-bk1/include/linux/module.h working-2.5.67-bk1-set-owner/include/linux/module.h
--- linux-2.5.67-bk1/include/linux/module.h	2003-04-08 11:15:01.000000000 +1000
+++ working-2.5.67-bk1-set-owner/include/linux/module.h	2003-04-09 15:15:47.000000000 +1000
@@ -408,6 +408,12 @@ __attribute__((section(".gnu.linkonce.th
 #endif /* MODULE */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
+
+/* If you want backwards compat: some structs didn't have owner fields once */
+/* Think of SET_MODULE_OWNER like an IBM mainframe: leave it in a dark 
+   corner for years, don't break it, but don't ever upgrade it either :) 
+   If there is something newer and sexier than the mainframe, it's ok to 
+   use that instead.  The mainframe won't feel lonely. -- Jeff Garzik */
 #define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
