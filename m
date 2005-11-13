Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVKMERB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVKMERB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 23:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVKMERA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 23:17:00 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:55449 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751323AbVKMERA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 23:17:00 -0500
Subject: [PATCH] add missing option in kconfig for ipw2200 monitor mode
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: multipart/mixed; boundary="=-Tq9lvDFc4C2nFnxLrhC6"
Date: Sun, 13 Nov 2005 05:16:54 +0100
Message-Id: <1131855414.16512.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tq9lvDFc4C2nFnxLrhC6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds monitor mode option to ipw2200....

signed-off-by: Kasper Sandberg <lkml@metanurb.dk>

--=-Tq9lvDFc4C2nFnxLrhC6
Content-Disposition: attachment; filename=fix-missing-ipw2200-option.diff
Content-Type: text/x-patch; name=fix-missing-ipw2200-option.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.15-rc1-a/drivers/net/wireless/Kconfig linux-2.6.15-rc1-b/drivers/net/wireless/Kconfig
--- linux-2.6.15-rc1-a/drivers/net/wireless/Kconfig	2005-11-13 05:11:39.451031050 +0100
+++ linux-2.6.15-rc1-b/drivers/net/wireless/Kconfig	2005-11-13 05:12:36.834130145 +0100
@@ -217,6 +217,15 @@
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2200.ko.
 
+config IPW2200_MONITOR
+        bool "Enable promiscuous mode"
+        depends on IPW2200
+        ---help---
+          Enables promiscuous/monitor mode support for the ipw2200 driver.
+          With this feature compiled into the driver, you can switch to
+          promiscuous mode via the Wireless Tool's Monitor mode.  While in this
+          mode, no packets can be sent.
+
 config IPW_DEBUG
 	bool "Enable full debugging output in IPW2200 module."
 	depends on IPW2200

--=-Tq9lvDFc4C2nFnxLrhC6--

