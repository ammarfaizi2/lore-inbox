Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSIXRa6>; Tue, 24 Sep 2002 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbSIXRaO>; Tue, 24 Sep 2002 13:30:14 -0400
Received: from d12lmsgate-4.de.ibm.com ([195.212.91.196]:19085 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261734AbSIXRWq> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 23_boot_common.
Date: Tue, 24 Sep 2002 19:24:17 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241924.17881.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove call to s390_init_machine_check in init/main.c, the new boot code
on s390 calls it via arch_initcall.

diff -urN linux-2.5.38/init/main.c linux-2.5.38-s390/init/main.c
--- linux-2.5.38/init/main.c	Sun Sep 22 06:25:02 2002
+++ linux-2.5.38-s390/init/main.c	Tue Sep 24 17:53:26 2002
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
 

