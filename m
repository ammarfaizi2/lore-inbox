Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVLVEuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVLVEuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVLVEuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:50:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23504 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965060AbVLVEuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:00 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 11/36] m68k: static vs. extern in scc.h
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOt-0004qp-Hs@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133436672 -0500

extern declaration before the static one

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/scc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3880e2fd7d5f16219743f962a2b12033985dfed4
diff --git a/drivers/char/scc.h b/drivers/char/scc.h
index 51810f7..93998f5 100644
--- a/drivers/char/scc.h
+++ b/drivers/char/scc.h
@@ -399,7 +399,7 @@ struct scc_port {
 		__asm__ __volatile__ ( "tstb %0" : : "g" (*_scc_del) : "cc" );\
     } while (0)
 
-extern unsigned char scc_shadow[2][16];
+static unsigned char scc_shadow[2][16];
 
 /* The following functions should relax the somehow complicated
  * register access of the SCC. _SCCwrite() stores all written values
-- 
0.99.9.GIT

