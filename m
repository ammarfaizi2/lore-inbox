Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWENXnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWENXnm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 19:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWENXnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 19:43:42 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:58263 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751400AbWENXnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 19:43:41 -0400
Date: Sun, 14 May 2006 19:36:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.7.17-rc4] i386: remove junk from stack dump
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200605141939_MC3-1-BFC1-F4C3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 stack dump has a "<0>" in the middle of the line and an extra space
between columns in multicolumn mode.  Remove those and also remove an
extra blank line of source code.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Can we get this in 2.6.17-final?

--- 2.6.17-rc4-d4.orig/arch/i386/kernel/traps.c
+++ 2.6.17-rc4-d4/arch/i386/kernel/traps.c
@@ -130,9 +130,8 @@ static inline int print_addr_and_symbol(
 	print_symbol("%s", addr);
 
 	printed = (printed + 1) % CONFIG_STACK_BACKTRACE_COLS;
-
 	if (printed)
-		printk("  ");
+		printk(" ");
 	else
 		printk("\n");
 
@@ -212,7 +211,6 @@ static void show_stack_log_lvl(struct ta
 	}
 
 	stack = esp;
-	printk(log_lvl);
 	for(i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
 			break;
-- 
Chuck

"The x86 isn't all that complex -- it just doesn't make a lot of sense."
                                                        -- Mike Johnson
