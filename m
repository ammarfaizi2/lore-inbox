Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317779AbSFSFuU>; Wed, 19 Jun 2002 01:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317780AbSFSFuT>; Wed, 19 Jun 2002 01:50:19 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:60389 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317779AbSFSFuS>; Wed, 19 Jun 2002 01:50:18 -0400
Date: Wed, 19 Jun 2002 07:50:13 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Export ioremap_nocache
Message-ID: <20020619075013.A2778@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is needed to still load modules which use ioremap_nocache. Broken by
me with the pageattr patch.

-Andi


--- linux-2.5.23-work/arch/i386/kernel/i386_ksyms.c-o	Wed Jun 19 05:32:14 2002
+++ linux-2.5.23-work/arch/i386/kernel/i386_ksyms.c	Wed Jun 19 07:47:34 2002
@@ -63,6 +63,7 @@
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_extended_fpu);
 EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap_nocache);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(enable_irq);
 EXPORT_SYMBOL(disable_irq);
