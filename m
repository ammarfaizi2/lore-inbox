Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSLPTPz>; Mon, 16 Dec 2002 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSLPTPy>; Mon, 16 Dec 2002 14:15:54 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:57518 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S261338AbSLPTPx>;
	Mon, 16 Dec 2002 14:15:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Remove obsolete SMP declarations
Date: Mon, 16 Dec 2002 12:23:47 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212161223.47839.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolete declarations.  All unused except smp_callin(),
which is always defined before use in architecture-specific code.

Applies to 2.4.20.

diff -Nru a/include/linux/smp.h b/include/linux/smp.h
--- a/include/linux/smp.h	Mon Dec 16 12:13:05 2002
+++ b/include/linux/smp.h	Mon Dec 16 12:13:05 2002
@@ -35,11 +35,6 @@
 extern void smp_boot_cpus(void);
 
 /*
- * Processor call in. Must hold processors until ..
- */
-extern void smp_callin(void);
-
-/*
  * Multiprocessors may now schedule
  */
 extern void smp_commence(void);
@@ -56,10 +51,6 @@
 extern int smp_threads_ready;
 
 extern int smp_num_cpus;
-
-extern volatile unsigned long smp_msg_data;
-extern volatile int smp_src_cpu;
-extern volatile int smp_msg_id;
 
 #define MSG_ALL_BUT_SELF	0x8000	/* Assume <32768 CPU's */
 #define MSG_ALL			0x8001

