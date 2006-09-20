Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWITSwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWITSwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWITSwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:52:34 -0400
Received: from ns1.coraid.com ([65.14.39.133]:40568 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932250AbWITSwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:52:34 -0400
Message-ID: <ae75439bf257165c7114df7e33d328e2@coraid.com>
Date: Wed, 20 Sep 2006 14:34:41 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [01/14]: eliminate isbusy message
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message doesn't help users because the circumstance isn't problematic.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c	2006-09-20 14:29:35.000000000 -0400
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
