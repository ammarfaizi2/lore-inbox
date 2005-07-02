Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVGBWBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVGBWBH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVGBWBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:01:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10506 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261305AbVGBV4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:56:24 -0400
Date: Sat, 2 Jul 2005 23:56:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: wli@holomorphy.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sparc: remove the useless APM_RTC_IS_GMT option
Message-ID: <20050702215618.GH5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't see any effect of this option outside the i386-specific APM 
code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1-full/drivers/sbus/char/Kconfig.old	2005-07-02 20:24:49.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/sbus/char/Kconfig	2005-07-02 20:25:20.000000000 +0200
@@ -71,20 +71,6 @@
 
 # XXX Why don't we do "source drivers/char/Config.in" somewhere?
 # no shit
-config APM_RTC_IS_GMT
-	bool
-	depends on EXPERIMENTAL && SPARC32 && PCI
-	default y
-	help
-	  Say Y here if your RTC (Real Time Clock a.k.a. hardware clock)
-	  stores the time in GMT (Greenwich Mean Time). Say N if your RTC
-	  stores localtime.
-
-	  It is in fact recommended to store GMT in your RTC, because then you
-	  don't have to worry about daylight savings time changes. The only
-	  reason not to use GMT in your RTC is if you also run a broken OS
-	  that doesn't understand GMT.
-
 config RTC
 	tristate "PC-style Real Time Clock Support"
 	depends on PCI && EXPERIMENTAL && SPARC32

