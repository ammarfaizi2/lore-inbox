Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264386AbTCXRPS>; Mon, 24 Mar 2003 12:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264292AbTCXQt1>; Mon, 24 Mar 2003 11:49:27 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:55018 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264291AbTCXQbB>; Mon, 24 Mar 2003 11:31:01 -0500
Message-Id: <200303241642.h2OGgC35008339@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:59 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: fix decnet compile error on newer gcc's
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/net/decnet/dn_table.c linux-2.5/net/decnet/dn_table.c
--- bk-linus/net/decnet/dn_table.c	2003-03-08 09:58:02.000000000 +0000
+++ linux-2.5/net/decnet/dn_table.c	2003-03-17 23:43:08.000000000 +0000
@@ -836,8 +836,7 @@ struct dn_fib_table *dn_fib_get_table(in
                 return NULL;
 
         if (in_interrupt() && net_ratelimit()) {
-                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table 
-from interrupt\n"); 
+                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table from interrupt\n"); 
                 return NULL;
         }
         if ((t = kmalloc(sizeof(struct dn_fib_table), GFP_KERNEL)) == NULL)
