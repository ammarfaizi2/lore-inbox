Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVGLJcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVGLJcF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGLJcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:32:04 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:12174 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261296AbVGLJbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:31:32 -0400
Message-Id: <20050712010132.193770000@abc>
References: <20050712005934.981758000@abc>
Date: Tue, 12 Jul 2005 02:59:37 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>,
       Julian Scheel <julian@jusst.de>
Content-Disposition: inline; filename=dvb-kobject-name-fix.patch
X-SA-Exim-Connect-IP: 84.189.244.201
Subject: [DVB patch 2/3] fix kobject names (no slashes)
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Scheel <julian@jusst.de>

The / in the driver name (budget dvb /w video in) is not a valid character for
device names - removed it, now it works!

Same for ttusb-budget.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Julian Scheel <julian@jusst.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/budget-av.c               |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/ttpci/budget-av.c	2005-07-11 21:29:46.000000000 +0200
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/ttpci/budget-av.c	2005-07-12 02:53:19.000000000 +0200
@@ -1022,7 +1022,7 @@ static struct pci_device_id pci_tbl[] = 
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
 static struct saa7146_extension budget_extension = {
-	.name = "budget dvb /w video in\0",
+	.name = "budget_av",
 	.pci_tbl = pci_tbl,
 
 	.module = THIS_MODULE,
Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-07-11 21:29:47.000000000 +0200
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-07-12 02:53:19.000000000 +0200
@@ -1626,7 +1626,7 @@ static struct usb_device_id ttusb_table[
 MODULE_DEVICE_TABLE(usb, ttusb_table);
 
 static struct usb_driver ttusb_driver = {
-      .name		= "Technotrend/Hauppauge USB-Nova",
+      .name		= "ttusb",
       .probe		= ttusb_probe,
       .disconnect	= ttusb_disconnect,
       .id_table		= ttusb_table,

--

