Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVC0UVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVC0UVU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVC0UVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:21:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10256 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261514AbVC0UVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:21:18 -0500
Date: Sun, 27 Mar 2005 22:21:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] always enable regparm on i386
Message-ID: <20050327202116.GP4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below always enables regparm on i386 (with gcc >= 3.0).

With this patch, it should get a better testing coverage in -mm.

This patch should help to find bugs that show up with regparm enabled.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/arch/i386/Kconfig.old	2005-01-08 17:41:49.000000000 +0100
+++ linux-2.6.10-mm2-full/arch/i386/Kconfig	2005-01-08 17:42:10.000000000 +0100
@@ -877,9 +877,8 @@
 	default y
 
 config REGPARM
-	bool "Use register arguments (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	default n
+	bool
+	default y
 	help
 	Compile the kernel with -mregparm=3. This uses an different ABI
 	and passes the first three arguments of a function call in registers.

