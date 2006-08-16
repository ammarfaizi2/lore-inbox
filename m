Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWHPWVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWHPWVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWHPWVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:21:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:64237 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932285AbWHPWU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:20:59 -0400
Subject: [PATCH] rcu: Mention rcu_bh in description of rcutorture's
	torture_type parameter
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Paul McKenney <paulmck@us.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 15:20:59 -0700
Message-Id: <1155766859.9175.37.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for rcutorture's torture_type parameter only lists the RCU
variants rcu and srcu, but not rcu_bh; add rcu_bh to the list.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/rcutorture.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index e34d22b..aff0064 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -54,7 +54,7 @@ static int stat_interval;	/* Interval be
 static int verbose;		/* Print more debug info. */
 static int test_no_idle_hz;	/* Test RCU's support for tickless idle CPUs. */
 static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
-static char *torture_type = "rcu"; /* What to torture: rcu, srcu. */
+static char *torture_type = "rcu"; /* What to torture: rcu, rcu_bh, srcu. */
 
 module_param(nreaders, int, 0);
 MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
-- 
1.4.1.1


