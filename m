Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVBKUEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVBKUEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVBKUE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:04:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:22493 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262328AbVBKUDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:03:37 -0500
Date: Fri, 11 Feb 2005 21:03:29 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, developers@melware.de
Subject: [PATCH] 2.6 ISDN Eicon driver: convert to pci_register_driver
Message-ID: <420D0F91.mail2AH1E341H@phoenix.one.melware.de>
User-Agent: nail 11.4 8/29/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: armin@melware.de (Armin Schindler)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
convert from pci_module_init to pci_register_driver


Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Armin Schindler <armin@melware.de>



diff -u linux.orig/drivers/isdn/hardware/eicon/divasmain.c linux/drivers/isdn/hardware/eicon/divasmain.c
--- linux.orig/drivers/isdn/hardware/eicon/divasmain.c	2005-02-11 17:50:39.000000000 +0100
+++ linux/drivers/isdn/hardware/eicon/divasmain.c	2005-02-11 20:41:25.398402952 +0100
@@ -1,4 +1,4 @@
-/* $Id: divasmain.c,v 1.55.4.1 2004/05/21 12:15:00 armin Exp $
+/* $Id: divasmain.c,v 1.55.4.6 2005/02/09 19:28:20 armin Exp $
  *
  * Low level driver for Eicon DIVA Server ISDN cards.
  *
@@ -41,7 +41,7 @@
 #include "diva_dma.h"
 #include "diva_pci.h"
 
-static char *main_revision = "$Revision: 1.55.4.1 $";
+static char *main_revision = "$Revision: 1.55.4.6 $";
 
 static int major;
 
@@ -823,7 +823,7 @@
 		goto out;
 	}
 
-	if ((ret = pci_module_init(&diva_pci_driver))) {
+	if ((ret = pci_register_driver(&diva_pci_driver))) {
 #ifdef MODULE
 		remove_divas_proc();
 		divas_unregister_chrdev();

