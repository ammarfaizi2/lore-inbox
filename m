Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVG1Qjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVG1Qjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVG1Qhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:37:43 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:44045 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261594AbVG1QeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:34:12 -0400
Message-Id: <200507281626.j6SGQrKe009502@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Christophe Lucas <clucas@rotomalug.org>,
       Domen Puncer <domen@coderock.org>
Subject: [PATCH 7/7] UML - Clean up prink calls
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jul 2005 12:26:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>

printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/mconsole_kern.c	2005-07-27 16:39:27.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/mconsole_kern.c	2005-07-27 16:39:53.000000000 -0400
@@ -557,7 +557,7 @@
 
 	ent = create_proc_entry("mconsole", S_IFREG | 0200, NULL);
 	if(ent == NULL){
-		printk("create_proc_mconsole : create_proc_entry failed\n");
+		printk(KERN_INFO "create_proc_mconsole : create_proc_entry failed\n");
 		return(0);
 	}
 
Index: linux-2.6.12/arch/um/kernel/exitcode.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/exitcode.c	2005-07-27 16:39:26.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/exitcode.c	2005-07-27 16:39:53.000000000 -0400
@@ -48,7 +48,7 @@
 
 	ent = create_proc_entry("exitcode", 0600, &proc_root);
 	if(ent == NULL){
-		printk("make_proc_exitcode : Failed to register "
+		printk(KERN_WARNING "make_proc_exitcode : Failed to register "
 		       "/proc/exitcode\n");
 		return(0);
 	}
Index: linux-2.6.12/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process_kern.c	2005-07-27 16:39:29.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process_kern.c	2005-07-27 16:39:53.000000000 -0400
@@ -412,7 +412,7 @@
 
 	if (ent == NULL)
 	{
-		printk("Failed to register /proc/sysemu\n");
+		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
 		return(0);
 	}
 

