Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWHAUFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWHAUFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHAUFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:05:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750731AbWHAUFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:05:52 -0400
Date: Tue, 1 Aug 2006 16:05:50 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: remove null chars from dvb names
Message-ID: <20060801200550.GA22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB null terminates its device names, which seems odd, and should
be unnecessary.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/drivers/media/dvb/ttpci/av7110.c~	2006-01-31 20:22:02.000000000 -0500
+++ linux-2.6.15.noarch/drivers/media/dvb/ttpci/av7110.c	2006-01-31 20:24:27.000000000 -0500
@@ -2956,7 +2956,7 @@ MODULE_DEVICE_TABLE(pci, pci_tbl);
 
 
 static struct saa7146_extension av7110_extension = {
-	.name		= "dvb\0",
+	.name		= "dvb",
 	.flags		= SAA7146_I2C_SHORT_DELAY,
 
 	.module		= THIS_MODULE,
--- linux-2.6.15.noarch/drivers/media/dvb/ttpci/budget-ci.c~	2006-01-31 20:25:18.000000000 -0500
+++ linux-2.6.15.noarch/drivers/media/dvb/ttpci/budget-ci.c	2006-01-31 20:25:31.000000000 -0500
@@ -1165,7 +1165,7 @@ static struct pci_device_id pci_tbl[] = 
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
 static struct saa7146_extension budget_extension = {
-	.name = "budget_ci dvb\0",
+	.name = "budget_ci dvb",
 	.flags = SAA7146_I2C_SHORT_DELAY,
 
 	.module = THIS_MODULE,
--- linux-2.6.15.noarch/drivers/media/dvb/ttpci/budget-patch.c~	2006-01-31 20:25:42.000000000 -0500
+++ linux-2.6.15.noarch/drivers/media/dvb/ttpci/budget-patch.c	2006-01-31 20:25:50.000000000 -0500
@@ -731,7 +731,7 @@ static void __exit budget_patch_exit(voi
 }
 
 static struct saa7146_extension budget_extension = {
-	.name           = "budget_patch dvb\0",
+	.name           = "budget_patch dvb",
 	.flags          = 0,
 
 	.module         = THIS_MODULE,
--- linux-2.6.15.noarch/drivers/media/dvb/ttpci/budget.c~	2006-01-31 20:25:54.000000000 -0500
+++ linux-2.6.15.noarch/drivers/media/dvb/ttpci/budget.c	2006-01-31 20:26:00.000000000 -0500
@@ -744,7 +744,7 @@ static struct pci_device_id pci_tbl[] = 
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
 static struct saa7146_extension budget_extension = {
-	.name		= "budget dvb\0",
+	.name		= "budget dvb",
 	.flags		= SAA7146_I2C_SHORT_DELAY,
 
 	.module		= THIS_MODULE,


-- 
http://www.codemonkey.org.uk
