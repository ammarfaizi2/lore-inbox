Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263655AbRFASBf>; Fri, 1 Jun 2001 14:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263668AbRFASBZ>; Fri, 1 Jun 2001 14:01:25 -0400
Received: from [209.10.41.242] ([209.10.41.242]:60122 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263657AbRFASBT>;
	Fri, 1 Jun 2001 14:01:19 -0400
Date: Fri, 1 Jun 2001 17:08:52 +0200
From: David Jez <dave.jez@seznam.cz>
To: Dag Brattli <dagb@cs.uit.no>
Cc: linux-kernel@vger.kernel.org
Subject: unresolved symbol irda_cleanup
Message-ID: <20010601170851.A25312@stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  I solved this problem. IrDA hasn't worked since 2.4.2 kernel with this
error message. Problem was static definition of irda_clenup() in irsyms.c
  My patch is from kernel 2.4.4, but can be aplied to 2.4.5 too.

  Dave.
PS: I'm not in mailing list.


diff -urN linux-2.4.4.orig/net/irda/irsyms.c linux-2.4.4/net/irda/irsyms.c
--- linux-2.4.4.orig/net/irda/irsyms.c	Thu May 31 16:02:07 2001
+++ linux-2.4.4/net/irda/irsyms.c	Thu May 31 16:02:00 2001
@@ -218,7 +218,7 @@
 	return 0;
 }
 
-static void __exit irda_cleanup(void)
+void __exit irda_cleanup(void)
 {
 #ifdef CONFIG_SYSCTL
 	irda_sysctl_unregister();
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@fest.stud.fee.vutbr.cz
---------=[ ~EOF ]=------------------------------------
