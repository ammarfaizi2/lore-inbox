Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292328AbSB0K44>; Wed, 27 Feb 2002 05:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292324AbSB0K4q>; Wed, 27 Feb 2002 05:56:46 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:1670 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S289299AbSB0K4e>; Wed, 27 Feb 2002 05:56:34 -0500
Date: Wed, 27 Feb 2002 11:56:30 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: neilb@unsw.edu.au
Subject: [PATCH 2.5.6-bk] Compile fix for nfsd / module.
Message-ID: <20020227105630.GC19173@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new svc_reserve function is not exported from net/sunrpc/sunrpc_syms.c
but is used in fs/nfsd/*, making nfsd incompilable as a module.

The attached trivial patch fix this.

Stelian.

===== net/sunrpc/sunrpc_syms.c 1.5 vs edited =====
--- 1.5/net/sunrpc/sunrpc_syms.c	Tue Feb  5 08:45:39 2002
+++ edited/net/sunrpc/sunrpc_syms.c	Wed Feb 27 11:25:23 2002
@@ -75,6 +75,7 @@
 EXPORT_SYMBOL(svc_drop);
 EXPORT_SYMBOL(svc_process);
 EXPORT_SYMBOL(svc_recv);
+EXPORT_SYMBOL(svc_reserve);
 EXPORT_SYMBOL(svc_wake_up);
 EXPORT_SYMBOL(svc_makesock);
 

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
