Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293091AbSCJQpO>; Sun, 10 Mar 2002 11:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293094AbSCJQpI>; Sun, 10 Mar 2002 11:45:08 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:55498 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S293091AbSCJQos>;
	Sun, 10 Mar 2002 11:44:48 -0500
Date: Sun, 10 Mar 2002 17:44:46 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203101644.RAA02312@harpo.it.uu.se>
To: neilb@cse.unsw.edu.au
Subject: [PATCH] 2.5.6 missing EXPORT_SYMBOL for NFSD module
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFSD doesn't work as a module in recent 2.5 kernels since
svc_reserve() isn't exported. The trivial patch below fixes this.

/Mikael

--- linux-2.5.6/net/sunrpc/sunrpc_syms.c.~1~	Wed Feb 20 03:11:04 2002
+++ linux-2.5.6/net/sunrpc/sunrpc_syms.c	Sun Mar 10 14:32:04 2002
@@ -77,6 +77,7 @@
 EXPORT_SYMBOL(svc_recv);
 EXPORT_SYMBOL(svc_wake_up);
 EXPORT_SYMBOL(svc_makesock);
+EXPORT_SYMBOL(svc_reserve);
 
 /* RPC statistics */
 #ifdef CONFIG_PROC_FS
