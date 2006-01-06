Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWAFCZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWAFCZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWAFCZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:25:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932171AbWAFCZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:25:04 -0500
Date: Fri, 6 Jan 2006 03:25:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: let REGPARM no longer depend on EXPERIMENTAL
Message-ID: <20060106022503.GS12313@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

REGPARM has already gotten much testing, what about removing the 
dependency on EXPERIMENTAL?

Additionally, this patch does:
- remove the useless "default n"
- remove note regarding binary only modules (nowadays, there are even
  some binary only modules compiled with REGPARM=y available)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm1-full/arch/i386/Kconfig.old	2006-01-05 23:28:27.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/i386/Kconfig	2006-01-05 23:28:42.000000000 +0100
@@ -626,13 +626,10 @@
 	default y
 
 config REGPARM
-	bool "Use register arguments (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	default n
+	bool "Use register arguments"
 	help
 	Compile the kernel with -mregparm=3. This uses a different ABI
 	and passes the first three arguments of a function call in registers.
-	This will probably break binary only modules.
 
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"

