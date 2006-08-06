Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWHGNOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWHGNOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWHGNOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:14:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28585 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932071AbWHGNOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:14:24 -0400
Date: Sat, 5 Aug 2006 20:05:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dipankar@in.ibm.com, stern@rowland.harvard.edu
Subject: [PATCH] Remove redundant cleanup_srcu_struct() declaration
Message-ID: <20060806030542.GA2352@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, if one cleanup_srcu_struct() is good, two must be twice as good,
right?  This patch removes the spare, which was in my original.  :-/

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 srcu.h |    1 -
 1 files changed, 1 deletion(-)

diff -urpNa -X dontdiff linux-2.6.18-rc2-mm1/include/linux/srcu.h linux-2.6.18-rc2-mm1-rrcss/include/linux/srcu.h
--- linux-2.6.18-rc2-mm1/include/linux/srcu.h	2006-08-05 16:30:44.000000000 -0700
+++ linux-2.6.18-rc2-mm1-rrcss/include/linux/srcu.h	2006-08-05 20:00:46.000000000 -0700
@@ -49,6 +49,5 @@ int srcu_read_lock(struct srcu_struct *s
 void srcu_read_unlock(struct srcu_struct *sp, int idx);
 void synchronize_srcu(struct srcu_struct *sp);
 long srcu_batches_completed(struct srcu_struct *sp);
-void cleanup_srcu_struct(struct srcu_struct *sp);
 
 #endif
