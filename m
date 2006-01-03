Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWACXkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWACXkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWACX1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58331 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965012AbWACX1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:21 -0500
To: torvalds@osdl.org
Subject: [PATCH 11/41] m68k: static vs. extern in sun3ints.h
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvYm-0003M6-HK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133436065 -0500

extern declaration of static object removed from header

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/sun3ints.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

f33e6f301dce1b473159d375a1eb2d0d8416b37c
diff --git a/include/asm-m68k/sun3ints.h b/include/asm-m68k/sun3ints.h
index fd838eb..bd038fc 100644
--- a/include/asm-m68k/sun3ints.h
+++ b/include/asm-m68k/sun3ints.h
@@ -31,7 +31,6 @@ int sun3_request_irq(unsigned int irq,
 		    );
 extern void sun3_init_IRQ (void);
 extern irqreturn_t (*sun3_default_handler[]) (int, void *, struct pt_regs *);
-extern irqreturn_t (*sun3_inthandler[]) (int, void *, struct pt_regs *);
 extern void sun3_free_irq (unsigned int irq, void *dev_id);
 extern void sun3_enable_interrupts (void);
 extern void sun3_disable_interrupts (void);
-- 
0.99.9.GIT

