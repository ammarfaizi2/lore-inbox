Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSJPVee>; Wed, 16 Oct 2002 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSJPVed>; Wed, 16 Oct 2002 17:34:33 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:42512 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261434AbSJPVdc>; Wed, 16 Oct 2002 17:33:32 -0400
Date: Wed, 16 Oct 2002 15:35:46 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH 3/8] 2.5.43 cciss init gendisk->fops
Message-ID: <20021016153546.C2968@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Initialize cciss gendisk->fops

diff -urN linux-2.5.43-b/drivers/block/cciss.c linux-2.5.43-c/drivers/block/cciss.c
--- linux-2.5.43-b/drivers/block/cciss.c	Wed Oct 16 08:15:16 2002
+++ linux-2.5.43-c/drivers/block/cciss.c	Wed Oct 16 08:18:43 2002
@@ -2447,6 +2447,7 @@
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
 		disk->major = MAJOR_NR + i;
 		disk->first_minor = j << NWD_SHIFT;
+		disk->fops = &cciss_fops;
 		if( !(drv->nr_blocks))
 			continue;
 		(BLK_DEFAULT_QUEUE(MAJOR_NR + i))->hardsect_size = drv->block_size;
