Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVDLStG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVDLStG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVDLSre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:47:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:10698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262235AbVDLKcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:55 -0400
Message-Id: <200504121032.j3CAWnux005689@shell0.pdx.osdl.net>
Subject: [patch 137/198] Fix comment in list.h that refers to nonexistent API
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulmck@us.ibm.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Paul E. McKenney" <paulmck@us.ibm.com>

The hlist_for_each_entry_rcu() comment block refers to a nonexistent
hlist_add_rcu() API, needs to change to hlist_add_head_rcu().

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/list.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/list.h~fix-comment-in-listh-that-refers-to-nonexistent-api include/linux/list.h
--- 25/include/linux/list.h~fix-comment-in-listh-that-refers-to-nonexistent-api	2005-04-12 03:21:36.498588272 -0700
+++ 25-akpm/include/linux/list.h	2005-04-12 03:21:36.501587816 -0700
@@ -692,7 +692,7 @@ static inline void hlist_add_after(struc
  * @member:	the name of the hlist_node within the struct.
  *
  * This list-traversal primitive may safely run concurrently with
- * the _rcu list-mutation primitives such as hlist_add_rcu()
+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define hlist_for_each_entry_rcu(tpos, pos, head, member)		 \
_
