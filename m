Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVAOAv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVAOAv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVAOAvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:51:10 -0500
Received: from waste.org ([216.27.176.166]:10977 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262075AbVAOAtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:16 -0500
Date: Fri, 14 Jan 2005 18:49:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8.563253706@selenic.com>
Message-Id: <9.563253706@selenic.com>
Subject: [PATCH 8/10] random pt2: kill 2.2 compat waitqueue defs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Linux 2.2 compatibility cruft.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:05.741783928 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:06.993624332 -0800
@@ -380,16 +380,6 @@
  */
 
 /*
- * Linux 2.2 compatibility
- */
-#ifndef DECLARE_WAITQUEUE
-#define DECLARE_WAITQUEUE(WAIT, PTR) struct wait_queue WAIT = { PTR, NULL }
-#endif
-#ifndef DECLARE_WAIT_QUEUE_HEAD
-#define DECLARE_WAIT_QUEUE_HEAD(WAIT) struct wait_queue *WAIT
-#endif
-
-/*
  * Static global variables
  */
 static struct entropy_store *random_state; /* The default global store */
