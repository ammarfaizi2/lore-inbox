Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbWCTWCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbWCTWCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbWCTWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:02:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:51129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030507AbWCTWBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:07 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/23] add EXPORT_SYMBOL_GPL_FUTURE() to RCU subsystem
In-Reply-To: <11428920383496-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920381545-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the RCU symbols are going to be changed to GPL in the near future,
lets warn users that this is going to happen.

Cc: Paul McKenney <paulmck@us.ibm.com>
Acked-by: Dipankar Sarma <dipankar@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 kernel/rcupdate.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

01ca70dca5c64cb774a8ac2f50bddff21d60169f
diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
index 8cf15a5..fedf5e3 100644
--- a/kernel/rcupdate.c
+++ b/kernel/rcupdate.c
@@ -609,7 +609,7 @@ module_param(qlowmark, int, 0);
 module_param(rsinterval, int, 0);
 #endif
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
-EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL_FUTURE(call_rcu);	/* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL_FUTURE(call_rcu_bh);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL_FUTURE(synchronize_kernel); /* WARNING: GPL-only in April 2006. */
-- 
1.2.4


