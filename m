Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932727AbWJJLTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWJJLTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 07:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932870AbWJJLTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 07:19:08 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:29149 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S932727AbWJJLTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 07:19:05 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 07:17:43 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] ixgb.h: Redefine IXGB_DBG() macro to use pr_debug().
Message-ID: <Pine.LNX.4.64.0610100713350.7179@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the definition of IXGB_DBG() to be based on pr_debug().

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---
diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
index 50ffe90..16e6c3d 100644
--- a/drivers/net/ixgb/ixgb.h
+++ b/drivers/net/ixgb/ixgb.h
@@ -77,11 +77,7 @@ #include "ixgb_hw.h"
 #include "ixgb_ee.h"
 #include "ixgb_ids.h"

-#ifdef _DEBUG_DRIVER_
-#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
-#else
-#define IXGB_DBG(args...)
-#endif
+#define IXGB_DBG(args...) pr_debug("ixgb: ", args)

 #define PFX "ixgb: "
 #define DPRINTK(nlevel, klevel, fmt, args...) \
