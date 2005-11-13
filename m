Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVKMXxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKMXxI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 18:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVKMXxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 18:53:08 -0500
Received: from relay.oeko.net ([193.221.127.139]:53069 "EHLO w4.oeko.net")
	by vger.kernel.org with ESMTP id S1750796AbVKMXxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 18:53:06 -0500
Message-ID: <20051113235249.8975.qmail@oak.oeko.net>
Date: Mon, 14 Nov 2005 00:52:49 +0100
From: Toni Mueller <support@oeko.net>
To: ncorbic@sangoma.com
Cc: support@oeko.net, linux-kernel@vger.kernel.org
Subject: 2.6.14: small patch to sdladrv.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hello,

while trying to build the modules for 2.6.14, I stumbled across a
glitch in drivers/net/wan/sdladrv.c. The following patch fixes compile
for me, although I don't actually have that card and thus cannot test
it.

--- sdladrv.c	2005/11/13 11:39:50	1.1
+++ sdladrv.c	2005/11/13 11:47:52
@@ -1998,7 +1998,7 @@
 		modname, hw->irq);
 
 	/* map the physical PCI memory to virtual memory */
-	(void *)hw->dpmbase = ioremap((unsigned long)S514_mem_base_addr,
+	hw->dpmbase = (void *)ioremap((unsigned long)S514_mem_base_addr,
 		(unsigned long)MAX_SIZEOF_S514_MEMORY);
     	/* map the physical control register memory to virtual memory */
 	hw->vector = (unsigned long)ioremap(

Enjoy,
--Toni++

