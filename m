Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVAYLf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVAYLf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVAYLfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:35:09 -0500
Received: from [220.225.34.50] ([220.225.34.50]:5837 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S261906AbVAYLct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:32:49 -0500
From: Amit Gud <amitg@calsoftinc.com>
Organization: Calsoft Pvt. Ltd.
To: ralf@linux-mips.org
Subject: [PATCH] unified spinlock initialization arch/mips/kernel/irq.c
Date: Tue, 25 Jan 2005 17:04:21 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org, gud@eth.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251704.22504.amitg@calsoftinc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the spinlock initialization as far as possible.

Do consider applying.

Signed-off-by: Amit Gud <gud@eth.net>

--- orig/arch/mips/kernel/irq.c	2005-01-20 20:06:12.000000000 +0530
+++ linux-2.6.11-rc2/arch/mips/kernel/irq.c	2005-01-25 15:29:35.000000000 +0530
@@ -125,7 +125,7 @@ void __init init_IRQ(void)
 		irq_desc[i].action  = NULL;
 		irq_desc[i].depth   = 1;
 		irq_desc[i].handler = &no_irq_type;
-		irq_desc[i].lock = SPIN_LOCK_UNLOCKED;
+		spin_lock_init(&irq_desc[i].lock);
 	}
 
 	arch_init_irq();

