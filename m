Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVHOVUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVHOVUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVHOVUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:20:40 -0400
Received: from palrel13.hp.com ([156.153.255.238]:44772 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S964968AbVHOVUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:20:39 -0400
Date: Mon, 15 Aug 2005 16:20:14 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/4] cciss 2.4: adds BLKSSZGET ioctl for Oracle
Message-ID: <20050815212014.GC12760@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2/4
This patch adds the BLKSSZGET ioctl for Oracle. Please consider this for 
inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    1 +
 1 files changed, 1 insertion(+)
--------------------------------------------------------------------------------
diff -burNp lx2431-p001/drivers/block/cciss.c lx2431/drivers/block/cciss.c
--- lx2431-p001/drivers/block/cciss.c	2005-08-15 14:43:50.375342000 -0500
+++ lx2431/drivers/block/cciss.c	2005-08-15 15:13:15.484004696 -0500
@@ -747,6 +747,7 @@ static int cciss_ioctl(struct inode *ino
 	case BLKPG:
 	case BLKELVGET:
 	case BLKELVSET:
+	case BLKSSZGET:
 		return blk_ioctl(inode->i_rdev, cmd, arg);
 	case CCISS_GETPCIINFO:
 	{
