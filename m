Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275289AbRIZQQ2>; Wed, 26 Sep 2001 12:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275291AbRIZQQS>; Wed, 26 Sep 2001 12:16:18 -0400
Received: from bgm-24-95-140-16.stny.rr.com ([24.95.140.16]:32753 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S275289AbRIZQQI>; Wed, 26 Sep 2001 12:16:08 -0400
Date: Wed, 26 Sep 2001 12:19:44 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: <rostedt@localhost.localdomain>
Reply-To: Steven Rostedt <srostedt@stny.rr.com>
To: <duwe@informatik.uni-erlangen.de>
cc: <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mc146818rtc.h for user land programs (2.4.10)
Message-ID: <Pine.LNX.4.33.0109261152100.5923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is for linux-2.4.10
This is needed for user land programs to use the
mc146818rtc.h header.



--- include/linux/mc146818rtc.h.orig    Wed Sep 26 23:43:00 2001
+++ include/linux/mc146818rtc.h Wed Sep 26 23:43:25 2001
@@ -16,7 +16,9 @@
 #include <linux/spinlock.h>            /* spinlock_t */
 #include <asm/mc146818rtc.h>           /* register access macros */

+#ifdef __KERNEL__
 extern spinlock_t rtc_lock;            /* serialize CMOS RAM access */
+#endif

 /**********************************************************************
  * register summary



