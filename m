Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbTIIW3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264847AbTIIW3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:29:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:29583 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264628AbTIIW3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:29:00 -0400
Date: Tue, 9 Sep 2003 15:28:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] gscd - get rid of warning.
Message-Id: <20030909152841.25f7181f.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler warning on 2.6.0-test5 indicates a problem because of missing equal sign.

diff -Nru a/drivers/cdrom/gscd.c b/drivers/cdrom/gscd.c
--- a/drivers/cdrom/gscd.c	Tue Sep  9 15:25:50 2003
+++ b/drivers/cdrom/gscd.c	Tue Sep  9 15:25:50 2003
@@ -965,7 +965,7 @@
 
 	gscd_queue = blk_init_queue(do_gscd_request, &gscd_lock);
 	if (!gscd_queue) {
-		ret -ENOMEM;
+		ret = -ENOMEM;
 		goto err_out3;
 	}
 
