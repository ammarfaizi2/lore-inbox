Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWJRNZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWJRNZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJRNZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:25:38 -0400
Received: from flvpn.ccur.com ([66.10.65.2]:11929 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932136AbWJRNZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:25:37 -0400
Date: Wed, 18 Oct 2006 09:25:30 -0400
From: Joe Korty <joe.korty@ccur.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.18-rt6 sysctl conflict
Message-ID: <20061018132530.GA30767@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repair conflict between 2.6.18 and preempt-rt's sysctl(2) addition.

Signed-off-by: Joe Korty <joe.korty@ccur.com>

Index: new/include/linux/sysctl.h
===================================================================
--- new.orig/include/linux/sysctl.h	2006-10-18 09:18:34.000000000 -0400
+++ new/include/linux/sysctl.h	2006-10-18 09:20:03.000000000 -0400
@@ -150,7 +150,7 @@
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
 	KERN_COMPAT_LOG=73,	/* int: print compat layer  messages */
 	KERN_MAX_LOCK_DEPTH=74,
-	KERN_TIMEOUT_GRANULARITY=73, /* int: timeout granularity in jiffies */
+	KERN_TIMEOUT_GRANULARITY=75, /* int: timeout granularity in jiffies */
 };
 
 
