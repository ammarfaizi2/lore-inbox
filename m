Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTHVPDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbTHVPDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:03:30 -0400
Received: from [203.145.184.221] ([203.145.184.221]:3089 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263567AbTHVPD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:03:28 -0400
Subject: [PATCH 2.6.0-test3-bk9][ISDN] sedlbauer_cs.c: remove release timer
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 22 Aug 2003 20:36:23 +0530
Message-Id: <1061564783.1108.38.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

This patch removes the PCMCIA release timer you missed out in earlier
patch. This patch is required for successful compilation of the driver.

Vinay

--- linux-2.6.0-test3-bk9/drivers/isdn/hisax/sedlbauer_cs.c	2003-08-22 15:04:47.000000000 +0530
+++ linux-2.6.0-test3-nvk/drivers/isdn/hisax/sedlbauer_cs.c	2003-08-22 20:26:49.000000000 +0530
@@ -647,7 +647,6 @@
 
 	/* XXX: this really needs to move into generic code.. */
 	while (dev_list != NULL) {
-		del_timer(&dev_list->release);
 		if (dev_list->state & DEV_CONFIG)
 			sedlbauer_release(dev_list);
 		sedlbauer_detach(dev_list);



