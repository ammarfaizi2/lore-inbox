Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVLFAmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVLFAmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVLFAmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:42:10 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27086
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751532AbVLFAee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:34 -0500
Message-Id: <20051206000153.545039000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:32 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 06/21] Remove unused clock constants
Content-Disposition: inline;
	filename=time-h-remove-unused-clock-constants.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- remove unused CLOCK_ constants from time.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/time.h |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -103,12 +103,10 @@ struct	itimerval {
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers).
  */
-#define CLOCK_REALTIME		  0
-#define CLOCK_MONOTONIC	  1
+#define CLOCK_REALTIME		 0
+#define CLOCK_MONOTONIC	  	 1
 #define CLOCK_PROCESS_CPUTIME_ID 2
 #define CLOCK_THREAD_CPUTIME_ID	 3
-#define CLOCK_REALTIME_HR	 4
-#define CLOCK_MONOTONIC_HR	  5
 
 /*
  * The IDs of various hardware clocks
@@ -117,9 +115,8 @@ struct	itimerval {
 
 #define CLOCK_SGI_CYCLE 10
 #define MAX_CLOCKS 16
-#define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC | \
-                     CLOCK_REALTIME_HR | CLOCK_MONOTONIC_HR)
-#define CLOCKS_MONO (CLOCK_MONOTONIC & CLOCK_MONOTONIC_HR)
+#define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC)
+#define CLOCKS_MONO (CLOCK_MONOTONIC)
 
 /*
  * The various flags for setting POSIX.1b interval timers.

--

