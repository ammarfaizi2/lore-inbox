Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268761AbTGIXg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268752AbTGIXfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:35:48 -0400
Received: from palrel12.hp.com ([156.153.255.237]:57034 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S268725AbTGIXe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:34:28 -0400
Date: Wed, 9 Jul 2003 16:49:04 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] include cleanup
Message-ID: <20030709234904.GB12747@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir250_include_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Cleanup cruft from <linux/irda.h>


diff -u -p linux/include/linux/irda.d1.h linux/include/linux/irda.h
--- linux/include/linux/irda.d1.h	Wed Jun  4 13:38:02 2003
+++ linux/include/linux/irda.h	Wed Jun  4 14:16:33 2003
@@ -25,7 +25,11 @@
 #ifndef KERNEL_IRDA_H
 #define KERNEL_IRDA_H
 
-#include <linux/socket.h> /* only for sa_family_t */
+/* Please do *not* add any #include in this file, this file is
+ * included as-is in user space.
+ * Please fix the calling file to properly included needed files before
+ * this one, or preferably to include <net/irda/irda.h> instead.
+ * Jean II */
 
 /* Hint bit positions for first hint byte */
 #define HINT_PNP         0x01
diff -u -p linux/drivers/net/irda/old_belkin.d1.c linux/drivers/net/irda/old_belkin.c
--- linux/drivers/net/irda/old_belkin.d1.c	Wed Jun  4 13:41:23 2003
+++ linux/drivers/net/irda/old_belkin.c	Wed Jun  4 13:42:08 2003
@@ -32,8 +32,6 @@
 #include <linux/delay.h>
 #include <linux/tty.h>
 #include <linux/init.h>
-#include <linux/net.h>
-#include <linux/irda.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
