Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSG3JbB>; Tue, 30 Jul 2002 05:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSG3JbB>; Tue, 30 Jul 2002 05:31:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:39561 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315413AbSG3JbB>;
	Tue, 30 Jul 2002 05:31:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UP compilation fix for bk tree
Date: Tue, 30 Jul 2002 16:29:31 +1000
Message-Id: <20020730093546.0C42244A5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple, and when we resolve this initcall depends stuff, it will be
going away anyway.

Rusty.

--- working-2.5.29-upfix/init/main.c.~1~	Tue Jul 30 16:27:55 2002
+++ working-2.5.29-upfix/init/main.c	Tue Jul 30 16:28:29 2002
@@ -529,7 +529,9 @@
 	extern int migration_init(void);
 	extern int spawn_ksoftirqd(void);
 
+#ifdef CONFIG_SMP
 	migration_init();
+#endif
 	spawn_ksoftirqd();
 }
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
