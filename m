Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbTGRNpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270085AbTGRNpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:45:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6533
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270082AbTGRNpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:45:42 -0400
Date: Fri, 18 Jul 2003 15:00:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181400.h6IE02PB017618@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: alpha illegal->invalid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/alpha/kernel/irq.c linux-2.6.0-test1-ac2/arch/alpha/kernel/irq.c
--- linux-2.6.0-test1/arch/alpha/kernel/irq.c	2003-07-10 21:12:59.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/alpha/kernel/irq.c	2003-07-15 18:01:27.000000000 +0100
@@ -601,7 +601,7 @@
 	if ((unsigned) irq > ACTUAL_NR_IRQS && illegal_count < MAX_ILLEGAL_IRQS ) {
 		irq_err_count++;
 		illegal_count++;
-		printk(KERN_CRIT "device_interrupt: illegal interrupt %d\n",
+		printk(KERN_CRIT "device_interrupt: invalid interrupt %d\n",
 		       irq);
 		return;
 	}
