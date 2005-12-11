Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVLKVzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVLKVzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVLKVyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:54:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29710 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750872AbVLKVyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:54:14 -0500
Date: Sun, 11 Dec 2005 22:54:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] simplify PARPORT_PC_PCMCIA dependencies
Message-ID: <20051211215413.GY23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I miss something, this should be the simplest way to express the 
intended dependencies.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Nov 2005

--- linux-2.6.14-rc5-mm1-full/drivers/parport/Kconfig.old	2005-11-06 01:17:13.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/parport/Kconfig	2005-11-06 01:17:45.000000000 +0100
@@ -77,7 +77,7 @@
 
 config PARPORT_PC_PCMCIA
 	tristate "Support for PCMCIA management for PC-style ports"
-	depends on PARPORT!=n && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
+	depends on PCMCIA && PARPORT_PC
 	help
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.

