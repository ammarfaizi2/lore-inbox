Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWHGW4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWHGW4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWHGW4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:56:18 -0400
Received: from xenotime.net ([66.160.160.81]:24753 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750826AbWHGW4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:56:16 -0400
Date: Mon, 7 Aug 2006 15:52:08 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, dwmw2 <dwmw2@infradead.org>
Subject: [PATCH -mm 3/5] MTD: printk format warning
Message-Id: <20060807155208.666d7ea3.rdunlap@xenotime.net>
In-Reply-To: <20060807155044.a8eee456.rdunlap@xenotime.net>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
	<20060807155044.a8eee456.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning(s):
drivers/mtd/mtd_blkdevs.c:72: warning: long int format, different type arg (arg 2)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/mtd/mtd_blkdevs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc3mm2.orig/drivers/mtd/mtd_blkdevs.c
+++ linux-2618-rc3mm2/drivers/mtd/mtd_blkdevs.c
@@ -69,7 +69,7 @@ static int do_blktrans_request(struct mt
 		return 1;
 
 	default:
-		printk(KERN_NOTICE "Unknown request %ld\n", rq_data_dir(req));
+		printk(KERN_NOTICE "Unknown request %d\n", rq_data_dir(req));
 		return 0;
 	}
 }


---
