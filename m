Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbVBDUEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbVBDUEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbVBDUCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:02:46 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:16900 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S265543AbVBDUAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:34 -0500
Subject: [patch 5/8] uml: fix jiffies initialization [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:50 +0100
Message-Id: <20050204183551.1AFB0310BF@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Initialize jiffies_64 to INITIAL_JIFFIES.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/time_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/time_kern.c~uml-jiffies arch/um/kernel/time_kern.c
--- linux-2.6.11/arch/um/kernel/time_kern.c~uml-jiffies	2005-02-04 06:20:13.592089248 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/time_kern.c	2005-02-04 06:20:13.595088792 +0100
@@ -22,7 +22,7 @@
 #include "mode.h"
 #include "os.h"
 
-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
 
_
