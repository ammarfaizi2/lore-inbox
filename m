Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVDARxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVDARxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVDARxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:53:55 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35199 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262831AbVDARxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:53:53 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com, davem@davemloft.net
Subject: [PATCH][4/3] IPoIB: document conversion to debugfs
X-Message-Flag: Warning: May contain useful information
References: <20053311936.XaQmN4N9new7dTCP@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 01 Apr 2005 09:45:33 -0800
In-Reply-To: <20053311936.XaQmN4N9new7dTCP@topspin.com> (Roland Dreier's
 message of "Thu, 31 Mar 2005 19:36:12 -0800")
Message-ID: <52r7hujsqq.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Apr 2005 17:45:33.0676 (UTC) FILETIME=[9AC0C2C0:01C536E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update IPoIB documentation now that multicast debugging files have
moved from ipoibdebugfs to debugfs.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/Documentation/infiniband/ipoib.txt	2005-03-31 19:07:01.000000000 -0800
+++ linux-export/Documentation/infiniband/ipoib.txt	2005-04-01 09:43:27.122520190 -0800
@@ -32,14 +32,13 @@
   mcast_debug_level to 1.  These parameters can be controlled at
   runtime through files in /sys/module/ib_ipoib/.
 
-  CONFIG_INFINIBAND_IPOIB_DEBUG also enables the "ipoib_debugfs"
+  CONFIG_INFINIBAND_IPOIB_DEBUG also enables files in the debugfs
   virtual filesystem.  By mounting this filesystem, for example with
 
-    mkdir -p /ipoib_debugfs
-    mount -t ipoib_debugfs none /ipoib_debufs
+    mount -t debugfs none /sys/kernel/debug
 
-  it is possible to get statistics about multicast groups from the
-  files /ipoib_debugfs/ib0_mcg and so on.
+  it is possible to get statistics about munlticast groups from the
+  files /sys/kernel/debug/ipoib/ib0_mcg and so on.
 
   The performance impact of this option is negligible, so it
   is safe to enable this option with debug_level set to 0 for normal
