Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbSJDOhb>; Fri, 4 Oct 2002 10:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbSJDOhb>; Fri, 4 Oct 2002 10:37:31 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:21938 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261844AbSJDOhW> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (25/27): init call.
Date: Fri, 4 Oct 2002 16:35:51 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041635.51886.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove call to s390_init_machine_check in init/main.c, the new boot code
on s390 calls it via arch_initcall.

diff -urN linux-2.5.40/init/main.c linux-2.5.40-s390/init/main.c
--- linux-2.5.40/init/main.c	Tue Oct  1 09:06:20 2002
+++ linux-2.5.40-s390/init/main.c	Fri Oct  4 16:16:50 2002
@@ -493,13 +493,6 @@
 	sysctl_init();
 #endif
 
-	/*
-	 * Ok, at this point all CPU's should be initialized, so
-	 * we can start looking into devices..
-	 */
-#if defined(CONFIG_ARCH_S390)
-	s390_init_machine_check();
-#endif
 	/* Networking initialization needs a process context */ 
 	sock_init();
 

