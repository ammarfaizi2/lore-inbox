Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266688AbUGLC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266688AbUGLC4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUGLC4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 22:56:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5073 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266688AbUGLCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 22:55:12 -0400
Date: Mon, 12 Jul 2004 04:55:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] another small advansys cleanup
Message-ID: <20040712025509.GK4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following small cleanups for the advansys
driver:
- remove obsolete maintainer information
- remove kernel 2.2 code from advansys.h

diffstat output:
 MAINTAINERS             |    7 
 drivers/scsi/advansys.c |  342 +++++++---------------------------------
 drivers/scsi/advansys.h |   26 ---
 3 files changed, 60 insertions(+), 315 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.6-mm5-full/drivers/scsi/advansys.h.old	2004-05-22 14:42:56.000000000 +0200
+++ linux-2.6.6-mm5-full/drivers/scsi/advansys.h	2004-05-22 14:47:56.000000000 +0200
@@ -13,37 +13,11 @@
  * As of March 8, 2000 Advanced System Products, Inc. (AdvanSys)
  * changed its name to ConnectCom Solutions, Inc.
  *
- * There is an AdvanSys Linux WWW page at:
- *  http://www.connectcom.net/downloads/software/os/linux.html
- *  http://www.advansys.com/linux.html
- *
- * The latest released version of the AdvanSys driver is available at:
- *  ftp://ftp.advansys.com/pub/linux/linux.tgz
- *  ftp://ftp.connectcom.net/pub/linux/linux.tgz
- *
- * Please send questions, comments, bug reports to:
- *  linux@connectcom.net or bfrey@turbolinux.com.cn
  */
 
 #ifndef _ADVANSYS_H
 #define _ADVANSYS_H
 
-#include <linux/config.h>
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif /* LINUX_VERSION_CODE */
-
-/* Convert Linux Version, Patch-level, Sub-level to LINUX_VERSION_CODE. */
-#define ASC_LINUX_VERSION(V, P, S)    (((V) * 65536) + ((P) * 256) + (S))
-/* Driver supported only in version 2.2 and version >= 2.4. */
-#if LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,2,0) || \
-    (LINUX_VERSION_CODE > ASC_LINUX_VERSION(2,3,0) && \
-     LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,4,0))
-#error "AdvanSys driver supported only in 2.2 and 2.4 or greater kernels."
-#endif
-#define ASC_LINUX_KERNEL22 (LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,4,0))
-#define ASC_LINUX_KERNEL24 (LINUX_VERSION_CODE >= ASC_LINUX_VERSION(2,4,0))
-
 /*
  * Scsi_Host_Template function prototypes.
  */
--- linux-2.6.6-mm5-full/drivers/scsi/advansys.c.old	2004-05-22 14:31:42.000000000 +0200
+++ linux-2.6.6-mm5-full/drivers/scsi/advansys.c	2004-05-22 14:47:45.000000000 +0200
@@ -15,16 +15,6 @@
  * As of March 8, 2000 Advanced System Products, Inc. (AdvanSys)
  * changed its name to ConnectCom Solutions, Inc.
  *
- * There is an AdvanSys Linux WWW page at:
- *  http://www.connectcom.net/downloads/software/os/linux.html
- *  http://www.advansys.com/linux.html
- *
- * The latest released version of the AdvanSys driver is available at:
- *  ftp://ftp.advansys.com/pub/linux/linux.tgz
- *  ftp://ftp.connectcom.net/pub/linux/linux.tgz
- *
- * Please send questions, comments, bug reports to:
- *  support@connectcom.net
  */
 
 /*
@@ -41,7 +31,6 @@
   H. Release History
   I. Known Problems/Fix List
   J. Credits (Chronological Order)
-  K. ConnectCom (AdvanSys) Contact Information
 
   A. Linux Kernels Supported by this Driver
 
@@ -2123,9 +2080,6 @@
 #define ADV_LIB_VERSION_MAJOR  5
 #define ADV_LIB_VERSION_MINOR  14
 
-/* d_os_dep.h */
-#define ADV_OS_LINUX
-
 /*
  * Define Adv Library required special types.
  */

