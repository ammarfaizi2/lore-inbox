Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268248AbTBNJYq>; Fri, 14 Feb 2003 04:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268326AbTBNJYp>; Fri, 14 Feb 2003 04:24:45 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:29011
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268248AbTBNJYo>; Fri, 14 Feb 2003 04:24:44 -0500
Date: Fri, 14 Feb 2003 04:33:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5][1/14] smp_call_function_on_cpu - generic definitions
Message-ID: <Pine.LNX.4.50.0302140410060.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.60/include/linux/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/include/linux/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.60/include/linux/smp.h	10 Feb 2003 22:17:13 -0000	1.1.1.1
+++ linux-2.5.60/include/linux/smp.h	14 Feb 2003 05:34:46 -0000
@@ -54,6 +54,12 @@
 			      int retry, int wait);
 
 /*
+ * Call a function on arbitrary processors encapsulated in a bitmask
+ */
+extern int smp_call_function_on_cpu (void (*func) (void *info), void *info,
+				int wait, unsigned long mask);
+
+/*
  * True once the per process idle is forked
  */
 extern int smp_threads_ready;
@@ -96,6 +102,7 @@
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
+#define smp_call_function_on_cpu(func,info,wait,mask) ({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
