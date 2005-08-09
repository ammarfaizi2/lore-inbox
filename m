Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVHIDlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVHIDlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 23:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVHIDlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 23:41:46 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:33987 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932434AbVHIDlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 23:41:46 -0400
Date: Mon, 8 Aug 2005 22:41:17 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       peter.schaefer-hutter@tfk-racoms.com
Subject: [PATCH] cpm_uart: needs some love to compile with GCC4.0.1
Message-ID: <Pine.LNX.4.61.0508082240430.5117@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed problems so we can build with gcc-4.0.1

Signed-off-by: Peter Schaefer-Hutter <peter.schaefer-hutter@tfk-racoms.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit dcc63579f883d388c5b4f69c4adc82423cab1de2
tree f856b999bdc0182e6299ec0000d4432380af0ac0
parent 1de80554bcae877dce3b6d878053eb092ef65c72
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:38:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:38:28 -0500

 drivers/serial/cpm_uart/cpm_uart_core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1134,14 +1134,14 @@ static int __init cpm_uart_console_setup
 	return 0;
 }
 
-extern struct uart_driver cpm_reg;
+static struct uart_driver cpm_reg;
 static struct console cpm_scc_uart_console = {
-	.name		"ttyCPM",
-	.write		cpm_uart_console_write,
-	.device		uart_console_device,
-	.setup		cpm_uart_console_setup,
-	.flags		CON_PRINTBUFFER,
-	.index		-1,
+	.name		= "ttyCPM",
+	.write		= cpm_uart_console_write,
+	.device		= uart_console_device,
+	.setup		= cpm_uart_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 	.data		= &cpm_reg,
 };
 
