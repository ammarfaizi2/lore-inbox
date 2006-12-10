Return-Path: <linux-kernel-owner+w=401wt.eu-S1758281AbWLJLhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281AbWLJLhm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 06:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbWLJLhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 06:37:42 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:2614 "EHLO
	mx2.absolutedigital.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161AbWLJLhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 06:37:41 -0500
Date: Sun, 10 Dec 2006 06:37:38 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] include/linux/freezer.h needs PF_FREEZE and PF_FROZEN
 declarations
Message-ID: <Pine.LNX.4.64.0612100623560.8221@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JFS (modular, if it matters) fails to build with this error:

  In file included from fs/jfs/jfs_txnmgr.c:49:
  include/linux/freezer.h: In function `frozen':
  include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
  include/linux/freezer.h:9: error: `PF_FROZEN' undeclared (first use in this function)
  include/linux/freezer.h:9: error: (Each undeclared identifier is reported only once
  include/linux/freezer.h:9: error: for each function it appears in.)
  ...


From: Cal Peake <cp@absolutedigital.net>

Include include/linux/sched.h in include/linux/freezer.h for PF_FREEZE and 
PF_FROZEN declarations.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- ./include/linux/freezer.h~orig	2006-12-07 22:33:46.000000000 -0500
+++ ./include/linux/freezer.h	2006-12-10 06:15:11.000000000 -0500
@@ -1,6 +1,9 @@
 /* Freezer declarations */
 
 #ifdef CONFIG_PM
+
+#include <linux/sched.h>
+
 /*
  * Check if a process has been frozen
  */
