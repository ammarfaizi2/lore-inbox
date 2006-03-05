Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWCEAI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWCEAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWCEAI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:08:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20486 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932285AbWCEAIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:08:25 -0500
Date: Sun, 5 Mar 2006 01:08:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Moore <Eric.Moore@lsil.com>, linux-kernel@vger.kernel.org,
       mpt_linux_developer@lsil.com, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: [2.6 patch] drivers/message/fusion/mptctl.c: make struct async_queue static
Message-ID: <20060305000822.GN9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason for struct async_queue being global.

Additional, this patch adds some missing whitespace.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 14 Feb 2006
- 10 Feb 2006

--- linux-2.6.16-rc2-mm1-full/drivers/message/fusion/mptctl.c.old	2006-02-10 00:43:43.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/message/fusion/mptctl.c	2006-02-10 00:43:59.000000000 +0100
@@ -140,7 +140,7 @@
  * Event Handler function
  */
 static int mptctl_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *pEvReply);
-struct fasync_struct *async_queue=NULL;
+static struct fasync_struct *async_queue = NULL;
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
