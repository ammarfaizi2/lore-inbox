Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSEXQIY>; Fri, 24 May 2002 12:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314484AbSEXQGa>; Fri, 24 May 2002 12:06:30 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:63203 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S314483AbSEXQGF>;
	Fri, 24 May 2002 12:06:05 -0400
Date: Fri, 24 May 2002 19:06:03 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18-pre8 compile fix (pagemap.h)
Message-ID: <Pine.GSO.4.43.0205241902580.6430-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a compile error in case where all possible partition types
are configured in. This patch was floating around on l-k a week or two
ago, I'm not the author. This patch fixes the problem for me.

--- fs/partitions/check.h.old	Fri May 24 18:59:10 2002
+++ fs/partitions/check.h	Fri May 24 18:59:36 2002
@@ -2,6 +2,9 @@
  * add_partition adds a partitions details to the devices partition
  * description.
  */
+
+#include <linux/pagemap.h>
+
 void add_gd_partition(struct gendisk *hd, int minor, int start, int size);

 typedef struct {struct page *v;} Sector;



-- 
Meelis Roos (mroos@linux.ee)


