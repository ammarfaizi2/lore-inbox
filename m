Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVHYFWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVHYFWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVHYFV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6860 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964821AbVHYFV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:56 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (16/22) Kconfig fix (mac vs. FONTS)
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEX-0005dz-L7@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:25:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mac won't build without non-modular FONTS, which requires non-modular
FB and FRAMEBUFFER_CONSOLE

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-82596/arch/m68k/Kconfig RC13-rc7-mac-fonts/arch/m68k/Kconfig
--- RC13-rc7-82596/arch/m68k/Kconfig	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc7-mac-fonts/arch/m68k/Kconfig	2005-08-25 00:54:16.000000000 -0400
@@ -126,6 +126,8 @@
 config MAC
 	bool "Macintosh support"
 	depends on !MMU_SUN3
+	select FRAMEBUFFER_CONSOLE
+	select FB
 	help
 	  This option enables support for the Apple Macintosh series of
 	  computers (yes, there is experimental support now, at least for part
