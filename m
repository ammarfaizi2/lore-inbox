Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271290AbTGQQ0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271327AbTGQQZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:25:24 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:18639 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S271319AbTGQQYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:24:44 -0400
Date: Thu, 17 Jul 2003 18:38:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/6): dasd driver.
Message-ID: <20030717163831.GD2045@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove put_disk from dasd_destroy_partitions. This is done in dasd_free_device.

diffstat:
 drivers/s390/block/dasd_genhd.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -urN linux-2.6.0-test1/drivers/s390/block/dasd_genhd.c linux-2.6.0-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.6.0-test1/drivers/s390/block/dasd_genhd.c	Mon Jul 14 05:36:47 2003
+++ linux-2.6.0-s390/drivers/s390/block/dasd_genhd.c	Thu Jul 17 17:27:31 2003
@@ -9,7 +9,7 @@
  *
  * Dealing with devices registered to multiple major numbers.
  *
- * $Revision: 1.29 $
+ * $Revision: 1.31 $
  */
 
 #include <linux/config.h>
@@ -200,7 +200,6 @@
 dasd_destroy_partitions(struct dasd_device * device)
 {
 	del_gendisk(device->gdp);
-	put_disk(device->gdp);
 }
 
 int
