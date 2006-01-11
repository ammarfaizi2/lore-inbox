Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWAKAhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWAKAhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWAKAhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:37:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20492 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932552AbWAKAhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:37:51 -0500
Date: Wed, 11 Jan 2006 01:37:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] from drivers/video/Kconfig: remove unused VISWS option
Message-ID: <20060111003749.GK3911@stusta.de>
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

