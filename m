Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUJTTpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUJTTpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbUJTTkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:40:06 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:16140 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270476AbUJTThj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:37:39 -0400
Date: Wed, 20 Oct 2004 14:32:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       greearb@candelatech.com
Subject: [patch 2.6.9 11/11] vlan: Add MODULE_VERSION
Message-ID: <20041020143252.N8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, greearb@candelatech.com
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to vlan driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 net/8021q/vlan.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.9/net/8021q/vlan.c.orig
+++ linux-2.6.9/net/8021q/vlan.c
@@ -35,6 +35,8 @@
 #include "vlan.h"
 #include "vlanproc.h"
 
+#define DRV_VERSION "1.8"
+
 /* Global VLAN variables */
 
 /* Our listing of VLAN group(s) */
@@ -42,8 +44,7 @@ struct hlist_head vlan_group_hash[VLAN_G
 #define vlan_grp_hashfn(IDX)	((((IDX) >> VLAN_GRP_HASH_SHIFT) ^ (IDX)) & VLAN_GRP_HASH_MASK)
 
 static char vlan_fullname[] = "802.1Q VLAN Support";
-static unsigned int vlan_version = 1;
-static unsigned int vlan_release = 8;
+static char vlan_version[] = DRV_VERSION;
 static char vlan_copyright[] = "Ben Greear <greearb@candelatech.com>";
 static char vlan_buggyright[] = "David S. Miller <davem@redhat.com>";
 
@@ -84,8 +85,8 @@ static int __init vlan_proto_init(void)
 {
 	int err;
 
-	printk(VLAN_INF "%s v%u.%u %s\n",
-	       vlan_fullname, vlan_version, vlan_release, vlan_copyright);
+	printk(VLAN_INF "%s v%s %s\n",
+	       vlan_fullname, vlan_version, vlan_copyright);
 	printk(VLAN_INF "All bugs added by %s\n",
 	       vlan_buggyright);
 
@@ -735,3 +736,4 @@ static int vlan_ioctl_handler(void __use
 }
 
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
