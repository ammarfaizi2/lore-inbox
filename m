Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVEOL5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVEOL5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 07:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVEOL5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 07:57:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45072 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262791AbVEOL5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 07:57:17 -0400
Date: Sun, 15 May 2005 13:57:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050515115712.GQ16549@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should _not_ go into Linus' tree.

At some time in the future, we want to unconditionally enable REGPARM on 
i386.

Let's give it a bit broader testing coverage among -mm users.

This patch:
- removes the dependency of REGPARM on EXPERIMENTAL
- let REGPARM default to y

This patch assumes that people who use -mm are willing to test some more 
experimental features.

After this patch, REGPARM is still a config option users can disable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc4-mm1-full/arch/i386/Kconfig.old	2005-05-15 12:03:28.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/arch/i386/Kconfig	2005-05-15 12:03:54.000000000 +0200
@@ -911,9 +911,8 @@
 	default y
 
 config REGPARM
-	bool "Use register arguments (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	default n
+	bool "Use register arguments"
+	default y
 	help
 	Compile the kernel with -mregparm=3. This uses a different ABI
 	and passes the first three arguments of a function call in registers.

