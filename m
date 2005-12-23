Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbVLWWtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbVLWWtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbVLWWts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:18128 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161112AbVLWWtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:39 -0500
Date: Fri, 23 Dec 2005 14:48:15 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, kaber@trash.net
Subject: [patch 10/19] [NETFILTER]: Fix incorrect dependency for IP6_NF_TARGET_NFQUEUE
Message-ID: <20051223224815.GJ19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-incorrect-dependency-for-IP6_NF_TARGET_NFQUEUE.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Patrick McHardy <kaber@trash.net>

IP6_NF_TARGET_NFQUEUE depends on IP6_NF_IPTABLES, not IP_NF_IPTABLES.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv6/netfilter/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.4.orig/net/ipv6/netfilter/Kconfig
+++ linux-2.6.14.4/net/ipv6/netfilter/Kconfig
@@ -211,7 +211,7 @@ config IP6_NF_TARGET_REJECT
 
 config IP6_NF_TARGET_NFQUEUE
 	tristate "NFQUEUE Target Support"
-	depends on IP_NF_IPTABLES
+	depends on IP6_NF_IPTABLES
 	help
 	  This Target replaced the old obsolete QUEUE target.
 

--
