Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUHFRVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUHFRVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUHFRUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:20:05 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:55304 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268182AbUHFRK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:10:57 -0400
Date: Fri, 6 Aug 2004 11:34:37 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update 7 read_ahead bumped to 1024
Message-ID: <20040806163437.GA19967@beardog.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 7
This patch changes our read_ahead to 1024. This has been shown to increase
performance. Please consider this for inclusion. It should be applied 
after the 6 I sent in Aug 5.

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
 
