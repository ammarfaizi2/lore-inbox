Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbUAXRcb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 12:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266975AbUAXRcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 12:32:31 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:44512 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265464AbUAXRca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 12:32:30 -0500
Subject: loop device trivial cleanup...
From: "Yury V. Umanets" <umka@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-JQljIw2wsZnUzzFakAnP"
Organization: NAMESYS
Message-Id: <1074965554.9250.6.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 24 Jan 2004 20:32:35 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JQljIw2wsZnUzzFakAnP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hello Andrew,

This is found redundant assignment in loop back device driver. See
attachment.

-- 
umka

--=-JQljIw2wsZnUzzFakAnP
Content-Disposition: attachment; filename=linux-2.6.2-rc1-mm2-loop-redundant.diff
Content-Type: text/x-patch; name=linux-2.6.2-rc1-mm2-loop-redundant.diff; charset=KOI8-R
Content-Transfer-Encoding: 7bit

--- ./linux-2.6.2-rc1-mm2/drivers/block/loop.c.orig	2004-01-24 20:18:48.000000000 +0300
+++ ./linux-2.6.2-rc1-mm2/drivers/block/loop.c	2004-01-24 20:22:19.955190864 +0300
@@ -1014,7 +1014,6 @@ int __init loop_init(void)
 		lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
 		if (!lo->lo_queue)
 			goto out_mem4;
-		disks[i]->queue = lo->lo_queue;
 		init_MUTEX(&lo->lo_ctl_mutex);
 		init_MUTEX_LOCKED(&lo->lo_sem);
 		init_MUTEX_LOCKED(&lo->lo_bh_mutex);

--=-JQljIw2wsZnUzzFakAnP--

