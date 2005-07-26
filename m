Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVGZPAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVGZPAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGZO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:59:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16389 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261850AbVGZO5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:57:10 -0400
Date: Tue, 26 Jul 2005 16:56:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netfilter-devel@lists.netfilter.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix ip_conntrack_put prototype
Message-ID: <20050726145659.GR3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function is not inline.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/include/linux/netfilter_ipv4/ip_conntrack.h.old	2005-07-26 13:44:20.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/linux/netfilter_ipv4/ip_conntrack.h	2005-07-26 13:45:41.000000000 +0200
@@ -236,7 +236,7 @@
 }
 
 /* decrement reference count on a conntrack */
-extern inline void ip_conntrack_put(struct ip_conntrack *ct);
+extern void ip_conntrack_put(struct ip_conntrack *ct);
 
 /* call to create an explicit dependency on ip_conntrack. */
 extern void need_ip_conntrack(void);

