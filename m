Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317289AbSFGOZ0>; Fri, 7 Jun 2002 10:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317294AbSFGOZZ>; Fri, 7 Jun 2002 10:25:25 -0400
Received: from h-64-105-137-63.SNVACAID.covad.net ([64.105.137.63]:32719 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317289AbSFGOZY>; Fri, 7 Jun 2002 10:25:24 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 7 Jun 2002 07:25:19 -0700
Message-Id: <200206071425.HAA00276@baldur.yggdrasil.com>
To: torvalds@transmeta.com
Subject: Trivial PATCH: linux-2.5.20/include/linux/blkdev.h - BLK_DEFAULT_QUEUE needs parentheses
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The definition of BLK_DEFAULT_QUEUE in
linux-2.5.20/include/linux/blkdev.h needs parentheses.  Otherwise,
expressions like "DEFAULT_BLK_QUEUE(major)->queuedata" generate
compiler errors.

	Here is the patch.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.20/include/linux/blkdev.h	2002-06-02 18:44:44.000000000 -0700
+++ linux/include/linux/blkdev.h	2002-06-07 07:21:15.000000000 -0700
@@ -281,7 +281,7 @@
  * so as to eliminate the need for each and every block device
  * driver to know about the internal structure of blk_dev[].
  */
-#define BLK_DEFAULT_QUEUE(_MAJOR)  &blk_dev[_MAJOR].request_queue
+#define BLK_DEFAULT_QUEUE(_MAJOR)  (&blk_dev[_MAJOR].request_queue)
 
 extern struct sec_size * blk_sec[MAX_BLKDEV];
 extern struct blk_dev_struct blk_dev[MAX_BLKDEV];
