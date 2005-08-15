Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVHOVYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVHOVYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVHOVYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:24:48 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:16016 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964978AbVHOVYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:24:47 -0400
Date: Mon, 15 Aug 2005 16:24:25 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 4/4] cciss 2.4: fixes a warning from cciss_scsi.c during compile
Message-ID: <20050815212425.GE12760@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4/4
This patch fixes a warning during compile.
Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss_scsi.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2431-p003/drivers/block/cciss_scsi.c lx2431/drivers/block/cciss_scsi.c
--- lx2431-p003/drivers/block/cciss_scsi.c	2004-08-07 18:26:04.000000000 -0500
+++ lx2431/drivers/block/cciss_scsi.c	2005-08-15 16:03:10.022765608 -0500
@@ -220,8 +220,7 @@ scsi_cmd_stack_free(int ctlr)
 		printk( "cciss: %d scsi commands are still outstanding.\n",
 			CMD_STACK_SIZE - stk->top);
 		// BUG();
-		printk("WE HAVE A BUG HERE!!! stk=0x%08x\n",
-			(unsigned int) stk);
+		printk("WE HAVE A BUG HERE!!! stk=0x%p\n", stk);
 	}
 	size = sizeof(struct cciss_scsi_cmd_stack_elem_t) * CMD_STACK_SIZE;
 
