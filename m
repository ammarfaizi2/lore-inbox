Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261828AbSJIMkq>; Wed, 9 Oct 2002 08:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbSJIMaL>; Wed, 9 Oct 2002 08:30:11 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:36304 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261616AbSJIM3z> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390 (5/8): superfluous memset.
Date: Wed, 9 Oct 2002 14:30:25 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091430.25750.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicate memset. That is already done in alloc_disk.

diff -urN linux-2.5.41/drivers/s390/block/dasd_genhd.c linux-2.5.41-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.41/drivers/s390/block/dasd_genhd.c	Mon Oct  7 20:24:48 2002
+++ linux-2.5.41-s390/drivers/s390/block/dasd_genhd.c	Wed Oct  9 14:01:35 2002
@@ -195,7 +195,6 @@
 		return ERR_PTR(-ENOMEM);
 
 	/* Initialize gendisk structure. */
-	memset(gdp, 0, sizeof(struct gendisk));
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->minor_shift = DASD_PARTN_BITS;

