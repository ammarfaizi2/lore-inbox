Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWHRSvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWHRSvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHRSvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:51:55 -0400
Received: from ns1.coraid.com ([65.14.39.133]:48229 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750986AbWHRSvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:51:55 -0400
Message-ID: <6a9b724fbffdcf29b863a289f95266e9@coraid.com>
Date: Fri, 18 Aug 2006 13:37:37 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [01/13]: eliminate isbusy message
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

This message doesn't help users because the circumstance isn't problematic.

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c	2006-08-17 16:45:34.000000000 -0400
@@ -20,11 +20,8 @@ aoedev_isbusy(struct aoedev *d)
 	f = d->frames;
 	e = f + d->nframes;
 	do {
-		if (f->tag != FREETAG) {
-			printk(KERN_DEBUG "aoe: %ld.%ld isbusy\n",
-				d->aoemajor, d->aoeminor);
+		if (f->tag != FREETAG)
 			return 1;
-		}
 	} while (++f < e);
 
 	return 0;


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
