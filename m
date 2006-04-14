Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWDNLeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWDNLeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDNLeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:34:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36359 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750781AbWDNLeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:34:10 -0400
Date: Fri, 14 Apr 2006 13:34:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mark.fasheh@oracle.com, kurt.hackel@oracle.com
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/ocfs2/: remove unused exports
Message-ID: <20060414113409.GJ4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following unused EXPORT_SYMBOL_GPL's:
- cluster/heartbeat.c: o2hb_check_node_heartbeating_from_callback
- cluster/heartbeat.c: o2hb_stop_all_regions
- cluster/nodemanager.c: o2nm_get_node_by_num
- cluster/nodemanager.c: o2nm_configured_node_map
- cluster/nodemanager.c: o2nm_get_node_by_ip
- cluster/nodemanager.c: o2nm_node_put
- cluster/nodemanager.c: o2nm_node_get
- dlm/dlmmaster.c: dlm_migrate_lockres

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ocfs2/cluster/heartbeat.c   |    2 --
 fs/ocfs2/cluster/nodemanager.c |    5 -----
 fs/ocfs2/dlm/dlmmaster.c       |    1 -
 3 files changed, 8 deletions(-)

--- linux-2.6.17-rc1-mm2-full/fs/ocfs2/cluster/heartbeat.c.old	2006-04-14 12:42:05.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/fs/ocfs2/cluster/heartbeat.c	2006-04-14 12:42:30.000000000 +0200
@@ -1785,7 +1785,6 @@
 
 	return 1;
 }
-EXPORT_SYMBOL_GPL(o2hb_check_node_heartbeating_from_callback);
 
 /* Makes sure our local node is configured with a node number, and is
  * heartbeating. */
@@ -1821,4 +1820,3 @@
 
 	spin_unlock(&o2hb_live_lock);
 }
-EXPORT_SYMBOL_GPL(o2hb_stop_all_regions);
--- linux-2.6.17-rc1-mm2-full/fs/ocfs2/cluster/nodemanager.c.old	2006-04-14 12:42:49.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/fs/ocfs2/cluster/nodemanager.c	2006-04-14 12:43:40.000000000 +0200
@@ -123,7 +123,6 @@
 out:
 	return node;
 }
-EXPORT_SYMBOL_GPL(o2nm_get_node_by_num);
 
 int o2nm_configured_node_map(unsigned long *map, unsigned bytes)
 {
@@ -140,7 +139,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(o2nm_configured_node_map);
 
 static struct o2nm_node *o2nm_node_ip_tree_lookup(struct o2nm_cluster *cluster,
 						  __be32 ip_needle,
@@ -192,19 +190,16 @@
 out:
 	return node;
 }
-EXPORT_SYMBOL_GPL(o2nm_get_node_by_ip);
 
 void o2nm_node_put(struct o2nm_node *node)
 {
 	config_item_put(&node->nd_item);
 }
-EXPORT_SYMBOL_GPL(o2nm_node_put);
 
 void o2nm_node_get(struct o2nm_node *node)
 {
 	config_item_get(&node->nd_item);
 }
-EXPORT_SYMBOL_GPL(o2nm_node_get);
 
 u8 o2nm_this_node(void)
 {
--- linux-2.6.17-rc1-mm2-full/fs/ocfs2/dlm/dlmmaster.c.old	2006-04-14 12:44:19.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/fs/ocfs2/dlm/dlmmaster.c	2006-04-14 12:44:25.000000000 +0200
@@ -2208,7 +2208,6 @@
 	mlog(0, "returning %d\n", ret);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dlm_migrate_lockres);
 
 int dlm_lock_basts_flushed(struct dlm_ctxt *dlm, struct dlm_lock *lock)
 {

