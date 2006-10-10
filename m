Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030612AbWJJWjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030612AbWJJWjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbWJJWjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:39:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63106 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030612AbWJJWi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:38:56 -0400
To: torvalds@osdl.org
Subject: [PATCH 13/16] Finish annotations of struct vlan_ethhdr
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQFT-00005R-VE@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:38:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Wed, 28 Dec 2005 22:27:10 +0300

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/if_vlan.h |    2 +-
 net/8021q/vlan_dev.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index ab27408..35cb385 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -44,7 +44,7 @@ struct vlan_ethhdr {
    unsigned char	h_source[ETH_ALEN];	   /* source ether addr	*/
    __be16               h_vlan_proto;              /* Should always be 0x8100 */
    __be16               h_vlan_TCI;                /* Encapsulates priority and VLAN ID */
-   unsigned short	h_vlan_encapsulated_proto; /* packet type ID field (or len) */
+   __be16		h_vlan_encapsulated_proto; /* packet type ID field (or len) */
 };
 
 #include <linux/skbuff.h>
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index da9cfe9..60a508e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -62,7 +62,7 @@ #endif	
 	default:
 		printk(VLAN_DBG
 		       "%s: unable to resolve type %X addresses.\n", 
-		       dev->name, (int)veth->h_vlan_encapsulated_proto);
+		       dev->name, ntohs(veth->h_vlan_encapsulated_proto));
 	 
 		memcpy(veth->h_source, dev->dev_addr, ETH_ALEN);
 		break;
-- 
1.4.2.GIT


