Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUDWWOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUDWWOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUDWWOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:14:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:58522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261528AbUDWWOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:14:30 -0400
Date: Fri, 23 Apr 2004 15:16:37 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: linux-lvm@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-exception-store.c
Message-ID: <20040423221637.GA29746@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's another trivial patch to dm-exception-store.c  It just makes
some function declarations static.


diff -ur rc2-mm1-UDM1-original/drivers/md/dm-exception-store.c rc2-mm1-UDM1-patched/drivers/md/dm-exception-store.c
--- rc2-mm1-UDM1-original/drivers/md/dm-exception-store.c	2004-04-23 15:02:58.000000000 -0700
+++ rc2-mm1-UDM1-patched/drivers/md/dm-exception-store.c	2004-04-23 15:13:34.000000000 -0700
@@ -588,17 +588,17 @@
 	sector_t next_free;
 };
 
-void transient_destroy(struct exception_store *store)
+static void transient_destroy(struct exception_store *store)
 {
 	kfree(store->context);
 }
 
-int transient_read_metadata(struct exception_store *store)
+static int transient_read_metadata(struct exception_store *store)
 {
 	return 0;
 }
 
-int transient_prepare(struct exception_store *store, struct exception *e)
+static int transient_prepare(struct exception_store *store, struct exception *e)
 {
 	struct transient_c *tc = (struct transient_c *) store->context;
 	sector_t size = get_dev_size(store->snap->cow->bdev);
@@ -612,7 +612,7 @@
 	return 0;
 }
 
-void transient_commit(struct exception_store *store,
+static void transient_commit(struct exception_store *store,
 		      struct exception *e,
 		      void (*callback) (void *, int success),
 		      void *callback_context)
