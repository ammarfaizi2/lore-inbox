Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422987AbWJFVwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422987AbWJFVwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422990AbWJFVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:52:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422987AbWJFVwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:52:49 -0400
Date: Fri, 6 Oct 2006 17:52:45 -0400
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: remove pointless printk from i386 oops output
Message-ID: <20061006215245.GA15420@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just got removed on x86-64, do the same on 32bit.
It always annoyed me when this ate a line of oops output pushing
interesting stuff off the screen.
 
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.18.noarch/arch/i386/kernel/traps.c~	2006-10-06 17:41:47.000000000 -0400
+++ linux-2.6.18.noarch/arch/i386/kernel/traps.c	2006-10-06 17:42:03.000000000 -0400
@@ -837,7 +837,6 @@ void die_nmi (struct pt_regs *regs, cons
 	printk(" on CPU%d, eip %08lx, registers:\n",
 		smp_processor_id(), regs->eip);
 	show_registers(regs);
-	printk(KERN_EMERG "console shuts up ...\n");
 	console_silent();
 	spin_unlock(&nmi_print_lock);
 	bust_spinlocks(0);

-- 
http://www.codemonkey.org.uk
