Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVDCGlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVDCGlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDCGlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:41:39 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45534 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261564AbVDCGlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:41:25 -0500
Date: Sat, 2 Apr 2005 22:41:41 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix comment in list.h that refers to nonexistent API
Message-ID: <20050403064141.GA1751@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hlist_for_each_entry_rcu() comment block refers to a nonexistent
hlist_add_rcu() API, needs to change to hlist_add_head_rcu().

Signed-off-by: <paulmck@us.ibm.com>
---

diff -urpN -X dontdiff linux-2.6.12-rc1/include/linux/list.h linux-2.6.12-rc1-bettersk/include/linux/list.h
--- linux-2.6.12-rc1/include/linux/list.h	Tue Mar  1 23:38:10 2005
+++ linux-2.6.12-rc1-bettersk/include/linux/list.h	Sat Apr  2 12:19:50 2005
@@ -692,7 +692,7 @@ static inline void hlist_add_after(struc
  * @member:	the name of the hlist_node within the struct.
  *
  * This list-traversal primitive may safely run concurrently with
- * the _rcu list-mutation primitives such as hlist_add_rcu()
+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define hlist_for_each_entry_rcu(tpos, pos, head, member)		 \
