Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTEODma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTEODUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:20:24 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:18156 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263796AbTEODSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:23 -0400
Date: Thu, 15 May 2003 04:31:11 +0100
Message-Id: <200305150331.h4F3VBN2000680@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Fix pnpbios switch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erk, that's a really funny looking switch.
Every case fell through..

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pnp/pnpbios/core.c linux-2.5/drivers/pnp/pnpbios/core.c
--- bk-linus/drivers/pnp/pnpbios/core.c	2003-04-10 22:57:26.000000000 +0100
+++ linux-2.5/drivers/pnp/pnpbios/core.c	2003-04-22 17:38:38.000000000 +0100
@@ -252,41 +252,59 @@ static void pnpbios_print_status(const c
 {
 	switch(status) {
 	case PNP_SUCCESS:
-	printk(KERN_ERR "PnPBIOS: %s: function successful\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: function successful\n", module);
+		break;
 	case PNP_NOT_SET_STATICALLY:
-	printk(KERN_ERR "PnPBIOS: %s: unable to set static resources\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to set static resources\n", module);
+		break;
 	case PNP_UNKNOWN_FUNCTION:
-	printk(KERN_ERR "PnPBIOS: %s: invalid function number passed\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid function number passed\n", module);
+		break;
 	case PNP_FUNCTION_NOT_SUPPORTED:
-	printk(KERN_ERR "PnPBIOS: %s: function not supported on this system\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: function not supported on this system\n", module);
+		break;
 	case PNP_INVALID_HANDLE:
-	printk(KERN_ERR "PnPBIOS: %s: invalid handle\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid handle\n", module);
+		break;
 	case PNP_BAD_PARAMETER:
-	printk(KERN_ERR "PnPBIOS: %s: invalid parameters were passed\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: invalid parameters were passed\n", module);
+		break;
 	case PNP_SET_FAILED:
-	printk(KERN_ERR "PnPBIOS: %s: unable to set resources\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to set resources\n", module);
+		break;
 	case PNP_EVENTS_NOT_PENDING:
-	printk(KERN_ERR "PnPBIOS: %s: no events are pending\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: no events are pending\n", module);
+		break;
 	case PNP_SYSTEM_NOT_DOCKED:
-	printk(KERN_ERR "PnPBIOS: %s: the system is not docked\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the system is not docked\n", module);
+		break;
 	case PNP_NO_ISA_PNP_CARDS:
-	printk(KERN_ERR "PnPBIOS: %s: no isapnp cards are installed on this system\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: no isapnp cards are installed on this system\n", module);
+		break;
 	case PNP_UNABLE_TO_DETERMINE_DOCK_CAPABILITIES:
-	printk(KERN_ERR "PnPBIOS: %s: cannot determine the capabilities of the docking station\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: cannot determine the capabilities of the docking station\n", module);
+		break;
 	case PNP_CONFIG_CHANGE_FAILED_NO_BATTERY:
-	printk(KERN_ERR "PnPBIOS: %s: unable to undock, the system does not have a battery\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: unable to undock, the system does not have a battery\n", module);
+		break;
 	case PNP_CONFIG_CHANGE_FAILED_RESOURCE_CONFLICT:
-	printk(KERN_ERR "PnPBIOS: %s: could not dock due to resource conflicts\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: could not dock due to resource conflicts\n", module);
+		break;
 	case PNP_BUFFER_TOO_SMALL:
-	printk(KERN_ERR "PnPBIOS: %s: the buffer passed is too small\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the buffer passed is too small\n", module);
+		break;
 	case PNP_USE_ESCD_SUPPORT:
-	printk(KERN_ERR "PnPBIOS: %s: use ESCD instead\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: use ESCD instead\n", module);
+		break;
 	case PNP_MESSAGE_NOT_SUPPORTED:
-	printk(KERN_ERR "PnPBIOS: %s: the message is unsupported\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: the message is unsupported\n", module);
+		break;
 	case PNP_HARDWARE_ERROR:
-	printk(KERN_ERR "PnPBIOS: %s: a hardware failure has occured\n", module);
+		printk(KERN_ERR "PnPBIOS: %s: a hardware failure has occured\n", module);
+		break;
 	default:
-	printk(KERN_ERR "PnPBIOS: %s: unexpected status 0x%x\n", module, status);
+		printk(KERN_ERR "PnPBIOS: %s: unexpected status 0x%x\n", module, status);
+		break;
 	}
 }
 
