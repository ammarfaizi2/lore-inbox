Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVDWAZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVDWAZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVDWAZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:25:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48657 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261376AbVDWAZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:25:16 -0400
Date: Sat, 23 Apr 2005 02:25:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] correct the DEBUG_BUGVERBOSE question dependency
Message-ID: <20050423002513.GQ4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, DEBUG_BUGVERBOSE, is automatically set to "y" if 
DEBUG_KERNEL=n and EMBEDDED=y which doesn't make much sense.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/lib/Kconfig.debug.old	2005-04-22 03:03:27.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/lib/Kconfig.debug	2005-04-22 03:04:00.000000000 +0200
@@ -125,9 +125,9 @@
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
 
 config DEBUG_BUGVERBOSE
-	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
+	bool "Verbose BUG() reporting (adds 70K)" if EMBEDDED
 	depends on BUG
 	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || (X86 && !X86_64) || FRV
 	default !EMBEDDED
 	help


