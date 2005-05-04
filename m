Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVEDRVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVEDRVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEDRR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:17:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261873AbVEDRQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:16:54 -0400
Date: Wed, 4 May 2005 18:15:38 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] device-mapper: Some missing statics
Message-ID: <20050504171538.GU10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- diff/drivers/md/dm-hw-handler.c	2005-04-21 18:38:05.000000000 +0100
+++ source/drivers/md/dm-hw-handler.c	2005-04-21 19:03:59.000000000 +0100
@@ -23,7 +23,7 @@
 static LIST_HEAD(_hw_handlers);
 static DECLARE_RWSEM(_hwh_lock);
 
-struct hwh_internal *__find_hw_handler_type(const char *name)
+static struct hwh_internal *__find_hw_handler_type(const char *name)
 {
 	struct hwh_internal *hwhi;
 
--- diff/drivers/md/dm-path-selector.c	2005-04-04 17:38:05.000000000 +0100
+++ source/drivers/md/dm-path-selector.c	2005-04-21 19:03:59.000000000 +0100
@@ -26,7 +26,7 @@
 static LIST_HEAD(_path_selectors);
 static DECLARE_RWSEM(_ps_lock);
 
-struct ps_internal *__find_path_selector_type(const char *name)
+static struct ps_internal *__find_path_selector_type(const char *name)
 {
 	struct ps_internal *psi;
 
--- diff/drivers/md/dm-table.c	2005-04-04 17:39:42.000000000 +0100
+++ source/drivers/md/dm-table.c	2005-04-21 19:03:59.000000000 +0100
@@ -242,7 +242,7 @@
 	}
 }
 
-void table_destroy(struct dm_table *t)
+static void table_destroy(struct dm_table *t)
 {
 	unsigned int i;
 
--- diff/drivers/md/dm-zero.c	2005-04-04 17:38:23.000000000 +0100
+++ source/drivers/md/dm-zero.c	2005-04-21 19:03:59.000000000 +0100
@@ -55,7 +55,7 @@
 	.map    = zero_map,
 };
 
-int __init dm_zero_init(void)
+static int __init dm_zero_init(void)
 {
 	int r = dm_register_target(&zero_target);
 
@@ -65,7 +65,7 @@
 	return r;
 }
 
-void __exit dm_zero_exit(void)
+static void __exit dm_zero_exit(void)
 {
 	int r = dm_unregister_target(&zero_target);
 
