Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVCEPfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVCEPfE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCEPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:33:19 -0500
Received: from coderock.org ([193.77.147.115]:32163 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261626AbVCEPb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:31:28 -0500
Subject: [patch 3/3] drivers/char/agp/*: convert to pci_register_driver
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, c.lucas@ifrance.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:31:11 +0100
Message-Id: <20050305153112.4DFAC1F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/agp/ali-agp.c       |    2 +-
 kj-domen/drivers/char/agp/amd-k7-agp.c    |    2 +-
 kj-domen/drivers/char/agp/amd64-agp.c     |    2 +-
 kj-domen/drivers/char/agp/ati-agp.c       |    2 +-
 kj-domen/drivers/char/agp/efficeon-agp.c  |    2 +-
 kj-domen/drivers/char/agp/i460-agp.c      |    2 +-
 kj-domen/drivers/char/agp/intel-agp.c     |    2 +-
 kj-domen/drivers/char/agp/intel-mch-agp.c |    2 +-
 kj-domen/drivers/char/agp/nvidia-agp.c    |    2 +-
 kj-domen/drivers/char/agp/sis-agp.c       |    2 +-
 kj-domen/drivers/char/agp/sworks-agp.c    |    2 +-
 kj-domen/drivers/char/agp/uninorth-agp.c  |    2 +-
 kj-domen/drivers/char/agp/via-agp.c       |    2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff -puN drivers/char/agp/ali-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/ali-agp.c
--- kj/drivers/char/agp/ali-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/ali-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -398,7 +398,7 @@ static int __init agp_ali_init(void)
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_ali_pci_driver);
+	return pci_register_driver(&agp_ali_pci_driver);
 }
 
 static void __exit agp_ali_cleanup(void)
diff -puN drivers/char/agp/amd-k7-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/amd-k7-agp.c
--- kj/drivers/char/agp/amd-k7-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/amd-k7-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -480,7 +480,7 @@ static int __init agp_amdk7_init(void)
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_amdk7_pci_driver);
+	return pci_register_driver(&agp_amdk7_pci_driver);
 }
 
 static void __exit agp_amdk7_cleanup(void)
diff -puN drivers/char/agp/amd64-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/amd64-agp.c
--- kj/drivers/char/agp/amd64-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/amd64-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -709,7 +709,7 @@ int __init agp_amd64_init(void)
 
 	if (agp_off)
 		return -EINVAL;
-	if (pci_module_init(&agp_amd64_pci_driver) > 0) {
+	if (pci_register_driver(&agp_amd64_pci_driver) > 0) {
 		struct pci_dev *dev;
 		if (!agp_try_unsupported && !agp_try_unsupported_boot) {
 			printk(KERN_INFO PFX "No supported AGP bridge found.\n");
diff -puN drivers/char/agp/ati-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/ati-agp.c
--- kj/drivers/char/agp/ati-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/ati-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -531,7 +531,7 @@ static int __init agp_ati_init(void)
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_ati_pci_driver);
+	return pci_register_driver(&agp_ati_pci_driver);
 }
 
 static void __exit agp_ati_cleanup(void)
diff -puN drivers/char/agp/efficeon-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/efficeon-agp.c
--- kj/drivers/char/agp/efficeon-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/efficeon-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -448,7 +448,7 @@ static int __init agp_efficeon_init(void
 		return 0;
 	agp_initialised=1;
 
-	return pci_module_init(&agp_efficeon_pci_driver);
+	return pci_register_driver(&agp_efficeon_pci_driver);
 }
 
 static void __exit agp_efficeon_cleanup(void)
diff -puN drivers/char/agp/i460-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/i460-agp.c
--- kj/drivers/char/agp/i460-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/i460-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -624,7 +624,7 @@ static int __init agp_intel_i460_init(vo
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_intel_i460_pci_driver);
+	return pci_register_driver(&agp_intel_i460_pci_driver);
 }
 
 static void __exit agp_intel_i460_cleanup(void)
diff -puN drivers/char/agp/intel-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/intel-agp.c
--- kj/drivers/char/agp/intel-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/intel-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -1810,7 +1810,7 @@ static struct pci_driver agp_intel_pci_d
 
 static int __init agp_intel_init(void)
 {
-	return pci_module_init(&agp_intel_pci_driver);
+	return pci_register_driver(&agp_intel_pci_driver);
 }
 
 static void __exit agp_intel_cleanup(void)
diff -puN drivers/char/agp/intel-mch-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/intel-mch-agp.c
--- kj/drivers/char/agp/intel-mch-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/intel-mch-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -627,7 +627,7 @@ int __init agp_intelmch_init(void)
 		return 0;
 	agp_initialised=1;
 
-	return pci_module_init(&agp_intelmch_pci_driver);
+	return pci_register_driver(&agp_intelmch_pci_driver);
 }
 
 static void __exit agp_intelmch_cleanup(void)
diff -puN drivers/char/agp/nvidia-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/nvidia-agp.c
--- kj/drivers/char/agp/nvidia-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/nvidia-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -407,7 +407,7 @@ static int __init agp_nvidia_init(void)
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_nvidia_pci_driver);
+	return pci_register_driver(&agp_nvidia_pci_driver);
 }
 
 static void __exit agp_nvidia_cleanup(void)
diff -puN drivers/char/agp/sis-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/sis-agp.c
--- kj/drivers/char/agp/sis-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/sis-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -342,7 +342,7 @@ static int __init agp_sis_init(void)
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_sis_pci_driver);
+	return pci_register_driver(&agp_sis_pci_driver);
 }
 
 static void __exit agp_sis_cleanup(void)
diff -puN drivers/char/agp/sworks-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/sworks-agp.c
--- kj/drivers/char/agp/sworks-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/sworks-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -541,7 +541,7 @@ static int __init agp_serverworks_init(v
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_serverworks_pci_driver);
+	return pci_register_driver(&agp_serverworks_pci_driver);
 }
 
 static void __exit agp_serverworks_cleanup(void)
diff -puN drivers/char/agp/uninorth-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/uninorth-agp.c
--- kj/drivers/char/agp/uninorth-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/uninorth-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -375,7 +375,7 @@ static int __init agp_uninorth_init(void
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_uninorth_pci_driver);
+	return pci_register_driver(&agp_uninorth_pci_driver);
 }
 
 static void __exit agp_uninorth_cleanup(void)
diff -puN drivers/char/agp/via-agp.c~pci_register_driver-drivers_char_agp drivers/char/agp/via-agp.c
--- kj/drivers/char/agp/via-agp.c~pci_register_driver-drivers_char_agp	2005-03-05 16:12:17.000000000 +0100
+++ kj-domen/drivers/char/agp/via-agp.c	2005-03-05 16:12:17.000000000 +0100
@@ -525,7 +525,7 @@ static int __init agp_via_init(void)
 {
 	if (agp_off)
 		return -EINVAL;
-	return pci_module_init(&agp_via_pci_driver);
+	return pci_register_driver(&agp_via_pci_driver);
 }
 
 static void __exit agp_via_cleanup(void)
_
