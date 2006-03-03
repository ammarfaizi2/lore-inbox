Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752124AbWCCBsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbWCCBsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWCCBsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:10 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:23021 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1752124AbWCCBsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:07 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 3/15] EDAC: name cleanup (remove old bluesmoke stuff)
Date: Thu, 2 Mar 2006 17:47:52 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021747.52338.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perform the following name substitutions on all source files:

    sed 's/BS_MOD_STR/EDAC_MOD_STR/g'
    sed 's/bs_thread_info/edac_thread_info/g'
    sed 's/bs_thread/edac_thread/g'
    sed 's/bs_xstr/edac_xstr/g'
    sed 's/bs_str/edac_str/g'

The names that start with BS_ or bs_ are artifacts of when the code
was called "bluesmoke".

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/amd76x_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -233,7 +233,7 @@ static int amd76x_probe1(struct pci_dev 
 	mci->edac_cap = ems_mode ?
 	    (EDAC_FLAG_EC | EDAC_FLAG_SECDED) : EDAC_FLAG_NONE;
 
-	mci->mod_name = BS_MOD_STR;
+	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = "$Revision: 1.4.2.5 $";
 	mci->ctl_name = amd76x_devs[dev_idx].ctl_name;
 	mci->edac_check = amd76x_check;
@@ -339,7 +339,7 @@ MODULE_DEVICE_TABLE(pci, amd76x_pci_tbl)
 
 
 static struct pci_driver amd76x_driver = {
-	.name = BS_MOD_STR,
+	.name = EDAC_MOD_STR,
 	.probe = amd76x_init_one,
 	.remove = __devexit_p(amd76x_remove_one),
 	.id_table = amd76x_pci_tbl,
Index: linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e752x_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -788,7 +788,7 @@ static int e752x_probe1(struct pci_dev *
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED |
 	    EDAC_FLAG_S4ECD4ED;
 	/* FIXME - what if different memory types are in different csrows? */
-	mci->mod_name = BS_MOD_STR;
+	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = "$Revision: 1.5.2.11 $";
 	mci->pdev = pdev;
 
@@ -1043,7 +1043,7 @@ MODULE_DEVICE_TABLE(pci, e752x_pci_tbl);
 
 
 static struct pci_driver e752x_driver = {
-	.name = BS_MOD_STR,
+	.name = EDAC_MOD_STR,
 	.probe = e752x_init_one,
 	.remove = __devexit_p(e752x_remove_one),
 	.id_table = e752x_pci_tbl,
Index: linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e7xxx_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -383,7 +383,7 @@ static int e7xxx_probe1(struct pci_dev *
 	mci->edac_ctl_cap =
 	    EDAC_FLAG_NONE | EDAC_FLAG_SECDED | EDAC_FLAG_S4ECD4ED;
 	/* FIXME - what if different memory types are in different csrows? */
-	mci->mod_name = BS_MOD_STR;
+	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = "$Revision: 1.5.2.9 $";
 	mci->pdev = pdev;
 
@@ -536,7 +536,7 @@ MODULE_DEVICE_TABLE(pci, e7xxx_pci_tbl);
 
 
 static struct pci_driver e7xxx_driver = {
-	.name = BS_MOD_STR,
+	.name = EDAC_MOD_STR,
 	.probe = e7xxx_init_one,
 	.remove = __devexit_p(e7xxx_remove_one),
 	.id_table = e7xxx_pci_tbl,
Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.h	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h	2006-02-27 16:58:41.000000000 -0800
@@ -80,9 +80,9 @@ extern int edac_debug_level;
 #endif				/* !CONFIG_EDAC_DEBUG */
 
 
-#define bs_xstr(s) bs_str(s)
-#define bs_str(s) #s
-#define BS_MOD_STR bs_xstr(KBUILD_BASENAME)
+#define edac_xstr(s) edac_str(s)
+#define edac_str(s) #s
+#define EDAC_MOD_STR edac_xstr(KBUILD_BASENAME)
 
 #define BIT(x) (1 << (x))
 
Index: linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82860_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -162,7 +162,7 @@ static int i82860_probe1(struct pci_dev 
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	/* adjust FLAGS */
 
-	mci->mod_name = BS_MOD_STR;
+	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = "$Revision: 1.1.2.6 $";
 	mci->ctl_name = i82860_devs[dev_idx].ctl_name;
 	mci->edac_check = i82860_check;
@@ -253,7 +253,7 @@ static const struct pci_device_id i82860
 MODULE_DEVICE_TABLE(pci, i82860_pci_tbl);
 
 static struct pci_driver i82860_driver = {
-	.name = BS_MOD_STR,
+	.name = EDAC_MOD_STR,
 	.probe = i82860_init_one,
 	.remove = __devexit_p(i82860_remove_one),
 	.id_table = i82860_pci_tbl,
Index: linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82875p_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -357,7 +357,7 @@ static int i82875p_probe1(struct pci_dev
 	mci->edac_cap = EDAC_FLAG_UNKNOWN;
 	/* adjust FLAGS */
 
-	mci->mod_name = BS_MOD_STR;
+	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = "$Revision: 1.5.2.11 $";
 	mci->ctl_name = i82875p_devs[dev_idx].ctl_name;
 	mci->edac_check = i82875p_check;
@@ -483,7 +483,7 @@ MODULE_DEVICE_TABLE(pci, i82875p_pci_tbl
 
 
 static struct pci_driver i82875p_driver = {
-	.name = BS_MOD_STR,
+	.name = EDAC_MOD_STR,
 	.probe = i82875p_init_one,
 	.remove = __devexit_p(i82875p_remove_one),
 	.id_table = i82875p_pci_tbl,
Index: linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/r82600_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c	2006-02-27 16:58:41.000000000 -0800
@@ -265,7 +265,7 @@ static int r82600_probe1(struct pci_dev 
 	} else
 		mci->edac_cap = EDAC_FLAG_NONE;
 
-	mci->mod_name = BS_MOD_STR;
+	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = "$Revision: 1.1.2.6 $";
 	mci->ctl_name = "R82600";
 	mci->edac_check = r82600_check;
@@ -376,7 +376,7 @@ MODULE_DEVICE_TABLE(pci, r82600_pci_tbl)
 
 
 static struct pci_driver r82600_driver = {
-	.name = BS_MOD_STR,
+	.name = EDAC_MOD_STR,
 	.probe = r82600_init_one,
 	.remove = __devexit_p(r82600_remove_one),
 	.id_table = r82600_pci_tbl,
