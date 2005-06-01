Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFATDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFATDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFAS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:59:30 -0400
Received: from fmr19.intel.com ([134.134.136.18]:36994 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261250AbVFAS5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:57:51 -0400
Date: Wed, 1 Jun 2005 11:57:45 -0700
Message-Id: <200506011857.j51IvjmE027415@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
Subject: 2.6.12-rc5-mm2 on x86_64 missing pci_bus_to_node symbol
To: akpm@osdl.org
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Rusty Lynch <rusty.lynch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to install a fresh 2.6.12-rc5-mm2 kernel on my x86_64 box, 
I am unable to load my e1000 driver because pci_bus_to_node is undefined.

I'm not sure if this is the correct way of fixing this, but here is a quick 
patch to export pci_bus_to_node on x86_64.

    --rusty

 arch/x86_64/kernel/x8664_ksyms.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/x8664_ksyms.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/x8664_ksyms.c
@@ -207,3 +207,4 @@ EXPORT_SYMBOL(flush_tlb_page);
 #endif
 
 EXPORT_SYMBOL(cpu_khz);
+EXPORT_SYMBOL(pci_bus_to_node);
