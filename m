Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWFGVf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWFGVf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWFGVf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:35:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932424AbWFGVf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:35:56 -0400
Date: Wed, 7 Jun 2006 14:21:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Get rid of /proc/sys/proc
Message-ID: <20060607142127.37da7eb7@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The table is empty, why does it still exist?

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- a/kernel/sysctl.c	2006-04-27 11:12:54.000000000 -0700
+++ b/kernel/sysctl.c	2006-06-07 14:06:38.000000000 -0700
@@ -142,7 +142,6 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
-static ctl_table proc_table[];
 static ctl_table fs_table[];
 static ctl_table debug_table[];
 static ctl_table dev_table[];
@@ -202,12 +201,6 @@
 	},
 #endif
 	{
-		.ctl_name	= CTL_PROC,
-		.procname	= "proc",
-		.mode		= 0555,
-		.child		= proc_table,
-	},
-	{
 		.ctl_name	= CTL_FS,
 		.procname	= "fs",
 		.mode		= 0555,
@@ -918,10 +911,6 @@
 	{ .ctl_name = 0 }
 };
 
-static ctl_table proc_table[] = {
-	{ .ctl_name = 0 }
-};
-
 static ctl_table fs_table[] = {
 	{
 		.ctl_name	= FS_NRINODE,
--- a/include/linux/sysctl.h	2006-04-27 11:12:53.000000000 -0700
+++ b/include/linux/sysctl.h	2006-06-07 14:12:29.000000000 -0700
@@ -55,7 +55,7 @@
 	CTL_KERN=1,		/* General kernel info and control */
 	CTL_VM=2,		/* VM management */
 	CTL_NET=3,		/* Networking */
-	CTL_PROC=4,		/* Process info */
+	/* was CTL_PROC */
 	CTL_FS=5,		/* Filesystems */
 	CTL_DEBUG=6,		/* Debugging */
 	CTL_DEV=7,		/* Devices */
@@ -762,8 +762,6 @@
 	NET_BRIDGE_NF_FILTER_VLAN_TAGGED = 4,
 };
 
-/* CTL_PROC names: */
-
 /* CTL_FS names: */
 enum
 {
