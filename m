Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVCOOrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVCOOrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVCOOrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:47:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44815 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261297AbVCOOrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:47:17 -0500
Date: Tue, 15 Mar 2005 15:47:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv6/ndisc.c: make a function static
Message-ID: <20050315144712.GM3189@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/net/ipv6/ndisc.c.old	2005-03-15 13:33:29.000000000 +0100
+++ linux-2.6.11-mm3-full/net/ipv6/ndisc.c	2005-03-15 13:34:03.000000000 +0100
@@ -1594,10 +1594,11 @@
 	return ret;
 }
 
-int ndisc_ifinfo_sysctl_strategy(ctl_table *ctl, int __user *name, int nlen,
-				 void __user *oldval, size_t __user *oldlenp,
-				 void __user *newval, size_t newlen,
-				 void **context)
+static int ndisc_ifinfo_sysctl_strategy(ctl_table *ctl, int __user *name,
+					int nlen, void __user *oldval,
+					size_t __user *oldlenp,
+					void __user *newval, size_t newlen,
+					void **context)
 {
 	struct net_device *dev = ctl->extra1;
 	struct inet6_dev *idev;

