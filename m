Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVBPTmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVBPTmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVBPTmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:42:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261823AbVBPTlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:41:55 -0500
Date: Wed, 16 Feb 2005 19:41:51 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: tag multipath exports GPL
Message-ID: <20050216194151.GF10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tag multipath exports GPL.
--- diff/drivers/md/dm-hw-handler.c	2005-02-16 19:39:25.775992632 +0000
+++ source/drivers/md/dm-hw-handler.c	2005-02-16 19:38:26.223046056 +0000
@@ -211,6 +211,6 @@
 	return MP_FAIL_PATH;
 }
 
-EXPORT_SYMBOL(dm_register_hw_handler);
-EXPORT_SYMBOL(dm_unregister_hw_handler);
-EXPORT_SYMBOL(dm_scsi_err_handler);
+EXPORT_SYMBOL_GPL(dm_register_hw_handler);
+EXPORT_SYMBOL_GPL(dm_unregister_hw_handler);
+EXPORT_SYMBOL_GPL(dm_scsi_err_handler);
--- diff/drivers/md/dm-mpath.c	2005-02-16 19:39:25.778992176 +0000
+++ source/drivers/md/dm-mpath.c	2005-02-16 19:38:38.738143472 +0000
@@ -1292,7 +1292,7 @@
 	kmem_cache_destroy(_mpio_cache);
 }
 
-EXPORT_SYMBOL(dm_pg_init_complete);
+EXPORT_SYMBOL_GPL(dm_pg_init_complete);
 
 module_init(dm_multipath_init);
 module_exit(dm_multipath_exit);
--- diff/drivers/md/dm-path-selector.c	2005-02-16 19:39:25.776992480 +0000
+++ source/drivers/md/dm-path-selector.c	2005-02-16 19:38:11.879226648 +0000
@@ -152,5 +152,5 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(dm_register_path_selector);
-EXPORT_SYMBOL(dm_unregister_path_selector);
+EXPORT_SYMBOL_GPL(dm_register_path_selector);
+EXPORT_SYMBOL_GPL(dm_unregister_path_selector);
