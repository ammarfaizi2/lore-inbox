Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267460AbTAGU3A>; Tue, 7 Jan 2003 15:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbTAGU3A>; Tue, 7 Jan 2003 15:29:00 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:51114 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S267460AbTAGU2y>;
	Tue, 7 Jan 2003 15:28:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AGP 3/7: remove unused var in amd-k8-agp.c
Date: Tue, 7 Jan 2003 13:37:34 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301071337.34006.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.973   -> 1.974  
#	drivers/char/agp/amd-k8-agp.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	bjorn_helgaas@hp.com	1.974
# Remove unused variable in amd-k8-agp.c
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/amd-k8-agp.c b/drivers/char/agp/amd-k8-agp.c
--- a/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:15 2003
+++ b/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:15 2003
@@ -336,7 +336,6 @@
 	struct pci_dev *device = NULL;
 	u32 command, scratch; 
 	u8 cap_ptr;
-	u8 agp_v3;
 	u8 v3_devs=0;
 
 	/* FIXME: If 'mode' is x1/x2/x4 should we call the AGPv2 routines directly ?
@@ -387,7 +386,6 @@
 			printk (KERN_INFO "AGP: Setting up AGPv3 capable device at %d:%d:%d\n",
 					device->bus->number, PCI_FUNC(device->devfn), PCI_SLOT(device->devfn));
 			pci_read_config_dword(device, cap_ptr + 4, &scratch);
-			agp_v3 = (scratch & (1<<3) ) >>3;
 
 			/* adjust RQ depth */
 			command =

