Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751998AbWJXEsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbWJXEsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 00:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWJXEsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 00:48:00 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:53409 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751998AbWJXEr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 00:47:59 -0400
Date: Mon, 23 Oct 2006 21:43:30 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: bcasavan@sgi.com, akpm <akpm@osdl.org>
Subject: [PATCH] ioc4: fix printk format warning
Message-Id: <20061023214330.04657b3c.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warning:
drivers/misc/ioc4.c:213: warning: long long int format, u64 arg (arg 3)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---

 drivers/misc/ioc4.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2619-rc3-pv.orig/drivers/misc/ioc4.c
+++ linux-2619-rc3-pv/drivers/misc/ioc4.c
@@ -209,8 +209,8 @@ ioc4_clock_calibrate(struct ioc4_driver_
 
 		do_div(ns, IOC4_EXTINT_COUNT_DIVISOR);
 		printk(KERN_DEBUG
-		       "IOC4 %s: PCI clock is %lld ns.\n",
-		       pci_name(idd->idd_pdev), ns);
+		       "IOC4 %s: PCI clock is %llu ns.\n",
+		       pci_name(idd->idd_pdev), (unsigned long long)ns);
 	}
 
 	/* Remember results.  We store the extint clock period rather


---
