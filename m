Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUHWT5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUHWT5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUHWTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:54:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:43715 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266806AbUHWSgQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:16 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860893300@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <10932860893321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.45, 2004/08/10 16:30:07-07:00, dsaxena@plexity.net

[PATCH] Remove spaces from PCI I2C pci_driver.name fields

Same thing as IDE...spaces in PCI driver names show up in sysfs file
names.  I've also cleaned up all the .name fields to be in the format
(${NAME}_i2c|${NAME}_smbus) so they are consistent.


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ali1563.c   |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c   |    2 +-
 drivers/i2c/busses/i2c-amd756.c    |    2 +-
 drivers/i2c/busses/i2c-amd8111.c   |    2 +-
 drivers/i2c/busses/i2c-hydra.c     |    2 +-
 drivers/i2c/busses/i2c-i801.c      |    2 +-
 drivers/i2c/busses/i2c-i810.c      |    2 +-
 drivers/i2c/busses/i2c-nforce2.c   |    2 +-
 drivers/i2c/busses/i2c-piix4.c     |    2 +-
 drivers/i2c/busses/i2c-prosavage.c |    2 +-
 drivers/i2c/busses/i2c-savage4.c   |    2 +-
 drivers/i2c/busses/i2c-sis5595.c   |    2 +-
 drivers/i2c/busses/i2c-sis630.c    |    2 +-
 drivers/i2c/busses/i2c-sis96x.c    |    2 +-
 drivers/i2c/busses/i2c-via.c       |    2 +-
 drivers/i2c/busses/i2c-viapro.c    |    2 +-
 drivers/i2c/busses/i2c-voodoo3.c   |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-ali1563.c	2004-08-23 11:02:22 -07:00
@@ -395,7 +395,7 @@
 };
 
 static struct pci_driver ali1563_pci_driver = {
- 	.name		= "i2c-ali1563",
+ 	.name		= "ali1563_i2c",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
 	.remove		= ali1563_remove,
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-ali15x3.c	2004-08-23 11:02:22 -07:00
@@ -509,7 +509,7 @@
 }
 
 static struct pci_driver ali15x3_driver = {
-	.name		= "ali15x3 smbus",
+	.name		= "ali15x3_smbus",
 	.id_table	= ali15x3_ids,
 	.probe		= ali15x3_probe,
 	.remove		= __devexit_p(ali15x3_remove),
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-amd756.c	2004-08-23 11:02:22 -07:00
@@ -394,7 +394,7 @@
 }
 
 static struct pci_driver amd756_driver = {
-	.name		= "amd756 smbus",
+	.name		= "amd756_smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
 	.remove		= __devexit_p(amd756_remove),
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-amd8111.c	2004-08-23 11:02:22 -07:00
@@ -392,7 +392,7 @@
 }
 
 static struct pci_driver amd8111_driver = {
-	.name		= "amd8111 smbus 2",
+	.name		= "amd8111_smbus2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
 	.remove		= __devexit_p(amd8111_remove),
diff -Nru a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
--- a/drivers/i2c/busses/i2c-hydra.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-hydra.c	2004-08-23 11:02:22 -07:00
@@ -158,7 +158,7 @@
 
 
 static struct pci_driver hydra_driver = {
-	.name		= "hydra smbus",
+	.name		= "hydra_smbus",
 	.id_table	= hydra_ids,
 	.probe		= hydra_probe,
 	.remove		= __devexit_p(hydra_remove),
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-i801.c	2004-08-23 11:02:22 -07:00
@@ -623,7 +623,7 @@
 }
 
 static struct pci_driver i801_driver = {
-	.name		= "i801 smbus",
+	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
 	.remove		= __devexit_p(i801_remove),
diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-i810.c	2004-08-23 11:02:22 -07:00
@@ -231,7 +231,7 @@
 }
 
 static struct pci_driver i810_driver = {
-	.name		= "i810 smbus",
+	.name		= "i810_smbus",
 	.id_table	= i810_ids,
 	.probe		= i810_probe,
 	.remove		= __devexit_p(i810_remove),
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2004-08-23 11:02:22 -07:00
@@ -383,7 +383,7 @@
 }
 
 static struct pci_driver nforce2_driver = {
-	.name		= "nForce2 SMBus",
+	.name		= "nForce2_smbus",
 	.id_table	= nforce2_ids,
 	.probe		= nforce2_probe,
 	.remove		= __devexit_p(nforce2_remove),
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-piix4.c	2004-08-23 11:02:22 -07:00
@@ -493,7 +493,7 @@
 }
 
 static struct pci_driver piix4_driver = {
-	.name		= "piix4-smbus",
+	.name		= "piix4_smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
 	.remove		= __devexit_p(piix4_remove),
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-prosavage.c	2004-08-23 11:02:22 -07:00
@@ -314,7 +314,7 @@
 };
 
 static struct pci_driver prosavage_driver = {
-	.name		=	"prosavage-smbus",
+	.name		=	"prosavage_smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
 	.remove		=	prosavage_remove,
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-savage4.c	2004-08-23 11:02:22 -07:00
@@ -178,7 +178,7 @@
 }
 
 static struct pci_driver savage4_driver = {
-	.name		= "savage4 smbus",
+	.name		= "savage4_smbus",
 	.id_table	= savage4_ids,
 	.probe		= savage4_probe,
 	.remove		= __devexit_p(savage4_remove),
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-sis5595.c	2004-08-23 11:02:22 -07:00
@@ -393,7 +393,7 @@
 }
 
 static struct pci_driver sis5595_driver = {
-	.name		= "sis5595 smbus",
+	.name		= "sis5595_smbus",
 	.id_table	= sis5595_ids,
 	.probe		= sis5595_probe,
 	.remove		= __devexit_p(sis5595_remove),
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-sis630.c	2004-08-23 11:02:22 -07:00
@@ -495,7 +495,7 @@
 
 
 static struct pci_driver sis630_driver = {
-	.name		= "sis630 smbus",
+	.name		= "sis630_smbus",
 	.id_table	= sis630_ids,
 	.probe		= sis630_probe,
 	.remove		= __devexit_p(sis630_remove),
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-sis96x.c	2004-08-23 11:02:22 -07:00
@@ -339,7 +339,7 @@
 }
 
 static struct pci_driver sis96x_driver = {
-	.name		= "sis96x smbus",
+	.name		= "sis96x_smbus",
 	.id_table	= sis96x_ids,
 	.probe		= sis96x_probe,
 	.remove		= __devexit_p(sis96x_remove),
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-via.c	2004-08-23 11:02:22 -07:00
@@ -158,7 +158,7 @@
 
 
 static struct pci_driver vt586b_driver = {
-	.name		= "vt586b smbus",
+	.name		= "vt586b_smbus",
 	.id_table	= vt586b_ids,
 	.probe		= vt586b_probe,
 	.remove		= __devexit_p(vt586b_remove),
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-viapro.c	2004-08-23 11:02:22 -07:00
@@ -455,7 +455,7 @@
 };
 
 static struct pci_driver vt596_driver = {
-	.name		= "vt596 smbus",
+	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
 	.remove		= __devexit_p(vt596_remove),
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	2004-08-23 11:02:22 -07:00
+++ b/drivers/i2c/busses/i2c-voodoo3.c	2004-08-23 11:02:22 -07:00
@@ -224,7 +224,7 @@
 }
 
 static struct pci_driver voodoo3_driver = {
-	.name		= "voodoo3 smbus",
+	.name		= "voodoo3_smbus",
 	.id_table	= voodoo3_ids,
 	.probe		= voodoo3_probe,
 	.remove		= __devexit_p(voodoo3_remove),

