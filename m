Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVCUUc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVCUUc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVCUUc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:32:56 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:42821 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261432AbVCUUcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:32:36 -0500
Date: Mon, 21 Mar 2005 21:25:50 +0100
Message-Id: <200503212025.j2LKPoG9011332@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 546] Sun-3/3x: Enable Sun partition tables support by default
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3/3x: Enable Sun partition tables support by default

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/fs/partitions/Kconfig	2005-02-03 14:30:28.000000000 +0100
+++ linux-m68k-2.6.12-rc1/fs/partitions/Kconfig	2005-03-20 11:51:42.000000000 +0100
@@ -203,7 +203,7 @@ config ULTRIX_PARTITION
 
 config SUN_PARTITION
 	bool "Sun partition tables support" if PARTITION_ADVANCED
-	default y if (SPARC32 || SPARC64)
+	default y if (SPARC32 || SPARC64 || SUN3 || SUN3X)
 	---help---
 	  Like most systems, SunOS uses its own hard disk partition table
 	  format, incompatible with all others. Saying Y here allows you to
--- linux-2.6.12-rc1/arch/m68k/configs/sun3_defconfig	2005-03-18 23:44:15.000000000 +0100
+++ linux-m68k-2.6.12-rc1/arch/m68k/configs/sun3_defconfig	2005-03-20 12:51:34.540342000 +0100
@@ -752,6 +752,7 @@ CONFIG_CODA_FS=m
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
+CONFIG_SUN_PARTITION=y
 
 #
 # Native Language Support
--- linux-2.6.12-rc1/arch/m68k/configs/sun3x_defconfig	2005-03-18 23:44:18.000000000 +0100
+++ linux-m68k-2.6.12-rc1/arch/m68k/configs/sun3x_defconfig	2005-03-20 12:51:36.049092000 +0100
@@ -762,6 +762,7 @@ CONFIG_CODA_FS=m
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
+CONFIG_SUN_PARTITION=y
 
 #
 # Native Language Support

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
