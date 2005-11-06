Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVKFAzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVKFAzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVKFAzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:55:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14861 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932260AbVKFAzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:55:16 -0500
Date: Sun, 6 Nov 2005 01:55:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] simplify PARPORT_PC_PCMCIA dependencies
Message-ID: <20051106005515.GG3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I miss something, this should be the simplest way to express the 
intended dependencies.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

