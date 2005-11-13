Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVKMQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVKMQay (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 11:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVKMQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 11:30:54 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:38528
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964922AbVKMQax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 11:30:53 -0500
Subject: [PATCH] fix synclink_gt compile for latest struct pci_driver
	changes
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 10:30:47 -0600
Message-Id: <1131899447.2910.4.camel@x2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the synclink_gt driver so it compiles with
the latest struct pci_driver changes that remove the
owner field.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.15-rc1/drivers/char/synclink_gt.c	2005-11-12 18:38:16.000000000 -0600
+++ linux-2.6.15-rc1-mg/drivers/char/synclink_gt.c	2005-11-12 18:38:35.000000000 -0600
@@ -111,7 +111,6 @@ MODULE_DEVICE_TABLE(pci, pci_table);
 static int  init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void remove_one(struct pci_dev *dev);
 static struct pci_driver pci_driver = {
-	.owner          = THIS_MODULE,
 	.name		= "synclink_gt",
 	.id_table	= pci_table,
 	.probe		= init_one,


