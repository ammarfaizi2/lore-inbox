Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVAaH2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVAaH2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVAaH0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:26:20 -0500
Received: from waste.org ([216.27.176.166]:9964 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261939AbVAaHZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:55 -0500
Date: Mon, 31 Jan 2005 01:25:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6.687457650@selenic.com>
Message-Id: <7.687457650@selenic.com>
Subject: [PATCH 6/8] base-small: shrink futex queues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BASE_SMALL reduce futex hash table

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/kernel/futex.c
===================================================================
--- tq.orig/kernel/futex.c	2005-01-25 09:26:18.000000000 -0800
+++ tq/kernel/futex.c	2005-01-26 13:11:43.000000000 -0800
@@ -40,7 +40,7 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 
-#define FUTEX_HASHBITS 8
+#define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)
 
 /*
  * Futexes are matched on equal values of this key.
