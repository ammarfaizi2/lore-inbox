Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWGXNTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWGXNTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWGXNTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:19:41 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:56602 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S932150AbWGXNTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:19:40 -0400
Date: Mon, 24 Jul 2006 22:19:05 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] irq: removed a extra line
Message-Id: <20060724221905.05895c9d.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060724221506.2955bbb5.yoichi_yuasa@tripeaks.co.jp>
References: <20060724221506.2955bbb5.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has removed a extra line.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X 2.6.18-rc2/Documentation/dontdiff 2.6.18-rc2-orig/kernel/irq/chip.c 2.6.18-rc2/kernel/irq/chip.c
--- 2.6.18-rc2-orig/kernel/irq/chip.c	2006-07-24 12:09:57.715492750 +0900
+++ 2.6.18-rc2/kernel/irq/chip.c	2006-07-24 12:09:44.162645750 +0900
@@ -40,10 +40,6 @@ int set_irq_chip(unsigned int irq, struc
 	spin_lock_irqsave(&desc->lock, flags);
 	irq_chip_set_defaults(chip);
 	desc->chip = chip;
-	/*
-	 * For compatibility only:
-	 */
-	desc->chip = chip;
 	spin_unlock_irqrestore(&desc->lock, flags);
 
 	return 0;

