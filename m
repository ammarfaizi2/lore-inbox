Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756049AbWKRAA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbWKRAA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756053AbWKRAAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:00:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39686 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756049AbWKQX7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:59:49 -0500
Date: Sat, 18 Nov 2006 00:59:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [RFC: -mm patch] make kernel/timer.c:__next_timer_interrupt() static
Message-ID: <20061117235947.GR31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global __next_timer_interrupt() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/kernel/timer.c.old	2006-11-17 19:11:49.000000000 +0100
+++ linux-2.6.19-rc5-mm2/kernel/timer.c	2006-11-17 19:12:02.000000000 +0100
@@ -621,7 +621,8 @@
  * is used on S/390 to stop all activity when a cpus is idle.
  * This functions needs to be called disabled.
  */
-unsigned long __next_timer_interrupt(tvec_base_t *base, unsigned long now)
+static unsigned long __next_timer_interrupt(tvec_base_t *base,
+					    unsigned long now)
 {
 	struct list_head *list;
 	struct timer_list *nte, *found = NULL;

