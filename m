Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272610AbTG1BfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272315AbTG1ABw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:52 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272927AbTG0XBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:32 -0400
Date: Sun, 27 Jul 2003 21:04:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272004.h6RK49Ae029610@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: keyboard controller by default if not embedded
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/input/serio/Kconfig linux-2.6.0-test2-ac1/drivers/input/serio/Kconfig
--- linux-2.6.0-test2/drivers/input/serio/Kconfig	2003-07-10 21:10:18.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/input/serio/Kconfig	2003-07-16 18:39:32.000000000 +0100
@@ -19,7 +19,7 @@
 	  as a module, say M here and read <file:Documentation/modules.txt>.
 
 config SERIO_I8042
-	tristate "i8042 PC Keyboard controller"
+	tristate "i8042 PC Keyboard controller" if (X86 && EMBEDDED) || (!X86)
 	default y
 	depends on SERIO
 	---help---
