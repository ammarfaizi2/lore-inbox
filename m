Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTHYLi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTHYLi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:38:28 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:11280 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261692AbTHYLi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:38:27 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Eliminate compile warning in winbond-840.c
Date: Mon, 25 Aug 2003 14:38:21 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200308251438.21441.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes non-modular build warning:

  CC      drivers/net/tulip/winbond-840.o
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not used
-- 
vda

--- linux-2.6.0-test4/drivers/net/tulip/winbond-840.c.orig	Sat Aug 23 02:53:03 2003
+++ linux-2.6.0-test4/drivers/net/tulip/winbond-840.c	Mon Aug 25 14:33:25 2003
@@ -146,9 +146,11 @@
 #include <asm/irq.h>

 /* These identify the driver base version and may not be removed. */
+#ifdef MODULE
 static char version[] __devinitdata =
 KERN_INFO DRV_NAME ".c:v" DRV_VERSION " (2.4 port) " DRV_RELDATE "  Donald Becker <becker@scyld.com>\n"
 KERN_INFO "  http://www.scyld.com/network/drivers.html\n";
+#endif

 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Winbond W89c840 Ethernet driver");

