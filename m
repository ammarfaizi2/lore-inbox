Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVDLLUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVDLLUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVDLLRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:17:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:13770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262239AbVDLKc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:58 -0400
Message-Id: <200504121032.j3CAWkNS005672@shell0.pdx.osdl.net>
Subject: [patch 133/198] kill #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER in signal.c
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@lst.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Christoph Hellwig <hch@lst.de>

Now that no architectures defines HAVE_ARCH_GET_SIGNAL_TO_DELIVER anymore
this can go away.  It was a transitional hack only.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/signal.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN kernel/signal.c~kill-ifndef-have_arch_get_signal_to_deliver-in-signalc kernel/signal.c
--- 25/kernel/signal.c~kill-ifndef-have_arch_get_signal_to_deliver-in-signalc	2005-04-12 03:21:35.653716712 -0700
+++ 25-akpm/kernel/signal.c	2005-04-12 03:21:35.658715952 -0700
@@ -1649,8 +1649,6 @@ void ptrace_notify(int exit_code)
 	spin_unlock_irq(&current->sighand->siglock);
 }
 
-#ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
-
 static void
 finish_stop(int stop_count)
 {
@@ -1962,8 +1960,6 @@ relock:
 	return signr;
 }
 
-#endif
-
 EXPORT_SYMBOL(recalc_sigpending);
 EXPORT_SYMBOL_GPL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
_
