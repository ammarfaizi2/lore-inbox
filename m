Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVAaHcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVAaHcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVAaH3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:29:53 -0500
Received: from waste.org ([216.27.176.166]:10476 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261934AbVAaHZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:58 -0500
Date: Mon, 31 Jan 2005 01:25:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7.687457650@selenic.com>
Message-Id: <8.687457650@selenic.com>
Subject: [PATCH 7/8] base-small: shrink timer hashes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BASE_SMALL reduce timer list hashes

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/kernel/timer.c
===================================================================
--- mm2.orig/kernel/timer.c	2005-01-30 21:26:28.000000000 -0800
+++ mm2/kernel/timer.c	2005-01-30 21:51:16.000000000 -0800
@@ -51,8 +51,9 @@
 /*
  * per-CPU timer vector definitions:
  */
-#define TVN_BITS 6
-#define TVR_BITS 8
+
+#define TVN_BITS (CONFIG_BASE_SMALL ? 4 : 6)
+#define TVR_BITS (CONFIG_BASE_SMALL ? 6 : 8)
 #define TVN_SIZE (1 << TVN_BITS)
 #define TVR_SIZE (1 << TVR_BITS)
 #define TVN_MASK (TVN_SIZE - 1)
