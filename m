Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272743AbTG1JDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 05:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272746AbTG1JDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 05:03:32 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:56238 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S272743AbTG1JDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 05:03:31 -0400
Date: Mon, 28 Jul 2003 11:18:18 +0200
From: Jasper Spaans <jasper@vs19.net>
To: pekkas@netcore.fi, yoshfuji@linux-ipv6.org, davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: mode of /proc/sys/net/ipv6/icmp
Message-ID: <20030728091818.GA8475@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can anybody tell me why /proc/sys/net/ipv6/icmp is mode 0500 instead of the
more logical 0555 ? Is there something to hide from normal users in there?

Diff below fixes this, but I'd like to know the rationale behind this..

Index: net/ipv6/sysctl_net_ipv6.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/sysctl_net_ipv6.c,v
retrieving revision 1.7
diff -u -r1.7 sysctl_net_ipv6.c
--- linux-2.5/net/ipv6/sysctl_net_ipv6.c	27 Jun 2003 16:44:43 -0000	1.7
+++ CVS/net/ipv6/sysctl_net_ipv6.c	28 Jul 2003 07:46:51 -0000
@@ -31,7 +31,7 @@
 		.ctl_name	= NET_IPV6_ICMP,
 		.procname	= "icmp",
 		.maxlen		= 0,
-		.mode		= 0500,
+		.mode		= 0555,
 		.child		= ipv6_icmp_table
 	},
 	{


VrGr,
-- 
Jasper Spaans                 http://jsp.vs19.net/contact/
