Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263285AbUJ2BmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbUJ2BmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUJ2Bir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:38:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:61064 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263290AbUJ2Bax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 21:30:53 -0400
Subject: [PATCH] ppc64: Enable maple IDE fixup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 11:25:55 +1000
Message-Id: <1099013155.29690.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Now that pci_get_legacy_ide_irq() support has been merged, it's time
to enable use of it by the Maple platform code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/maple_setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/maple_setup.c	2004-10-27 13:12:16.000000000 +1000
+++ linux-work/arch/ppc64/kernel/maple_setup.c	2004-10-29 11:19:27.931904024 +1000
@@ -229,9 +229,7 @@
 	.init_IRQ		= maple_init_IRQ,
 	.get_irq		= mpic_get_irq,
 	.pcibios_fixup		= maple_pcibios_fixup,
-#if 0
 	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
-#endif
 	.restart		= maple_restart,
 	.power_off		= maple_power_off,
 	.halt			= maple_halt,


