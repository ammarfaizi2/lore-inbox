Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUAOWy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUAOWy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:54:56 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:50712 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263762AbUAOWyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:54:53 -0500
Date: Thu, 15 Jan 2004 17:54:50 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: dhowells@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][AFS] remove spurious strdup
Message-ID: <Xine.LNX.4.44.0401151753480.17795-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is against 2.6.1-mm3.


diff -urN linux.orig/fs/afs/super.c linux.w/fs/afs/super.c
--- linux.orig/fs/afs/super.c	2003-09-27 20:50:17.000000000 -0400
+++ linux.w/fs/afs/super.c	2004-01-15 17:51:45.989733464 -0500
@@ -35,14 +35,6 @@
 	struct afs_volume	*volume;
 };
 
-static inline char *strdup(const char *s)
-{
-	char *ns = kmalloc(strlen(s) + 1, GFP_KERNEL);
-	if (ns)
-		strcpy(ns, s);
-	return ns;
-}
-
 static void afs_i_init_once(void *foo, kmem_cache_t *cachep,
 			    unsigned long flags);
 

