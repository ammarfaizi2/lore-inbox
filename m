Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVAGXEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVAGXEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVAGXDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:03:10 -0500
Received: from palrel11.hp.com ([156.153.255.246]:15811 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261699AbVAGXBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:01:13 -0500
Date: Fri, 7 Jan 2005 17:01:03 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2.6] cciss typo fix
Message-ID: <20050107230103.GB26037@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a stupid typo. I thought I submitted this but I don't seem to
find it anywhere.

 cciss.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Signed-off-by: Mike Miller <mike.miller@hp.com>
-------------------------------------------------------------------------------
diff -burNp lx2610-p001/drivers/block/cciss.c lx2610/drivers/block/cciss.c
--- lx2610-p001/drivers/block/cciss.c	2005-01-07 15:29:29.645792288 -0600
+++ lx2610/drivers/block/cciss.c	2005-01-07 15:29:59.490255240 -0600
@@ -1505,8 +1505,8 @@ cciss_read_capacity(int ctlr, int logvol
 		return_code = sendcmd(CCISS_READ_CAPACITY,
 			ctlr, buf, sizeof(*buf), 1, logvol, 0, NULL, TYPE_CMD);
 	if (return_code == IO_OK) {
-		*total_size = be32_to_cpu(*((__be32 *) &buf->total_size[0]))+1;
-		*block_size = be32_to_cpu(*((__be32 *) &buf->block_size[0]));
+		*total_size = be32_to_cpu(*((__u32 *) &buf->total_size[0]))+1;
+		*block_size = be32_to_cpu(*((__u32 *) &buf->block_size[0]));
 	} else { /* read capacity command failed */
 		printk(KERN_WARNING "cciss: read capacity failed\n");
 		*total_size = 0;
