Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291415AbSBHFMq>; Fri, 8 Feb 2002 00:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291421AbSBHFMg>; Fri, 8 Feb 2002 00:12:36 -0500
Received: from holomorphy.com ([216.36.33.161]:35472 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291415AbSBHFMW>;
	Fri, 8 Feb 2002 00:12:22 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix i810_dma.c freeing mem inside mem_map
Message-Id: <E16Z3Kb-0003cm-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 07 Feb 2002 21:12:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux/drivers/char/drm/i810_dma.c.bak	Thu Feb  7 21:09:49 2002
+++ linux/drivers/char/drm/i810_dma.c	Thu Feb  7 21:09:59 2002
@@ -301,7 +301,7 @@
 		atomic_dec(&p->count);
 		clear_bit(PG_locked, &p->flags);
 		wake_up_page(p);
-		free_page(p);
+		free_page(page);
 	}
 }
 
