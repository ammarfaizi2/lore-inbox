Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263445AbSJGXaw>; Mon, 7 Oct 2002 19:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263450AbSJGXaw>; Mon, 7 Oct 2002 19:30:52 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:10491 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S263445AbSJGXav>;
	Mon, 7 Oct 2002 19:30:51 -0400
Date: Mon, 7 Oct 2002 19:36:27 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: viro@math.psu.edu, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.41: cpqarray compile fixes
Message-ID: <20021007233627.GB24284@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpqarray in 2.5.41 needs the patch below to compile. 

--Adam

--- linux-2.5.41/drivers/block/cpqarray.c	Mon Oct  7 18:26:32 2002
+++ linux-2.5.41-fix/drivers/block/cpqarray.c	Mon Oct  7 19:25:48 2002
@@ -355,7 +355,7 @@
 		}
 		num_cntlrs_reg++;
 		for (j=0; j<NWD; j++) {
-			ida_gendisk[i][j] = disk_alloc();
+			ida_gendisk[i][j] = alloc_disk();
 			if (!ida_gendisk[i][j])
 				goto Enomem2;
 		}
@@ -437,7 +437,6 @@
 	}
 	return 0;
 }
-}
 
 /*
  * Find the controller and initialize it

