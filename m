Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWBCVRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWBCVRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWBCVRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:17:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1806 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945972AbWBCVR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:17:29 -0500
Date: Fri, 3 Feb 2006 22:17:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] from drivers/video/Kconfig: remove unused BUS_I2C option
Message-ID: <20060203211728.GQ4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BUS_I2C option is neither available (since there is no VISWS option 
in the kernel) nor does it have any effect - so why not remove it?

Based on a report by Jean-Luc Leger <reiga@dspnet.fr.eu.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Jan 2006

--- linux-2.6.15-mm2-full/drivers/video/Kconfig.old	2006-01-11 01:23:37.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/video/Kconfig	2006-01-11 01:23:49.000000000 +0100
@@ -525,11 +525,6 @@
 	  This is the amount of memory reserved for the framebuffer,
 	  which can be any value between 1MB and 8MB.
 
-config BUS_I2C
-	bool
-	depends on (FB = y) && VISWS
-	default y
-
 config FB_SUN3
 	bool "Sun3 framebuffer support"
 	depends on (FB = y) && (SUN3 || SUN3X) && BROKEN

