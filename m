Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUD1CWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUD1CWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 22:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264614AbUD1CWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 22:22:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:15844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264610AbUD1CWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 22:22:16 -0400
Date: Tue, 27 Apr 2004 19:24:18 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-flakey.c
Message-ID: <20040428022418.GA22257@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This just adds an __exit to dm_flakey_exit().

diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-flakey.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-flakey.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-flakey.c	2004-04-27 19:22:49.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-flakey.c	2004-04-27 19:22:41.000000000 -0700
@@ -141,7 +141,7 @@
 	return r;
 }
 
-void dm_flakey_exit(void)
+void __exit dm_flakey_exit(void)
 {
 	int r = dm_unregister_target(&flakey_target);
 
diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm.h linux-2.6.6-rc2-udm1-patched/drivers/md/dm.h
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm.h	2004-04-27 19:22:07.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm.h	2004-04-27 19:22:07.000000000 -0700
@@ -31,8 +31,6 @@
 
 #define SECTOR_SHIFT 9
 
-extern struct block_device_operations dm_blk_dops;
-
 /*
  * List of devices that a metadevice uses and should open/close.
  */
