Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbTIVVir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTIVVir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:38:47 -0400
Received: from waste.org ([209.173.204.2]:7130 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262402AbTIVVip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:38:45 -0400
Date: Mon, 22 Sep 2003 16:38:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>,
       wangdi <wangdi@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/3] compile fix: export netpoll api for modules
Message-ID: <20030922213835.GA32488@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export netpoll api for use by modules

 l-mpm/net/core/netpoll.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN net/core/netpoll.c~export-netpoll net/core/netpoll.c
--- l/net/core/netpoll.c~export-netpoll	2003-09-22 16:25:27.000000000 -0500
+++ l-mpm/net/core/netpoll.c	2003-09-22 16:33:32.000000000 -0500
@@ -630,3 +630,12 @@ void netpoll_set_trap(int trap)
 {
 	trapped = trap;
 }
+
+EXPORT_SYMBOL(netpoll_set_trap);
+EXPORT_SYMBOL(netpoll_trap);
+EXPORT_SYMBOL(netpoll_parse_options);
+EXPORT_SYMBOL(netpoll_setup);
+EXPORT_SYMBOL(netpoll_cleanup);
+EXPORT_SYMBOL(netpoll_send_skb);
+EXPORT_SYMBOL(netpoll_send_udp);
+EXPORT_SYMBOL(netpoll_poll);

_


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
