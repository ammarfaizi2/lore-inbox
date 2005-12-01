Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVLAAEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVLAAEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVLAAEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:04:00 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2979
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751313AbVK3X6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:23 -0500
Subject: [patch 26/43] Rename struct timer_list to struct ktimeout
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:51 +0100
Message-Id: <1133395431.32542.469.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-struct-base.patch)
- change the main timeout data structure from 'struct timer_list'
  to 'struct ktimeout'
- introduce compatibility define for timer_list

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    2 +-
 include/linux/timer.h    |    7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -8,7 +8,7 @@
 
 struct timer_base_s;
 
-struct timer_list {
+struct ktimeout {
 	struct list_head entry;
 	unsigned long expires;
 
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -1,9 +1,14 @@
+/*
+ * This file is a compatibility placeholder - it will go away.
+ */
 #ifndef _LINUX_TIMER_H
 #define _LINUX_TIMER_H
 
 /*
- * This file is a compatibility placeholder - it will go away.
+ * Compatibility define to turn 'struct timer_list' into 'struct ktimeout':
  */
+#define timer_list ktimeout
+
 #include <linux/ktimeout.h>
 
 extern int it_real_fn(void *);

--

