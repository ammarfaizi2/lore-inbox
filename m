Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWACXmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWACXmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWACXmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:42:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57819 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965049AbWACX1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:16 -0500
To: torvalds@osdl.org
Subject: [PATCH 10/41] m68k: static vs. extern in scc.h
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvYh-0003M0-H9@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133436672 -0500

extern declaration before the static one

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/scc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d8a479c8fb10ec19aa8bfe5600652533a3ef2ffd
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

