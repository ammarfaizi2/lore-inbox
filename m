Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753177AbWKFULY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbWKFULY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbWKFULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:11:24 -0500
Received: from palrel12.hp.com ([156.153.255.237]:44465 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1753054AbWKFULX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:11:23 -0500
Date: Mon, 6 Nov 2006 14:11:22 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/12] repost: cciss: version change
Message-ID: <20061106201122.GA17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1/12
Per Jens' request this is a repost of the complete patch set from last week. 

This patch changes the cciss version number to 3.6.14 to reflect the following
functionality changes added by the rest of the set. They include:

Support to fire up on any HP RAID class controller
Increase nr_cmds to 512 for most controllers by adding it to the product table
PCI subsystem ID fix fix was pulled
Disable DMA prefetch for the P600 on IPF platforms
Change from 512 to 2048 sector_size for performance
Fix in cciss_open for consistency
Remove the no longer used revalidate_allvol function
Bug fix for busy configuring
Support for more than 16 logical volumes
Cleanups in cciss_interrupt_mode
Fix for iostats, it's been broken for several kernel releases

Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

--------------------------------------------------------------------------------
---

 drivers/block/cciss.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/block/cciss.c~cciss_3614_for_lx2619-rc2 drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_3614_for_lx2619-rc2	2006-11-06 13:15:02.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:15:02.000000000 -0600
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
_
