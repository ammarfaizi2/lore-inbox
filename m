Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUIWUR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUIWUR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUIWUR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:17:59 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42888 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S264396AbUIWUR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:17:56 -0400
Subject: [patch 1/3]  cpqarray remove unused include
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:17:56 +0200
Message-ID: <E1CAa2P-0006vE-5W@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  remove unused #include <linux/version.h>
  Old ifdefs were removed that used it's definition.


Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/block/cpqarray.c |   14 --------------
 1 files changed, 14 deletions(-)

diff -puN drivers/block/cpqarray.c~remove-old-ifdefs-cpqarray drivers/block/cpqarray.c
--- linux-2.6.9-rc2-bk7/drivers/block/cpqarray.c~remove-old-ifdefs-cpqarray	2004-09-21 20:46:55.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/cpqarray.c	2004-09-21 20:46:55.000000000 +0200
@@ -21,7 +21,6 @@
  */
 #include <linux/config.h>	/* CONFIG_PROC_FS */
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/bio.h>
@@ -732,7 +731,6 @@ static void *remap_pci_mem(ulong base, u
 }
 
 #ifndef MODULE
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13)
 /*
  * Config string is a comma separated set of i/o addresses of EISA cards.
  */
@@ -749,18 +747,6 @@ static int cpqarray_setup(char *str)
 
 __setup("smart2=", cpqarray_setup);
 
-#else
-
-/*
- * Copy the contents of the ints[] array passed to us by init.
- */
-void cpqarray_setup(char *str, int *ints)
-{
-	int i;
-	for(i=0; i<ints[0] && i<8; i++)
-		eisa[i] = ints[i+1];
-}
-#endif
 #endif
 
 /*
_
