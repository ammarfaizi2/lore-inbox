Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262105AbSI3OLE>; Mon, 30 Sep 2002 10:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbSI3OJh>; Mon, 30 Sep 2002 10:09:37 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:64974 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262089AbSI3NoG> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:44:06 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (25/26): init call.
Date: Mon, 30 Sep 2002 15:06:07 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301506.07647.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove call to s390_init_machine_check in init/main.c, the new boot code
on s390 calls it via arch_initcall.

diff -urN linux-2.5.39/init/main.c linux-2.5.39-s390/init/main.c
--- linux-2.5.39/init/main.c	Fri Sep 27 23:49:12 2002
+++ linux-2.5.39-s390/init/main.c	Mon Sep 30 13:33:57 2002
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
 

