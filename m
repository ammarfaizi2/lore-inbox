Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUHJAix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUHJAix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUHJAix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:38:53 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:13291 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267365AbUHJAi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:38:29 -0400
Date: Mon, 9 Aug 2004 17:38:24 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [PATCH 2.6] Remove spaces from PCI I2C pci_driver.name fields
Message-ID: <20040810003824.GA8643@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

Same thing as IDE...spaces in PCI driver names show up in sysfs file 
names.  I've also cleaned up all the .name fields to be in the format 
(${NAME}_i2c|${NAME}_smbus) so they are consistent.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


===== drivers/i2c/busses/i2c-ali1563.c 1.7 vs edited =====
--- 1.7/drivers/i2c/busses/i2c-ali1563.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-ali1563.c	Mon Aug  9 17:30:48 2004
@@ -395,7 +395,7 @@
 };
 
 static struct pci_driver ali1563_pci_driver = {
- 	.name		= "i2c-ali1563",
+ 	.name		= "ali1563_i2c",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
 	.remove		= ali1563_remove,
===== drivers/i2c/busses/i2c-ali15x3.c 1.21 vs edited =====
--- 1.21/drivers/i2c/busses/i2c-ali15x3.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-ali15x3.c	Mon Aug  9 17:30:53 2004
@@ -509,7 +509,7 @@
 }
 
 static struct pci_driver ali15x3_driver = {
-	.name		= "ali15x3 smbus",
+	.name		= "ali15x3_smbus",
 	.id_table	= ali15x3_ids,
 	.probe		= ali15x3_probe,
 	.remove		= __devexit_p(ali15x3_remove),
===== drivers/i2c/busses/i2c-amd756.c 1.20 vs edited =====
--- 1.20/drivers/i2c/busses/i2c-amd756.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-amd756.c	Mon Aug  9 17:30:56 2004
@@ -394,7 +394,7 @@
 }
 
 static struct pci_driver amd756_driver = {
-	.name		= "amd756 smbus",
+	.name		= "amd756_smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
 	.remove		= __devexit_p(amd756_remove),
===== drivers/i2c/busses/i2c-amd8111.c 1.19 vs edited =====
--- 1.19/drivers/i2c/busses/i2c-amd8111.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-amd8111.c	Mon Aug  9 17:31:01 2004
@@ -392,7 +392,7 @@
 }
 
 static struct pci_driver amd8111_driver = {
-	.name		= "amd8111 smbus 2",
+	.name		= "amd8111_smbus2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
 	.remove		= __devexit_p(amd8111_remove),
===== drivers/i2c/busses/i2c-hydra.c 1.1 vs edited =====
--- 1.1/drivers/i2c/busses/i2c-hydra.c	Sun Jan 25 02:30:13 2004
+++ edited/drivers/i2c/busses/i2c-hydra.c	Mon Aug  9 17:31:06 2004
@@ -158,7 +158,7 @@
 
 
 static struct pci_driver hydra_driver = {
-	.name		= "hydra smbus",
+	.name		= "hydra_smbus",
 	.id_table	= hydra_ids,
 	.probe		= hydra_probe,
 	.remove		= __devexit_p(hydra_remove),
===== drivers/i2c/busses/i2c-i801.c 1.23 vs edited =====
--- 1.23/drivers/i2c/busses/i2c-i801.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-i801.c	Mon Aug  9 17:31:09 2004
@@ -623,7 +623,7 @@
 }
 
 static struct pci_driver i801_driver = {
-	.name		= "i801 smbus",
+	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
 	.remove		= __devexit_p(i801_remove),
===== drivers/i2c/busses/i2c-i810.c 1.4 vs edited =====
--- 1.4/drivers/i2c/busses/i2c-i810.c	Mon Mar 15 02:25:23 2004
+++ edited/drivers/i2c/busses/i2c-i810.c	Mon Aug  9 17:31:11 2004
@@ -231,7 +231,7 @@
 }
 
 static struct pci_driver i810_driver = {
-	.name		= "i810 smbus",
+	.name		= "i810_smbus",
 	.id_table	= i810_ids,
 	.probe		= i810_probe,
 	.remove		= __devexit_p(i810_remove),
===== drivers/i2c/busses/i2c-nforce2.c 1.12 vs edited =====
--- 1.12/drivers/i2c/busses/i2c-nforce2.c	Sun May  9 10:05:17 2004
+++ edited/drivers/i2c/busses/i2c-nforce2.c	Mon Aug  9 17:31:15 2004
@@ -384,7 +384,7 @@
 }
 
 static struct pci_driver nforce2_driver = {
-	.name		= "nForce2 SMBus",
+	.name		= "nForce2_smbus",
 	.id_table	= nforce2_ids,
 	.probe		= nforce2_probe,
 	.remove		= __devexit_p(nforce2_remove),
===== drivers/i2c/busses/i2c-piix4.c 1.31 vs edited =====
--- 1.31/drivers/i2c/busses/i2c-piix4.c	Sun Jun 27 00:19:29 2004
+++ edited/drivers/i2c/busses/i2c-piix4.c	Mon Aug  9 17:31:18 2004
@@ -493,7 +493,7 @@
 }
 
 static struct pci_driver piix4_driver = {
-	.name		= "piix4-smbus",
+	.name		= "piix4_smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
 	.remove		= __devexit_p(piix4_remove),
===== drivers/i2c/busses/i2c-prosavage.c 1.10 vs edited =====
--- 1.10/drivers/i2c/busses/i2c-prosavage.c	Mon Mar 15 02:25:23 2004
+++ edited/drivers/i2c/busses/i2c-prosavage.c	Mon Aug  9 17:31:21 2004
@@ -314,7 +314,7 @@
 };
 
 static struct pci_driver prosavage_driver = {
-	.name		=	"prosavage-smbus",
+	.name		=	"prosavage_smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
 	.remove		=	prosavage_remove,
===== drivers/i2c/busses/i2c-savage4.c 1.6 vs edited =====
--- 1.6/drivers/i2c/busses/i2c-savage4.c	Mon Mar 15 02:25:23 2004
+++ edited/drivers/i2c/busses/i2c-savage4.c	Mon Aug  9 17:31:24 2004
@@ -178,7 +178,7 @@
 }
 
 static struct pci_driver savage4_driver = {
-	.name		= "savage4 smbus",
+	.name		= "savage4_smbus",
 	.id_table	= savage4_ids,
 	.probe		= savage4_probe,
 	.remove		= __devexit_p(savage4_remove),
===== drivers/i2c/busses/i2c-sis5595.c 1.11 vs edited =====
--- 1.11/drivers/i2c/busses/i2c-sis5595.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-sis5595.c	Mon Aug  9 17:31:27 2004
@@ -393,7 +393,7 @@
 }
 
 static struct pci_driver sis5595_driver = {
-	.name		= "sis5595 smbus",
+	.name		= "sis5595_smbus",
 	.id_table	= sis5595_ids,
 	.probe		= sis5595_probe,
 	.remove		= __devexit_p(sis5595_remove),
===== drivers/i2c/busses/i2c-sis630.c 1.10 vs edited =====
--- 1.10/drivers/i2c/busses/i2c-sis630.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-sis630.c	Mon Aug  9 17:31:31 2004
@@ -494,7 +494,7 @@
 
 
 static struct pci_driver sis630_driver = {
-	.name		= "sis630 smbus",
+	.name		= "sis630_smbus",
 	.id_table	= sis630_ids,
 	.probe		= sis630_probe,
 	.remove		= __devexit_p(sis630_remove),
===== drivers/i2c/busses/i2c-sis96x.c 1.11 vs edited =====
--- 1.11/drivers/i2c/busses/i2c-sis96x.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-sis96x.c	Mon Aug  9 17:31:34 2004
@@ -339,7 +339,7 @@
 }
 
 static struct pci_driver sis96x_driver = {
-	.name		= "sis96x smbus",
+	.name		= "sis96x_smbus",
 	.id_table	= sis96x_ids,
 	.probe		= sis96x_probe,
 	.remove		= __devexit_p(sis96x_remove),
===== drivers/i2c/busses/i2c-via.c 1.9 vs edited =====
--- 1.9/drivers/i2c/busses/i2c-via.c	Sun May  9 10:05:17 2004
+++ edited/drivers/i2c/busses/i2c-via.c	Mon Aug  9 17:31:37 2004
@@ -158,7 +158,7 @@
 
 
 static struct pci_driver vt586b_driver = {
-	.name		= "vt586b smbus",
+	.name		= "vt586b_smbus",
 	.id_table	= vt586b_ids,
 	.probe		= vt586b_probe,
 	.remove		= __devexit_p(vt586b_remove),
===== drivers/i2c/busses/i2c-viapro.c 1.14 vs edited =====
--- 1.14/drivers/i2c/busses/i2c-viapro.c	Tue May 18 09:00:17 2004
+++ edited/drivers/i2c/busses/i2c-viapro.c	Mon Aug  9 17:31:40 2004
@@ -455,7 +455,7 @@
 };
 
 static struct pci_driver vt596_driver = {
-	.name		= "vt596 smbus",
+	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
 	.remove		= __devexit_p(vt596_remove),
===== drivers/i2c/busses/i2c-voodoo3.c 1.7 vs edited =====
--- 1.7/drivers/i2c/busses/i2c-voodoo3.c	Wed May  5 02:40:37 2004
+++ edited/drivers/i2c/busses/i2c-voodoo3.c	Mon Aug  9 17:31:45 2004
@@ -224,7 +224,7 @@
 }
 
 static struct pci_driver voodoo3_driver = {
-	.name		= "voodoo3 smbus",
+	.name		= "voodoo3_smbus",
 	.id_table	= voodoo3_ids,
 	.probe		= voodoo3_probe,
 	.remove		= __devexit_p(voodoo3_remove),

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
