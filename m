Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312403AbSCURV4>; Thu, 21 Mar 2002 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312412AbSCURVk>; Thu, 21 Mar 2002 12:21:40 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:6787 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312399AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [3/10]
Message-Id: <E16o6CB-0005O4-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one liner.  Should have been caught with a recursive grep when
the members of the struct were renamed in the header.

-Chris


--- linux-2.5.7/arch/alpha/kernel/osf_sys.c~	Mon Mar 18 15:37:01 2002
+++ linux-2.5.7/arch/alpha/kernel/osf_sys.c	Wed Mar 20 09:45:40 2002
@@ -219,7 +219,7 @@
 	 * isn't actually going to matter, as if the parent happens
 	 * to change we can happily return either of the pids.
 	 */
-	(&regs)->r20 = tsk->p_opptr->pid;
+	(&regs)->r20 = tsk->real_parent->pid;
 	return tsk->pid;
 }
 
