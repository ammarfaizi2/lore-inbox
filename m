Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUHJQgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUHJQgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUHJQgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:36:10 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:17682 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267511AbUHJQOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:14:12 -0400
Date: Tue, 10 Aug 2004 11:13:30 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [7/8] bump read ahead to 1024
Message-ID: <20040810161330.GG19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 7 of 8
This patch changes our read_ahead to 1024. This has been shown to increase
performance. Please consider this for inclusion. Patch applies to 2.6.8-rc4.
Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p006/drivers/block/cciss.c lx268-rc3/drivers/block/cciss.c
--- lx268-rc3-p006/drivers/block/cciss.c	2004-08-05 14:16:11.567565000 -0500
+++ lx268-rc3/drivers/block/cciss.c	2004-08-06 10:15:31.934926352 -0500
@@ -115,7 +115,7 @@ static struct board_type products[] = {
 /*define how many times we will try a command because of bus resets */
 #define MAX_CMD_RETRIES 3
 
-#define READ_AHEAD 	 256
+#define READ_AHEAD 	 1024
 #define NR_CMDS		 384 /* #commands that can be outstanding */
 #define MAX_CTLR 8
 
