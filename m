Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbSIXRWm>; Tue, 24 Sep 2002 13:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSIXRWm>; Tue, 24 Sep 2002 13:22:42 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:53391 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261716AbSIXRWk> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 03_partition.
Date: Tue, 24 Sep 2002 19:18:00 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241918.00324.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct includes in ibm.c to make it compile.

diff -urN linux-2.5.38/fs/partitions/ibm.c linux-2.5.38-s390/fs/partitions/ibm.c
--- linux-2.5.38/fs/partitions/ibm.c	Sun Sep 22 06:25:31 2002
+++ linux-2.5.38-s390/fs/partitions/ibm.c	Tue Sep 24 17:41:45 2002
@@ -12,23 +12,16 @@
  */
 
 #include <linux/config.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/kernel.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/blk.h>
-#include <linux/slab.h>
+#include <linux/buffer_head.h>
 #include <linux/hdreg.h>
-#include <linux/ioctl.h>
-#include <linux/version.h>
+#include <linux/slab.h>
+#include <asm/dasd.h>
 #include <asm/ebcdic.h>
 #include <asm/uaccess.h>
-#include <asm/dasd.h>
+#include <asm/vtoc.h>
 
-#include "ibm.h"
 #include "check.h"
-#include <asm/vtoc.h>
+#include "ibm.h"
 
 /*
  * compute the block number from a 

