Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272645AbTG1B5v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272120AbTG1AB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:28 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272936AbTG0XBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:38 -0400
Date: Sun, 27 Jul 2003 21:02:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272002.h6RK215U029586@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: console on by default if not embedded (save mucho pain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andi Kleen)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/Kconfig linux-2.6.0-test2-ac1/drivers/char/Kconfig
--- linux-2.6.0-test2/drivers/char/Kconfig	2003-07-10 21:04:38.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/Kconfig	2003-07-16 18:39:32.000000000 +0100
@@ -5,8 +5,9 @@
 menu "Character devices"
 
 config VT
-	bool "Virtual terminal"
+	bool "Virtual terminal" if EMBEDDED
 	requires INPUT=y
+	default y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
@@ -35,8 +36,9 @@
 	  shiny Linux system :-)
 
 config VT_CONSOLE
-	bool "Support for console on virtual terminal"
+	bool "Support for console on virtual terminal" if EMBEDDED
 	depends on VT
+	default y
 	---help---
 	  The system console is the device which receives all kernel messages
 	  and warnings and which allows logins in single user mode. If you
