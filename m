Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030896AbWLAPqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030896AbWLAPqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967499AbWLAPqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:46:01 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:9482 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967496AbWLAPqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:46:00 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] netfilter broken and unused macro removal
Date: Fri, 1 Dec 2006 16:45:31 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011645.33743.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes broken and unused macro from netfilter code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 net/ipv4/netfilter/ip_nat_standalone.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.4.34-pre6-a/net/ipv4/netfilter/ip_nat_standalone.c	2005-11-16 20:12:54.000000000 +0100
+++ linux-2.4.34-pre6-b/net/ipv4/netfilter/ip_nat_standalone.c	2006-12-01 12:10:42.000000000 +0100
@@ -43,12 +43,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-#define HOOKNAME(hooknum) ((hooknum) == NF_IP_POST_ROUTING ? "POST_ROUTING"  \
-			   : ((hooknum) == NF_IP_PRE_ROUTING ? "PRE_ROUTING" \
-			      : ((hooknum) == NF_IP_LOCAL_OUT ? "LOCAL_OUT"  \
-			         : ((hooknum) == NF_IP_LOCAL_IN ? "LOCAL_IN"  \
-				    : "*ERROR*")))
-
 static inline int call_expect(struct ip_conntrack *master,
 			      struct sk_buff **pskb,
 			      unsigned int hooknum,


-- 
Regards,

	Mariusz Kozlowski
