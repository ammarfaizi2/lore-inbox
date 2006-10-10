Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbWJJVxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbWJJVxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbWJJVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:52:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43451 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030535AbWJJVt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:49:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] use %p for pointers
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:49:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/sbus/char/uctrl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index ddc0681..b30372f 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -400,7 +400,7 @@ static int __init ts102_uctrl_init(void)
 	}
 
 	driver->regs->uctrl_intr = UCTRL_INTR_RXNE_REQ|UCTRL_INTR_RXNE_MSK;
-	printk("uctrl: 0x%x (irq %d)\n", driver->regs, driver->irq);
+	printk("uctrl: 0x%p (irq %d)\n", driver->regs, driver->irq);
 	uctrl_get_event_status();
 	uctrl_get_external_status();
         return 0;
-- 
1.4.2.GIT

