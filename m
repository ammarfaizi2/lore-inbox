Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWDCV7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWDCV7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWDCV7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:59:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34822 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964884AbWDCV7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:59:50 -0400
Date: Mon, 3 Apr 2006 23:59:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] menu: relocate DOUBLEFAULT option
Message-ID: <20060403215948.GC6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Move the DOUBLEFAULT option from the top-level menu to the
EMBEDDED menu.  Only applicable to X86_32.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Randy Dunlap on:
- 22 Jan 2006

 arch/i386/Kconfig |    9 ---------
 init/Kconfig      |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2616-rc1g4.orig/arch/i386/Kconfig
+++ linux-2616-rc1g4/arch/i386/Kconfig
@@ -47,9 +47,0 @@ config DMI
-config DOUBLEFAULT
-	default y
-	bool "Enable doublefault exception handler" if EMBEDDED
-	help
-          This option allows trapping of rare doublefault exceptions that
-          would otherwise cause a system to silently reboot. Disabling this
-          option saves about 4k and might cause you much additional grey
-          hair.
-
--- linux-2616-rc1g4.orig/init/Kconfig
+++ linux-2616-rc1g4/init/Kconfig
@@ -412,6 +412,15 @@ config SLAB
 	  SLOB is more space efficient but does not scale well and is
 	  more susceptible to fragmentation.
 
+config DOUBLEFAULT
+	default y
+	bool "Enable doublefault exception handler" if EMBEDDED && X86_32
+	help
+          This option allows trapping of rare doublefault exceptions that
+          would otherwise cause a system to silently reboot. Disabling this
+          option saves about 4k and might cause you much additional grey
+          hair.
+
 endmenu		# General setup
 
 config TINY_SHMEM


