Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUJTA0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUJTA0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUJTAYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:24:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:23988 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268206AbUJTATi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:38 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315072286@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:27 -0700
Message-Id: <10982315071856@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2079, 2004/10/19 16:46:21-07:00, greg@kroah.com

I2C: convert from pci_module_init to pci_register_driver for all i2c drivers.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ali1535.c   |    2 +-
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
 drivers/i2c/chips/via686a.c        |    2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-ali1535.c	2004-10-19 16:53:22 -07:00
@@ -529,7 +529,7 @@
 
 static int __init i2c_ali1535_init(void)
 {
-	return pci_module_init(&ali1535_driver);
+	return pci_register_driver(&ali1535_driver);
 }
 
 static void __exit i2c_ali1535_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-ali1563.c	2004-10-19 16:53:22 -07:00
@@ -405,7 +405,7 @@
 
 static int __init ali1563_init(void)
 {
-	return pci_module_init(&ali1563_pci_driver);
+	return pci_register_driver(&ali1563_pci_driver);
 }
 
 module_init(ali1563_init);
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-ali15x3.c	2004-10-19 16:53:22 -07:00
@@ -519,7 +519,7 @@
 
 static int __init i2c_ali15x3_init(void)
 {
-	return pci_module_init(&ali15x3_driver);
+	return pci_register_driver(&ali15x3_driver);
 }
 
 static void __exit i2c_ali15x3_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:53:22 -07:00
@@ -408,7 +408,7 @@
 
 static int __init amd756_init(void)
 {
-	return pci_module_init(&amd756_driver);
+	return pci_register_driver(&amd756_driver);
 }
 
 static void __exit amd756_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-amd8111.c	2004-10-19 16:53:22 -07:00
@@ -402,7 +402,7 @@
 
 static int __init i2c_amd8111_init(void)
 {
-	return pci_module_init(&amd8111_driver);
+	return pci_register_driver(&amd8111_driver);
 }
 
 
diff -Nru a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
--- a/drivers/i2c/busses/i2c-hydra.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-hydra.c	2004-10-19 16:53:22 -07:00
@@ -168,7 +168,7 @@
 
 static int __init i2c_hydra_init(void)
 {
-	return pci_module_init(&hydra_driver);
+	return pci_register_driver(&hydra_driver);
 }
 
 
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-i801.c	2004-10-19 16:53:22 -07:00
@@ -633,7 +633,7 @@
 
 static int __init i2c_i801_init(void)
 {
-	return pci_module_init(&i801_driver);
+	return pci_register_driver(&i801_driver);
 }
 
 static void __exit i2c_i801_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:53:22 -07:00
@@ -241,7 +241,7 @@
 
 static int __init i2c_i810_init(void)
 {
-	return pci_module_init(&i810_driver);
+	return pci_register_driver(&i810_driver);
 }
 
 static void __exit i2c_i810_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2004-10-19 16:53:22 -07:00
@@ -394,7 +394,7 @@
 
 static int __init nforce2_init(void)
 {
-	return pci_module_init(&nforce2_driver);
+	return pci_register_driver(&nforce2_driver);
 }
 
 static void __exit nforce2_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-piix4.c	2004-10-19 16:53:22 -07:00
@@ -503,7 +503,7 @@
 
 static int __init i2c_piix4_init(void)
 {
-	return pci_module_init(&piix4_driver);
+	return pci_register_driver(&piix4_driver);
 }
 
 static void __exit i2c_piix4_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:53:22 -07:00
@@ -324,7 +324,7 @@
 
 static int __init i2c_prosavage_init(void)
 {
-	return pci_module_init(&prosavage_driver);
+	return pci_register_driver(&prosavage_driver);
 }
 
 static void __exit i2c_prosavage_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:53:22 -07:00
@@ -188,7 +188,7 @@
 
 static int __init i2c_savage4_init(void)
 {
-	return pci_module_init(&savage4_driver);
+	return pci_register_driver(&savage4_driver);
 }
 
 static void __exit i2c_savage4_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-sis5595.c	2004-10-19 16:53:22 -07:00
@@ -403,7 +403,7 @@
 
 static int __init i2c_sis5595_init(void)
 {
-	return pci_module_init(&sis5595_driver);
+	return pci_register_driver(&sis5595_driver);
 }
 
 static void __exit i2c_sis5595_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-sis630.c	2004-10-19 16:53:22 -07:00
@@ -505,7 +505,7 @@
 
 static int __init i2c_sis630_init(void)
 {
-	return pci_module_init(&sis630_driver);
+	return pci_register_driver(&sis630_driver);
 }
 
 
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-sis96x.c	2004-10-19 16:53:22 -07:00
@@ -350,7 +350,7 @@
 static int __init i2c_sis96x_init(void)
 {
 	printk(KERN_INFO "i2c-sis96x version %s\n", SIS96x_VERSION);
-	return pci_module_init(&sis96x_driver);
+	return pci_register_driver(&sis96x_driver);
 }
 
 static void __exit i2c_sis96x_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-via.c	2004-10-19 16:53:22 -07:00
@@ -168,7 +168,7 @@
 
 static int __init i2c_vt586b_init(void)
 {
-	return pci_module_init(&vt586b_driver);
+	return pci_register_driver(&vt586b_driver);
 }
 
 static void __exit i2c_vt586b_exit(void)
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-viapro.c	2004-10-19 16:53:22 -07:00
@@ -465,7 +465,7 @@
 
 static int __init i2c_vt596_init(void)
 {
-	return pci_module_init(&vt596_driver);
+	return pci_register_driver(&vt596_driver);
 }
 
 
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:53:22 -07:00
@@ -234,7 +234,7 @@
 
 static int __init i2c_voodoo3_init(void)
 {
-	return pci_module_init(&voodoo3_driver);
+	return pci_register_driver(&voodoo3_driver);
 }
 
 static void __exit i2c_voodoo3_exit(void)
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2004-10-19 16:53:22 -07:00
+++ b/drivers/i2c/chips/via686a.c	2004-10-19 16:53:22 -07:00
@@ -838,7 +838,7 @@
 
 static int __init sm_via686a_init(void)
 {
-       return pci_module_init(&via686a_pci_driver);
+       return pci_register_driver(&via686a_pci_driver);
 }
 
 static void __exit sm_via686a_exit(void)

