Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUATC2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUATACf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:02:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:10156 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264559AbUASX7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:51 -0500
Subject: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <20040119235733.GA5549@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:17 -0800
Message-Id: <10745567571488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.1, 2004/01/14 11:08:59-08:00, trini@kernel.crashing.org

[PATCH] I2C: module_parm fixes for i2c-piix4.c


 drivers/i2c/busses/i2c-piix4.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Jan 19 15:33:22 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Jan 19 15:33:22 2004
@@ -31,6 +31,7 @@
 /* #define DEBUG 1 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -88,13 +89,13 @@
 /* If force is set to anything different from 0, we forcibly enable the
    PIIX4. DANGEROUS! */
 static int force = 0;
-MODULE_PARM(force, "i");
+module_param (force, int, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the PIIX4 at the given address. VERY DANGEROUS! */
 static int force_addr = 0;
-MODULE_PARM(force_addr, "i");
+module_param (force_addr, int, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
@@ -102,7 +103,7 @@
 /* If fix_hstcfg is set to anything different from 0, we reset one of the
    registers to be a valid value. */
 static int fix_hstcfg = 0;
-MODULE_PARM(fix_hstcfg, "i");
+module_param (fix_hstcfg, int, 0);
 MODULE_PARM_DESC(fix_hstcfg,
 		"Fix config register. Needed on some boards (Force CPCI735).");
 

