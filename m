Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUBGUjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUBGUjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:39:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26838 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266053AbUBGUiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:38:55 -0500
Date: Sat, 7 Feb 2004 21:38:48 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove kernel 2.2 #ifdef's from {i,}stallion.h
Message-ID: <20040207203847.GC7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removeskernel 2.2 #ifdef's from {i,}stallion.h .

Please apply
Adrian

--- linux-2.6.2-mm1/include/linux/istallion.h.old	2004-02-07 21:35:58.000000000 +0100
+++ linux-2.6.2-mm1/include/linux/istallion.h	2004-02-07 21:36:12.000000000 +0100
@@ -70,15 +70,9 @@
 	void			*argp;
 	unsigned int		rxmarkmsk;
 	struct tty_struct	*tty;
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
-	struct wait_queue	*open_wait;
-	struct wait_queue	*close_wait;
-	struct wait_queue	*raw_wait;
-#else
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
 	wait_queue_head_t	raw_wait;
-#endif
 	struct work_struct	tqhangup;
 	asysigs_t		asig;
 	unsigned long		addr;
--- linux-2.6.2-mm1/include/linux/stallion.h.old	2004-02-07 21:36:33.000000000 +0100
+++ linux-2.6.2-mm1/include/linux/stallion.h	2004-02-07 21:36:46.000000000 +0100
@@ -95,13 +95,8 @@
 	unsigned long		hwid;
 	void			*uartp;
 	struct tty_struct	*tty;
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
-	struct wait_queue	*open_wait;
-	struct wait_queue	*close_wait;
-#else
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
-#endif
 	struct work_struct	tqueue;
 	comstats_t		stats;
 	stlrq_t			tx;
