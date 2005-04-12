Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVDLLFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVDLLFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVDLLFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:05:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:29642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262257AbVDLKdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:15 -0400
Message-Id: <200504121033.j3CAX7fF005781@shell0.pdx.osdl.net>
Subject: [patch 156/198] IPoIB: document conversion to debugfs
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Update IPoIB documentation now that multicast debugging files have moved from
ipoibdebugfs to debugfs.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Documentation/infiniband/ipoib.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN Documentation/infiniband/ipoib.txt~ipoib-document-conversion-to Documentation/infiniband/ipoib.txt
--- 25/Documentation/infiniband/ipoib.txt~ipoib-document-conversion-to	2005-04-12 03:21:40.895919776 -0700
+++ 25-akpm/Documentation/infiniband/ipoib.txt	2005-04-12 03:21:40.898919320 -0700
@@ -32,14 +32,13 @@ Debugging Information
   mcast_debug_level to 1.  These parameters can be controlled at
   runtime through files in /sys/module/ib_ipoib/.
 
-  CONFIG_INFINIBAND_IPOIB_DEBUG also enables the "ipoib_debugfs"
+  CONFIG_INFINIBAND_IPOIB_DEBUG also enables files in the debugfs
   virtual filesystem.  By mounting this filesystem, for example with
 
-    mkdir -p /ipoib_debugfs
-    mount -t ipoib_debugfs none /ipoib_debufs
+    mount -t debugfs none /sys/kernel/debug
 
   it is possible to get statistics about multicast groups from the
-  files /ipoib_debugfs/ib0_mcg and so on.
+  files /sys/kernel/debug/ipoib/ib0_mcg and so on.
 
   The performance impact of this option is negligible, so it
   is safe to enable this option with debug_level set to 0 for normal
_
