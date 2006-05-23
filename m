Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWEWSxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWEWSxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWEWSxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:53:33 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:20920 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932263AbWEWSxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:53:32 -0400
Date: Tue, 23 May 2006 20:53:31 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] -mm: make debug_mutex_on __read_mostly
Message-ID: <20060523185331.GB10827@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

i386 run-tested on 2.6.17-rc4-mm3.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/kernel/mutex-debug.c linux-2.6.17-rc4-mm3.my/kernel/mutex-debug.c
--- linux-2.6.17-rc4-mm3.orig/kernel/mutex-debug.c	2006-05-23 19:14:17.000000000 +0200
+++ linux-2.6.17-rc4-mm3/kernel/mutex-debug.c	2006-05-23 16:58:49.000000000 +0200
@@ -48,7 +48,7 @@
  * into the tracing code when doing error printk or
  * executing a BUG():
  */
-int debug_mutex_on = 1;
+int debug_mutex_on __read_mostly = 1;
 
 static void printk_task(struct task_struct *p)
 {
