Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVKGVDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVKGVDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKGVDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:03:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932349AbVKGVCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:02:48 -0500
Date: Mon, 7 Nov 2005 15:02:54 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dlm: include own headers
Message-ID: <20051107210254.GD4287@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for it's
global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: David Teigland <teigland@redhat.com>

----

diff -urN a/drivers/dlm/ast.c b/drivers/dlm/ast.c
--- a/drivers/dlm/ast.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/ast.c	2005-11-07 14:43:59.687919147 -0600
@@ -13,6 +13,7 @@
 
 #include "dlm_internal.h"
 #include "lock.h"
+#include "ast.h"
 
 #define WAKE_ASTS  0
 
diff -urN a/drivers/dlm/dir.c b/drivers/dlm/dir.c
--- a/drivers/dlm/dir.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/dir.c	2005-11-07 14:43:59.688918994 -0600
@@ -21,6 +21,7 @@
 #include "recover.h"
 #include "util.h"
 #include "lock.h"
+#include "dir.h"
 
 
 static void put_free_de(struct dlm_ls *ls, struct dlm_direntry *de)
diff -urN a/drivers/dlm/memory.c b/drivers/dlm/memory.c
--- a/drivers/dlm/memory.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/memory.c	2005-11-07 14:43:59.688918994 -0600
@@ -13,6 +13,7 @@
 
 #include "dlm_internal.h"
 #include "config.h"
+#include "memory.h"
 
 static kmem_cache_t *lkb_cache;
 
diff -urN a/drivers/dlm/midcomms.c b/drivers/dlm/midcomms.c
--- a/drivers/dlm/midcomms.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/midcomms.c	2005-11-07 14:43:59.689918841 -0600
@@ -29,6 +29,7 @@
 #include "config.h"
 #include "rcom.h"
 #include "lock.h"
+#include "midcomms.h"
 
 
 static void copy_from_cb(void *dst, const void *base, unsigned offset,
diff -urN a/drivers/dlm/recover.c b/drivers/dlm/recover.c
--- a/drivers/dlm/recover.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/recover.c	2005-11-07 14:43:59.689918841 -0600
@@ -21,6 +21,7 @@
 #include "lock.h"
 #include "lowcomms.h"
 #include "member.h"
+#include "recover.h"
 
 
 /*
diff -urN a/drivers/dlm/recoverd.c b/drivers/dlm/recoverd.c
--- a/drivers/dlm/recoverd.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/recoverd.c	2005-11-07 14:43:59.690918689 -0600
@@ -20,6 +20,7 @@
 #include "lowcomms.h"
 #include "lock.h"
 #include "requestqueue.h"
+#include "recoverd.h"
 
 
 /* If the start for which we're re-enabling locking (seq) has been superseded
diff -urN a/drivers/dlm/requestqueue.c b/drivers/dlm/requestqueue.c
--- a/drivers/dlm/requestqueue.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/requestqueue.c	2005-11-07 14:43:59.691918536 -0600
@@ -15,6 +15,7 @@
 #include "lock.h"
 #include "dir.h"
 #include "config.h"
+#include "requestqueue.h"
 
 struct rq_entry {
 	struct list_head list;
diff -urN a/drivers/dlm/util.c b/drivers/dlm/util.c
--- a/drivers/dlm/util.c	2005-11-07 14:09:35.000000000 -0600
+++ b/drivers/dlm/util.c	2005-11-07 14:43:59.691918536 -0600
@@ -12,6 +12,7 @@
 
 #include "dlm_internal.h"
 #include "rcom.h"
+#include "util.h"
 
 static void header_out(struct dlm_header *hd)
 {
