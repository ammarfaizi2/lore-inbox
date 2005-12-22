Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVLVEuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVLVEuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVLVEuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:50:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23760 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965064AbVLVEuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:05 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 12/36] m68k: static vs. extern in sun3ints.h
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOy-0004rH-I5@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133436065 -0500

extern declaration of static object removed from header

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/sun3ints.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

22c9eaf700b55636c9de3623d5c28f96676d86c9
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

