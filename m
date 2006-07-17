Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWGQI7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWGQI7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 04:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWGQI7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 04:59:04 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:25617 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S1750795AbWGQI7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 04:59:03 -0400
Date: Mon, 17 Jul 2006 17:58:50 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] always define IRQ_PER_CPU
Message-Id: <20060717175850.7eefdb45.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has changed to be always defined IRQ_PER_CPU.
I think that it has no problem.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X linux-2.6.18-rc1-mm1/Documentation/dontdiff linux-2.6.18-rc1-mm1-orig/include/linux/irq.h linux-2.6.18-rc1-mm1/include/linux/irq.h
--- linux-2.6.18-rc1-mm1-orig/include/linux/irq.h	2006-07-14 11:38:15.488772000 +0900
+++ linux-2.6.18-rc1-mm1/include/linux/irq.h	2006-07-14 11:39:00.319573750 +0900
@@ -47,8 +47,8 @@
 #define IRQ_WAITING		0x00200000	/* IRQ not yet seen - for autodetection */
 #define IRQ_LEVEL		0x00400000	/* IRQ level triggered */
 #define IRQ_MASKED		0x00800000	/* IRQ masked - shouldn't be seen again */
+#define IRQ_PER_CPU		0x01000000	/* IRQ is per CPU */
 #ifdef CONFIG_IRQ_PER_CPU
-# define IRQ_PER_CPU		0x01000000	/* IRQ is per CPU */
 # define CHECK_IRQ_PER_CPU(var) ((var) & IRQ_PER_CPU)
 #else
 # define CHECK_IRQ_PER_CPU(var) 0
