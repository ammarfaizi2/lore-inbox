Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVHYFZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVHYFZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVHYFVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63691 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751536AbVHYFVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:25 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (10/22) static vs. extern in scc
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AE3-0005cN-Bi@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

extern declaration before the static one

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-82596-apricot/drivers/char/scc.h RC13-rc7-scc/drivers/char/scc.h
--- RC13-rc7-82596-apricot/drivers/char/scc.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-scc/drivers/char/scc.h	2005-08-25 00:54:11.000000000 -0400
@@ -399,7 +399,7 @@
 		__asm__ __volatile__ ( "tstb %0" : : "g" (*_scc_del) : "cc" );\
     } while (0)
 
-extern unsigned char scc_shadow[2][16];
+static unsigned char scc_shadow[2][16];
 
 /* The following functions should relax the somehow complicated
  * register access of the SCC. _SCCwrite() stores all written values
