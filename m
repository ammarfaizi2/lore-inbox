Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbUB1F0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 00:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbUB1F0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 00:26:21 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:5085 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262950AbUB1F0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 00:26:20 -0500
Date: Sat, 28 Feb 2004 06:26:18 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: x86/64 and oprofile [was Re: Linux 2.6.4-rc1]
Message-ID: <20040228062618.GH25439@zaniah>
References: <Pine.LNX.4.58.0402271458480.1078@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402271458480.1078@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 at 15:03 +0000, Linus Torvalds wrote:

>   o Allow P4 oprofile code for x86-64

P4 oprofile needs cpu_sibling_map and smp_num_siblings, the later
was not exported

regards,
Phil

===== arch/x86_64/kernel/x8664_ksyms.c 1.25 vs edited =====
--- 1.25/arch/x86_64/kernel/x8664_ksyms.c	Wed Feb 25 16:06:01 2004
+++ edited/arch/x86_64/kernel/x8664_ksyms.c	Sat Feb 28 06:10:55 2004
@@ -196,6 +196,7 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_sibling_map);
+EXPORT_SYMBOL(smp_num_siblings);
 #endif
 
 extern void do_softirq_thunk(void);
