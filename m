Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUFQSZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUFQSZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUFQSXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:23:31 -0400
Received: from darwin.snarc.org ([81.56.210.228]:59781 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261530AbUFQSV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:21:57 -0400
Date: Thu, 17 Jun 2004 20:21:54 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] trivial ppc cleanup (3/3) remove a format printk warning
Message-ID: <20040617182154.GA11894@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040523i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,
	
trivial format patch : nip is an unsigned long

Please apply,

Signed-off-by: Vincent Hanquez <tab@snarc.org>

--- linux-2.6.7/arch/ppc/kernel/~traps.c	2004-06-17 18:25:44.000000000 +0200
+++ linux-2.6.7/arch/ppc/kernel/traps.c	2004-06-17 18:25:51.000000000 +0200
@@ -646,7 +646,7 @@
 	/* The kernel has executed an altivec instruction without
 	   first enabling altivec.  Whinge but let it do it. */
 	if (++kernel_altivec_count < 10)
-		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%x)\n",
+		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%lx)\n",
 		       current, regs->nip);
 	regs->msr |= MSR_VEC;
 }
