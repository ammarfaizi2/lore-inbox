Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVAULTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVAULTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 06:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAULTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 06:19:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48900 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262333AbVAULTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 06:19:51 -0500
Date: Fri, 21 Jan 2005 12:19:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] unexport pcibios_penalize_isa_irq
Message-ID: <20050121111949.GK3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any modular usage of pcibios_penalize_isa_irq in the 
kernel.

Is this patch correct?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/i386_ksyms.c    |    1 -
 arch/sh/kernel/sh_ksyms.c        |    1 -
 arch/x86_64/kernel/x8664_ksyms.c |    1 -
 3 files changed, 3 deletions(-)

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/i386_ksyms.c.old	2005-01-21 11:55:47.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/i386_ksyms.c	2005-01-21 11:55:54.000000000 +0100
@@ -112,7 +112,6 @@
 EXPORT_SYMBOL(dma_free_coherent);
 
 #ifdef CONFIG_PCI
-EXPORT_SYMBOL(pcibios_penalize_isa_irq);
 EXPORT_SYMBOL(pci_mem_start);
 #endif
 
--- linux-2.6.11-rc1-mm2-full/arch/sh/kernel/sh_ksyms.c.old	2005-01-21 11:56:01.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/sh/kernel/sh_ksyms.c	2005-01-21 11:56:04.000000000 +0100
@@ -51,7 +51,6 @@
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
-EXPORT_SYMBOL(pcibios_penalize_isa_irq);
 #endif
 
 /* mem exports */
--- linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/x8664_ksyms.c.old	2005-01-21 11:56:11.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/x8664_ksyms.c	2005-01-21 11:56:17.000000000 +0100
@@ -104,7 +104,6 @@
 #endif
 
 #ifdef CONFIG_PCI
-EXPORT_SYMBOL(pcibios_penalize_isa_irq);
 EXPORT_SYMBOL(pci_mem_start);
 #endif
 

