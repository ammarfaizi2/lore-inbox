Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312397AbSCURV4>; Thu, 21 Mar 2002 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312413AbSCURVl>; Thu, 21 Mar 2002 12:21:41 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:7555 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312402AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [5/10]
Message-Id: <E16o6CB-0005OA-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one liners that should have been caught with a grep.

-Chris


--- linux-2.5.7/arch/alpha/kernel/ptrace.c~	Mon Mar 18 15:37:18 2002
+++ linux-2.5.7/arch/alpha/kernel/ptrace.c	Wed Mar 20 09:29:27 2002
@@ -292,7 +292,7 @@
 		if (request != PTRACE_KILL)
 			goto out;
 	}
-	if (child->p_pptr != current) {
+	if (child->parent != current) {
 		DBG(DBG_MEM, ("child not parent of this process\n"));
 		goto out;
 	}
