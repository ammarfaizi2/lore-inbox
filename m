Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVAaHcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVAaHcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVAaHaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:30:09 -0500
Received: from waste.org ([216.27.176.166]:10732 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261940AbVAaHZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:58 -0500
Date: Mon, 31 Jan 2005 01:25:53 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8.687457650@selenic.com>
Message-Id: <9.687457650@selenic.com>
Subject: [PATCH 8/8] base-small: shrink console buffer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BASE_SMALL reduce console transfer buffer

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/include/linux/vt_kern.h
===================================================================
--- mm2.orig/include/linux/vt_kern.h	2005-01-30 21:26:28.000000000 -0800
+++ mm2/include/linux/vt_kern.h	2005-01-30 21:51:19.000000000 -0800
@@ -84,7 +84,8 @@
  * vc_screen.c shares this temporary buffer with the console write code so that
  * we can easily avoid touching user space while holding the console spinlock.
  */
-#define CON_BUF_SIZE	PAGE_SIZE
+
+#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
 extern char con_buf[CON_BUF_SIZE];
 extern struct semaphore con_buf_sem;
 
