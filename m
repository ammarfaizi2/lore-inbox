Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272576AbTG1AmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272575AbTG1AEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:32 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272726AbTG0W6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:20 -0400
Date: Sun, 27 Jul 2003 21:16:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272016.h6RKGF7v029731@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: vga text console if x86 and not embedded
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andi Kleen)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/video/console/Kconfig linux-2.6.0-test2-ac1/drivers/video/console/Kconfig
--- linux-2.6.0-test2/drivers/video/console/Kconfig	2003-07-10 21:06:08.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/video/console/Kconfig	2003-07-16 18:39:32.000000000 +0100
@@ -5,8 +5,9 @@
 menu "Console display driver support"
 
 config VGA_CONSOLE
-	bool "VGA text console"
+	bool "VGA text console" if (EMBEDDED && X86) || (!X86)
 	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
+	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
 	  display that complies with the generic VGA standard. Virtually
