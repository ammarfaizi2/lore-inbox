Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTGRNqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271469AbTGRNqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:46:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7557
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270237AbTGRNqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:46:14 -0400
Date: Fri, 18 Jul 2003 15:00:32 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181400.h6IE0WRX017624@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: mtrr printk levels
Cc: davej@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/i386/kernel/cpu/mtrr/cyrix.c linux-2.6.0-test1-ac2/arch/i386/kernel/cpu/mtrr/cyrix.c
--- linux-2.6.0-test1/arch/i386/kernel/cpu/mtrr/cyrix.c	2003-07-10 21:10:26.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/i386/kernel/cpu/mtrr/cyrix.c	2003-07-15 18:05:00.000000000 +0100
@@ -330,16 +330,16 @@
 	set_mtrr_done(&ctxt);	/* flush cache and disable MAPEN */
 
 	if (ccrc[5])
-		printk("mtrr: ARR usage was not enabled, enabled manually\n");
+		printk(KERN_INFO "mtrr: ARR usage was not enabled, enabled manually\n");
 	if (ccrc[3])
-		printk("mtrr: ARR3 cannot be changed\n");
+		printk(KERN_INFO "mtrr: ARR3 cannot be changed\n");
 /*
     if ( ccrc[1] & 0x80) printk ("mtrr: SMM memory access through ARR3 disabled\n");
     if ( ccrc[1] & 0x04) printk ("mtrr: SMM memory access disabled\n");
     if ( ccrc[1] & 0x02) printk ("mtrr: SMM mode disabled\n");
 */
 	if (ccrc[6])
-		printk("mtrr: ARR3 was write protected, unprotected\n");
+		printk(KERN_INFO "mtrr: ARR3 was write protected, unprotected\n");
 }
 
 static struct mtrr_ops cyrix_mtrr_ops = {
