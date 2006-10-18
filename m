Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422807AbWJRUJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbWJRUJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422812AbWJRUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:13 -0400
Received: from ns1.suse.de ([195.135.220.2]:6322 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422809AbWJRUJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:11 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/15] aoe: eliminate isbusy message
Date: Wed, 18 Oct 2006 13:08:52 -0700
Message-Id: <11612021463993-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <20061018200433.GA10079@kroah.com>
References: <20061018200433.GA10079@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

This message doesn't help users because the circumstance isn't problematic.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoedev.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index ed4258a..c2bc3ed 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
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
1.4.2.4

