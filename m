Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWEWSxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWEWSxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWEWSxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:53:47 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:23480 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932270AbWEWSxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:53:46 -0400
Date: Tue, 23 May 2006 20:53:45 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       Thomas Gleixner <tglx@timesys.com>
Subject: [PATCH] -mm: make rt_trace_on __read_mostly
Message-ID: <20060523185345.GC10827@rhlx01.fht-esslingen.de>
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


diff -urN linux-2.6.17-rc4-mm3.orig/kernel/rtmutex-debug.c linux-2.6.17-rc4-mm3.my/kernel/rtmutex-debug.c
--- linux-2.6.17-rc4-mm3.orig/kernel/rtmutex-debug.c	2006-05-23 19:14:17.000000000 +0200
+++ linux-2.6.17-rc4-mm3/kernel/rtmutex-debug.c	2006-05-23 16:54:46.000000000 +0200
@@ -90,7 +90,7 @@
  * into the tracing code when doing error printk or
  * executing a BUG():
  */
-int rt_trace_on = 1;
+int rt_trace_on __read_mostly = 1;
 
 void deadlock_trace_off(void)
 {
