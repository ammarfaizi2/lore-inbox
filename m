Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTIXPLy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 11:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbTIXPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 11:11:54 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:9479 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S261399AbTIXPLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 11:11:53 -0400
Subject: [PATCH] 2.6.0-bk6 net/core/dev.c
From: Joe Perches <joe@perches.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1064416289.1804.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Sep 2003 08:11:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Symmetric to dev_add_pack.

diff -urN linux-2.6.0-test5/net/core/dev.c shared_skb/net/core/dev.c
--- linux-2.6.0-test5/net/core/dev.c	2003-09-22 08:04:06.000000000 -0700
+++ shared_skb/net/core/dev.c	2003-09-22 14:02:08.000000000 -0700
@@ -281,7 +281,7 @@
 	list_for_each_entry(pt1, head, list) {
 		if (pt == pt1) {
 #ifdef CONFIG_NET_FASTROUTE
-			if (pt->data)
+			if (pt->data && (long)pt->data != 1)
 				netdev_fastroute_obstacles--;
 #endif
 			list_del_rcu(&pt->list);


