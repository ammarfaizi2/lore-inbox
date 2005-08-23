Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVHWVvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVHWVvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVHWVus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:50:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9398 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932429AbVHWVn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:59 -0400
To: torvalds@osdl.org
Subject: [PATCH] (27/43) missing include in pcmcia_resource.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gbl-0007D1-W6@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

missing include of asm/irq.h

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-alpha-warnings/drivers/pcmcia/pcmcia_resource.c RC13-rc6-git13-pcmcia-irq/drivers/pcmcia/pcmcia_resource.c
--- RC13-rc6-git13-alpha-warnings/drivers/pcmcia/pcmcia_resource.c	2005-08-10 10:37:50.000000000 -0400
+++ RC13-rc6-git13-pcmcia-irq/drivers/pcmcia/pcmcia_resource.c	2005-08-21 13:17:10.000000000 -0400
@@ -41,6 +41,7 @@
 
 
 #ifdef CONFIG_PCMCIA_PROBE
+#include <asm/irq.h>
 /* mask of IRQs already reserved by other cards, we should avoid using them */
 static u8 pcmcia_used_irq[NR_IRQS];
 #endif
