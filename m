Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVGOUgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVGOUgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVGOUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:36:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45577 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261185AbVGOUgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:36:35 -0400
Date: Fri, 15 Jul 2005 22:36:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] sparc: remove the useless APM_RTC_IS_GMT option
Message-ID: <20050715203632.GD18059@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't see any effect of this option outside the i386-specific APM 
code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Jul 2005

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

