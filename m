Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVBKS7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVBKS7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVBKS5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:57:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34066 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262289AbVBKSye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:54:34 -0500
Date: Fri, 11 Feb 2005 19:54:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 quirks.c: make a function static
Message-ID: <20050211185431.GG3736@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 Jan 2005

--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/quirks.c.old	2005-01-16 04:42:55.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/quirks.c	2005-01-16 04:43:39.000000000 +0100
@@ -7,7 +7,7 @@
 
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 
-void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
+static void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
 {
 	u8 config, rev;
 	u32 word;

