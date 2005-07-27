Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVG0Ux5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVG0Ux5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVG0Uvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:51:46 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:57335 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S262500AbVG0Uuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:50:39 -0400
Message-ID: <42E7F377.9040107@temple.edu>
Date: Wed, 27 Jul 2005 16:49:59 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Netfilter Core Team <coreteam@netfilter.org>
Subject: [PATCH 2.6.13-rc3-mm2]net/ipv4/netfilter/ip_conntrack_core.c fix
 -Wundef error
Content-Type: multipart/mixed;
 boundary="------------010303020103050107040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303020103050107040007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the resend and previously bad subject line.

This fixes a single -Wundef error in the file
net/ipv4/netfilter/ip_conntrack_core.c ,

Please Apply

Nick Sillik
n.sillik@temple.edu


--------------010303020103050107040007
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


--------------010303020103050107040007--
