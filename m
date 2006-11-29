Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967683AbWK2Xii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967683AbWK2Xii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967677AbWK2Xi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:38:29 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:13328 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967679AbWK2XiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:38:12 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: netfilter-devel@lists.netfilter.org
Subject: [PATCH] netfilter: remove broken macro
Date: Thu, 30 Nov 2006 00:37:41 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300037.41404.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes broken and unused macro.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 net/ipv4/netfilter/ip_nat_standalone.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.6.19-rc6-mm2-a/net/ipv4/netfilter/ip_nat_standalone.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/net/ipv4/netfilter/ip_nat_standalone.c	2006-11-29 15:31:37.000000000 +0100
@@ -44,12 +44,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-#define HOOKNAME(hooknum) ((hooknum) == NF_IP_POST_ROUTING ? "POST_ROUTING"  \
-			   : ((hooknum) == NF_IP_PRE_ROUTING ? "PRE_ROUTING" \
-			      : ((hooknum) == NF_IP_LOCAL_OUT ? "LOCAL_OUT"  \
-			         : ((hooknum) == NF_IP_LOCAL_IN ? "LOCAL_IN"  \
-				    : "*ERROR*")))
-
 #ifdef CONFIG_XFRM
 static void nat_decode_session(struct sk_buff *skb, struct flowi *fl)
 {


-- 
Regards,

	Mariusz Kozlowski
