Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVC0OwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVC0OwR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVC0OuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:50:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7181 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261685AbVC0OeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:34:22 -0500
Date: Sun, 27 Mar 2005 16:34:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/dpti.h: remove kernel 2.2 #if's
Message-ID: <20050327143421.GF4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if's for kernel 2.2 .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Mar 2005

 drivers/scsi/dpti.h |   10 ----------
 1 files changed, 10 deletions(-)

--- linux-2.6.11-mm2-full/drivers/scsi/dpti.h.old	2005-03-12 12:22:23.000000000 +0100
+++ linux-2.6.11-mm2-full/drivers/scsi/dpti.h	2005-03-12 12:22:46.000000000 +0100
@@ -20,15 +20,9 @@
 #ifndef _DPT_H
 #define _DPT_H
 
-#ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
-#endif

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,00)
-#define MAX_TO_IOP_MESSAGES   (210)
-#else
 #define MAX_TO_IOP_MESSAGES   (255)
-#endif
 #define MAX_FROM_IOP_MESSAGES (255)
 
 
@@ -321,10 +313,6 @@
 static void adpt_delay(int millisec);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-static struct pci_dev* adpt_pci_find_device(uint vendor, struct pci_dev* from);
-#endif
-
 #if defined __ia64__ 
 static void adpt_ia64_info(sysInfo_S* si);
 #endif

