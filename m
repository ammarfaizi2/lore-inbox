Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUBNAsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267308AbUBNAsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:48:30 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:38979 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S267301AbUBNAs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:48:28 -0500
Date: Sat, 14 Feb 2004 01:47:45 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: [PATCH] 2.4.25-rc2 export smp_num_siblings cpu_sibling_map
Message-ID: <20040214014745.GA470@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.4 oprofile is built as an out of tree driver. I backported P4 HT
support from 2.6 to our driver but it needs these two export to work.

Any problem to apply this for 2.4.25 (or later if it's too late for .25) ?

regards,
Phil


diff -X dontdiff -urpN linux-2.4-orig/arch/i386/kernel/i386_ksyms.c linux-2.4/arch/i386/kernel/i386_ksyms.c
--- linux-2.4-orig/arch/i386/kernel/i386_ksyms.c	2003-12-03 13:01:44.000000000 +0000
+++ linux-2.4/arch/i386/kernel/i386_ksyms.c	2004-02-13 23:07:53.000000000 +0000
@@ -146,6 +146,10 @@ EXPORT_SYMBOL(smp_call_function);
 
 /* TLB flushing */
 EXPORT_SYMBOL(flush_tlb_page);
+
+/* HT support */
+EXPORT_SYMBOL(smp_num_siblings);
+EXPORT_SYMBOL(cpu_sibling_map);
 #endif
 
 #ifdef CONFIG_X86_IO_APIC
