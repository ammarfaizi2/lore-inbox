Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWHPWRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWHPWRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWHPWRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:17:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:1719 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932239AbWHPWRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:17:23 -0400
Subject: [PATCH] rcu: Fix incorrect description of default for rcutorture
	nreaders parameter
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Paul McKenney <paulmck@us.ibm.com>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 15:17:04 -0700
Message-Id: <1155766624.9175.34.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for the nreaders parameter of rcutorture gives the default as
4*ncpus, but the value actually defaults to 2*ncpus; fix the comment.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/rcutorture.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 0778a3d..e34d22b 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -48,7 +48,7 @@ #include <linux/srcu.h>
 
 MODULE_LICENSE("GPL");
 
-static int nreaders = -1;	/* # reader threads, defaults to 4*ncpus */
+static int nreaders = -1;	/* # reader threads, defaults to 2*ncpus */
 static int stat_interval;	/* Interval between stats, in seconds. */
 				/*  Defaults to "only at end of test". */
 static int verbose;		/* Print more debug info. */
-- 
1.4.1.1


