Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbULOXzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbULOXzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbULOXzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:55:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:59042 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262526AbULOXzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:55:03 -0500
Date: Thu, 16 Dec 2004 01:05:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 1/30] return statement cleanup - kill pointless parentheses
 in kernel/time.c
Message-ID: <Pine.LNX.4.61.0412160102500.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch removes pointless parentheses from return statements in 
kernel/time.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/kernel/time.c	2004-12-06 22:24:56.000000000 +0100
+++ linux-2.6.10-rc3-bk8/kernel/time.c	2004-12-16 00:07:22.000000000 +0100
@@ -399,7 +399,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->stbcnt	   = pps_stbcnt;
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
-	return(result);
+	return result;
 }
 
 asmlinkage long sys_adjtimex(struct timex __user *txc_p)



