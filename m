Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbVLWWv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbVLWWv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVLWWtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:25296 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161111AbVLWWtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:42 -0500
Date: Fri, 23 Dec 2005 14:48:19 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, kristian.slavov@nomadiclab.com, hadi@cyberus.ca,
       kaber@trash.net
Subject: [patch 11/19] [RTNETLINK]: Fix RTNLGRP definitions in rtnetlink.h
Message-ID: <20051223224819.GK19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="rtnetlink-fix-RTNLGRP-definitions-in-rtnetlink.h.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Kristian Slavov <kristian.slavov@nomadiclab.com>

I reported a problem and gave hints to the solution, but nobody seemed
to react. So I prepared a patch against 2.6.14.4.

Tested on 2.6.14.4 with "ip monitor addr" and with the program
attached, while adding and removing IPv6 address. Both programs didn't
receive any messages.  Tested 2.6.14.4 + this patch, and both programs
received add and remove messages.

Signed-off-by: Kristian Slavov <kristian.slavov@nomadiclab.com>
Acked-by: Jamal Hadi salim <hadi@cyberus.ca>
ACKed-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/rtnetlink.h |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.14.4.orig/include/linux/rtnetlink.h
+++ linux-2.6.14.4/include/linux/rtnetlink.h
@@ -866,6 +866,7 @@ enum rtnetlink_groups {
 #define	RTNLGRP_IPV4_MROUTE	RTNLGRP_IPV4_MROUTE
 	RTNLGRP_IPV4_ROUTE,
 #define RTNLGRP_IPV4_ROUTE	RTNLGRP_IPV4_ROUTE
+	RTNLGRP_NOP1,
 	RTNLGRP_IPV6_IFADDR,
 #define RTNLGRP_IPV6_IFADDR	RTNLGRP_IPV6_IFADDR
 	RTNLGRP_IPV6_MROUTE,
@@ -876,8 +877,11 @@ enum rtnetlink_groups {
 #define RTNLGRP_IPV6_IFINFO	RTNLGRP_IPV6_IFINFO
 	RTNLGRP_DECnet_IFADDR,
 #define RTNLGRP_DECnet_IFADDR	RTNLGRP_DECnet_IFADDR
+	RTNLGRP_NOP2,
 	RTNLGRP_DECnet_ROUTE,
 #define RTNLGRP_DECnet_ROUTE	RTNLGRP_DECnet_ROUTE
+	RTNLGRP_NOP3,
+	RTNLGRP_NOP4,
 	RTNLGRP_IPV6_PREFIX,
 #define RTNLGRP_IPV6_PREFIX	RTNLGRP_IPV6_PREFIX
 	__RTNLGRP_MAX

--
