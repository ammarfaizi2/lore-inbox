Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTJXDcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 23:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTJXDcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 23:32:15 -0400
Received: from user-118bg4o.cable.mindspring.com ([66.133.192.152]:24716 "EHLO
	BL4ST") by vger.kernel.org with ESMTP id S261923AbTJXDcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 23:32:14 -0400
Date: Thu, 23 Oct 2003 20:32:26 -0700
From: Eric Wong <normalperson@yhbt.net>
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial compile fix when FANCY_STATUS_DUMPS disabled
Message-ID: <20031024033226.GA530@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes compilation when FANCY_STATUS_DUMPS is disabled in
include/linux/ide.h

diff -ruNp a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2003-06-13 07:51:33.000000000 -0700
+++ b/drivers/ide/ide-disk.c	2003-10-23 02:05:53.000000000 -0700
@@ -881,8 +881,8 @@ static u8 idedisk_dump_status (ide_drive
 				printk(", sector=%ld",
 					HWGROUP(drive)->rq->sector);
 		}
-	}
 #endif	/* FANCY_STATUS_DUMPS */
+	}
 	printk("\n");
 	local_irq_restore(flags);
 	return err;

-- 
Eric Wong
