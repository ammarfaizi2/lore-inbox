Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWE2MDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWE2MDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWE2MDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:03:37 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:1517 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750857AbWE2MDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:03:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Mike Shaver <shaver@mozilla.org>,
       linux-kernel@vger.kernel.org
Subject: [patch] eliminte unused /proc/sys/net/ethernet
From: Jes Sorensen <jes@sgi.com>
Date: 29 May 2006 08:03:35 -0400
Message-ID: <yq0r72dt4vc.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Given that /proc/sys/net/ethernet is > 10 years old and empty - maybe
we should just nuke it off the face of the planet?

Cheers,
Jes

The /proc/sys/net/ehternet directory has been sitting empty
for more than 10 years - eliminate it!

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 net/ethernet/sysctl_net_ether.c |   14 --------------
 net/sysctl_net.c                |    8 --------
 2 files changed, 22 deletions(-)

Index: linux-2.6/net/ethernet/sysctl_net_ether.c
===================================================================
--- linux-2.6.orig/net/ethernet/sysctl_net_ether.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/* -*- linux-c -*-
- * sysctl_net_ether.c: sysctl interface to net Ethernet subsystem.
- *
- * Begun April 1, 1996, Mike Shaver.
- * Added /proc/sys/net/ether directory entry (empty =) ). [MS]
- */
-
-#include <linux/mm.h>
-#include <linux/sysctl.h>
-#include <linux/if_ether.h>
-
-ctl_table ether_table[] = {
-	{0}
-};
Index: linux-2.6/net/sysctl_net.c
===================================================================
--- linux-2.6.orig/net/sysctl_net.c
+++ linux-2.6/net/sysctl_net.c
@@ -37,14 +37,6 @@
 		.mode		= 0555,
 		.child		= core_table,
 	},
-#ifdef CONFIG_NET
-	{
-		.ctl_name	= NET_ETHER,
-		.procname	= "ethernet",
-		.mode		= 0555,
-		.child		= ether_table,
-	},
-#endif
 #ifdef CONFIG_INET
 	{
 		.ctl_name	= NET_IPV4,
