Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVAGHT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVAGHT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAGHT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:19:28 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:62110 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261275AbVAGHTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:19:24 -0500
Date: Fri, 7 Jan 2005 08:18:34 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hch@lst.de
Subject: [PATCH] add EXPORT_SYMBOL for irq_exit
Message-ID: <20050107071834.GA4168@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

this patch adds the missing EXPORT_SYMBOL for irq_exit:
*** Warning: "irq_exit" [drivers/s390/net/iucv.ko] undefined!

Please apply.

Thanks,
Heiko

diff -urN linux-2.6/kernel/softirq.c linux-2.6-patched/kernel/softirq.c
--- linux-2.6/kernel/softirq.c	2005-01-07 08:02:33.000000000 +0100
+++ linux-2.6-patched/kernel/softirq.c	2005-01-07 08:09:30.000000000 +0100
@@ -169,6 +169,8 @@
 	preempt_enable_no_resched();
 }
 
+EXPORT_SYMBOL(irq_exit);
+
 /*
  * This function must run with irqs disabled!
  */
