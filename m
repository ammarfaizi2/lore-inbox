Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947552AbWLIACE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947552AbWLIACE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947542AbWLIAA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:00:59 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37578 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761296AbWLIAAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:00:20 -0500
Message-Id: <20061209000152.100650000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Thomas Graf <tgraf@suug.ch>,
       David S Miller <davem@davemloft.net>
Subject: [patch 23/32] NETLINK: Restore API compatibility of address and neighbour bits
Content-Disposition: inline; filename=restore-api-compatibility-of-address-and-neighbour-bits.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Thomas Graf <tgraf@suug.ch>

Restore API compatibility due to bits moved from rtnetlink.h to
separate headers.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/linux/rtnetlink.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.19.orig/include/linux/rtnetlink.h
+++ linux-2.6.19/include/linux/rtnetlink.h
@@ -3,6 +3,8 @@
 
 #include <linux/netlink.h>
 #include <linux/if_link.h>
+#include <linux/if_addr.h>
+#include <linux/neighbour.h>
 
 /****
  *		Routing/neighbour discovery messages.

--
