Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbUCZAEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUCZAD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:03:29 -0500
Received: from waste.org ([209.173.204.2]:52377 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263825AbUCYX6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16.524465763@selenic.com>
Message-Id: <17.524465763@selenic.com>
Subject: [PATCH 16/22] /dev/random: kill 2.2 cruft
Date: Thu, 25 Mar 2004 17:57:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  kill 2.2 cruft

Remove Linux 2.2 compatibility cruft.


 tiny-mpm/drivers/char/random.c |   10 ----------
 1 files changed, 10 deletions(-)

diff -puN drivers/char/random.c~random-waitqueue drivers/char/random.c
--- tiny/drivers/char/random.c~random-waitqueue	2004-03-20 13:38:35.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:35.000000000 -0600
@@ -382,16 +382,6 @@ static struct poolinfo {
  */
 
 /*
- * Linux 2.2 compatibility
- */
-#ifndef DECLARE_WAITQUEUE
-#define DECLARE_WAITQUEUE(WAIT, PTR)	struct wait_queue WAIT = { PTR, NULL }
-#endif
-#ifndef DECLARE_WAIT_QUEUE_HEAD
-#define DECLARE_WAIT_QUEUE_HEAD(WAIT) struct wait_queue *WAIT
-#endif
-
-/*
  * Static global variables
  */
 static struct entropy_store *input_pool, *blocking_pool, *nonblocking_pool;

_
