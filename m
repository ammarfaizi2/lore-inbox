Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbSJDRfB>; Fri, 4 Oct 2002 13:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSJDRfB>; Fri, 4 Oct 2002 13:35:01 -0400
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:18586 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262799AbSJDRfA> convert rfc822-to-8bit; Fri, 4 Oct 2002 13:35:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (5/27): ibm partition.
Date: Fri, 4 Oct 2002 16:26:27 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041626.15960.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct includes in ibm.c to make it compile.

diff -urN linux-2.5.40/fs/partitions/ibm.c linux-2.5.40-s390/fs/partitions/ibm.c
--- linux-2.5.40/fs/partitions/ibm.c	Tue Oct  1 09:07:45 2002
+++ linux-2.5.40-s390/fs/partitions/ibm.c	Fri Oct  4 16:14:59 2002
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

