Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWHJT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWHJT5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWHJTzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:55:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:18321 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932671AbWHJThO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:14 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [114/145] x86_64: Don't force frame pointers for lockdep
Message-Id: <20060810193712.E9F7513C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:12 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Now that stacktrace supports dwarf2 don't force frame pointers for lockdep anymore

Cc: mingo@elte.hu
Signed-off-by: Andi Kleen <ak@suse.de>

---
 lib/Kconfig.debug |    1 -
 1 files changed, 1 deletion(-)

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -218,7 +218,6 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER
 	select KALLSYMS
 	select KALLSYMS_ALL
 
