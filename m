Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUIWV2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUIWV2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUIWVZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:25:57 -0400
Received: from baikonur.stro.at ([213.239.196.228]:33675 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267380AbUIWVWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:22:42 -0400
Subject: [patch 2/3]  __FUNCTION__ string concatenation
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, drizzd@aon.at
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:22:43 +0200
Message-ID: <E1CAb35-0005sn-Il@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've replaced the __FUNCTION__ string concatenation with the
%s placeholder and a printf parameter in
drivers/net/wireless/prism65/islpci_mgt.h, as suggested in the TODO
list.

I don't have the hardware to do a run-time check. It should not pose any
problems though.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/04 22:08:37+02:00 drizzd@aon.at 
#   __FUNCTION__ string concatenation is deprecated
# 
# drivers/net/wireless/prism54/islpci_mgt.h
#   2004/07/03 17:18:20+02:00 drizzd@aon.at +1 -1
#   __FUNCTION__ string concatenation is deprecated
# 

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/net/wireless/prism54/islpci_mgt.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/net/wireless/prism54/islpci_mgt.h~printk-net_wireless_prism54_islpci_mgt.h drivers/net/wireless/prism54/islpci_mgt.h
--- linux-2.6.9-rc2-bk7/drivers/net/wireless/prism54/islpci_mgt.h~printk-net_wireless_prism54_islpci_mgt.h	2004-09-21 20:47:57.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/net/wireless/prism54/islpci_mgt.h	2004-09-21 20:47:57.000000000 +0200
@@ -31,7 +31,7 @@
 #define K_DEBUG(f, m, args...) do { if(f & m) printk(KERN_DEBUG args); } while(0)
 #define DEBUG(f, args...) K_DEBUG(f, pc_debug, args)
 
-#define TRACE(devname)   K_DEBUG(SHOW_TRACING, VERBOSE, "%s:  -> " __FUNCTION__ "()\n", devname)
+#define TRACE(devname)   K_DEBUG(SHOW_TRACING, VERBOSE, "%s:  -> %s()\n", devname, __FUNCTION__)
 
 extern int pc_debug;
 #define init_wds 0	/* help compiler optimize away dead code */
_
