Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVAPIPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVAPIPc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVAPINv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:13:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56591 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262457AbVAPIMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:12:36 -0500
Date: Sun, 16 Jan 2005 09:12:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 quirks.c; make a function static
Message-ID: <20050116081232.GJ4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/quirks.c.old	2005-01-16 04:42:55.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/quirks.c	2005-01-16 04:43:39.000000000 +0100
@@ -7,7 +7,7 @@
 
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 
-void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
+static void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
 {
 	u8 config, rev;
 	u32 word;

