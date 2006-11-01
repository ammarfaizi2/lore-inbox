Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752487AbWKAVtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbWKAVtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbWKAVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:49:22 -0500
Received: from palrel12.hp.com ([156.153.255.237]:48619 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1750701AbWKAVtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:49:21 -0500
Date: Wed, 1 Nov 2006 15:49:13 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/8] cciss: version number change
Message-ID: <20061101214913.GA29928@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PATCH 1/8

This patch changes the cciss version number to 3.6.14 to reflect the following
functionality changes added by the rest of the set. They include:

Support to fire up on any HP RAID class controller
Increase nr_cmds to 512 for most controllers by adding it to the product table
PCI subsystem ID fix fix was pulled
Disable DMA prefetch for the P600 on IPF platforms
Change from 512 to 2048 sector_size for performance
Fix in cciss_open for consistency
Remove the no longer used revalidate_allvol function

Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)
--------------------------------------------------------------------------------
diff -urNp linux-2.6.orig/drivers/block/cciss.c linux-2.6/drivers/block/cciss.c
--- linux-2.6.orig/drivers/block/cciss.c	2006-10-27 11:16:05.000000000 -0500
+++ linux-2.6/drivers/block/cciss.c	2006-10-31 14:01:04.000000000 -0600
@@ -47,14 +47,15 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 3.6.10)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(3,6,10)
+#define DRIVER_NAME "HP CISS Driver (v 3.6.14)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(3,6,14)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 3.6.10");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 3.6.14");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
 			" SA6i P600 P800 P400 P400i E200 E200i E500");
+MODULE_VERSION("3.6.14");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
