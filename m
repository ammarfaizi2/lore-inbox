Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbTH0MU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263377AbTH0MU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:20:58 -0400
Received: from [203.145.184.221] ([203.145.184.221]:26129 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263371AbTH0MU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:20:56 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH-2.6.0-test4-mm2]Removal of warning net/ipv4/route.c
Date: Wed, 27 Aug 2003 17:53:49 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271753.49644.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,

The patch removes the following warning.

net/ipv4/route.c: In function `ip_rt_init':
net/ipv4/route.c:2811: warning: passing arg 2 of `create_proc_read_entry' makes integer from pointer without a cast

The patch is against 2.6.0-test4-mm2.
Applied against the file net/ipv4/route.c

Please apply, if found okay !

Regards
KK

================================================
diffstat output:
route.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)
================================================
The following is the patch:


--- linux-2.6.0-test4-mm2/net/ipv4/route.orig.c	2003-08-27 13:57:14.000000000 +0530
+++ linux-2.6.0-test4-mm2/net/ipv4/route.c	2003-08-27 17:20:13.000000000 +0530
@@ -2808,7 +2808,7 @@
 		goto out_enomem;
 
 #ifdef CONFIG_NET_CLS_ROUTE
-	create_proc_read_entry("rt_acct", proc_net, 0, ip_rt_acct_read, NULL);
+	create_proc_read_entry("rt_acct", 0, proc_net, ip_rt_acct_read, NULL);
 #endif
 #endif
 #ifdef CONFIG_XFRM


