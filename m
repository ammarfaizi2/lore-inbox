Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVG0VW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVG0VW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVG0Uon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:44:43 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:52177 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S262447AbVG0UoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:44:21 -0400
Message-ID: <42E7F1F4.4070208@temple.edu>
Date: Wed, 27 Jul 2005 16:43:32 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Netfilter Core Team <coreteam@netfilter.org>
Subject: net/ipv4/netfilter/ip_conntrack_core.c fix -Wundef error
Content-Type: multipart/mixed;
 boundary="------------030000090600090803080302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030000090600090803080302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes a single -Wundef error in the file 
net/ipv4/netfilter/ip_conntrack_core.c ,

Please Apply

Nick Sillik
n.sillik@temple.edu

--------------030000090600090803080302
Content-Type: text/plain;
 name="ipconntrack_wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipconntrack_wundef.patch"

diff -urN a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c	2005-07-27 16:40:16.000000000 -0400
+++ b/net/ipv4/netfilter/ip_conntrack_core.c	2005-07-27 16:41:00.000000000 -0400
@@ -723,7 +723,7 @@
 		/* Welcome, Mr. Bond.  We've been expecting you... */
 		__set_bit(IPS_EXPECTED_BIT, &conntrack->status);
 		conntrack->master = exp->master;
-#if CONFIG_IP_NF_CONNTRACK_MARK
+#ifdef CONFIG_IP_NF_CONNTRACK_MARK
 		conntrack->mark = exp->master->mark;
 #endif
 		nf_conntrack_get(&conntrack->master->ct_general);

--------------030000090600090803080302--
