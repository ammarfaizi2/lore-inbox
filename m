Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTJGJA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 05:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTJGJA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 05:00:28 -0400
Received: from mail13.speakeasy.net ([216.254.0.213]:27028 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S261903AbTJGJAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 05:00:22 -0400
Date: Tue, 7 Oct 2003 02:00:18 -0700
Message-Id: <200310070900.h9790Ih1003046@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove unused `locks' field from task_struct 
X-Shopping-List: (1) Tropical lips
   (2) Gracious ashes
   (3) Squinty intrusions
   (4) Asymmetrical jungle combustion
   (5) Hardy bacon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SSIA.  This field is used nowhere; I had it commented out in my
"make allyesconfig" build and nothing complained.


Thanks,
Roland


Index: linux-2.6/include/linux/sched.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/linux/sched.h,v
retrieving revision 1.188
diff -p -b -u -r1.188 sched.h
--- linux-2.6/include/linux/sched.h 5 Oct 2003 18:04:11 -0000 1.188
+++ linux-2.6/include/linux/sched.h 7 Oct 2003 07:12:56 -0000
@@ -419,7 +419,6 @@ struct task_struct {
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
-	unsigned int locks; /* How many file locks are being held */
 /* ipc stuff */
 	struct sysv_sem sysvsem;
 /* CPU-specific state of this task */
