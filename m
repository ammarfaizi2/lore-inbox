Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbUKRT2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbUKRT2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbUKRTOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:14:50 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:52232 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262893AbUKRTIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:08:20 -0500
Date: Thu, 18 Nov 2004 14:04:36 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Cc: greearb@candelatech.com, vlan@scry.wanfear.com
Subject: [patch netdev-2.6] vlan_dev: return 0 on vlan_dev_change_mtu success
Message-ID: <20041118140436.A16007@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com, greearb@candelatech.com, vlan@scry.wanfear.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VLAN net driver needs to return 0 from vlan_dev_change_mtu()
on success.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
The proper sucessful return code for the change_mtu() method is zero.
For some reason, vlan_dev_change_mtu() is returning the new mtu value
instead.

 net/8021q/vlan_dev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 1.23/net/8021q/vlan_dev.c	2004-10-28 19:23:09 -04:00
+++ 1.24/net/8021q/vlan_dev.c	2004-11-18 11:12:36 -05:00
@@ -527,7 +527,7 @@
 
 	dev->mtu = new_mtu;
 
-	return new_mtu;
+	return 0;
 }
 
 int vlan_dev_set_ingress_priority(char *dev_name, __u32 skb_prio, short vlan_prio)
