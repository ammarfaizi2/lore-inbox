Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318739AbSHLQhf>; Mon, 12 Aug 2002 12:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSHLQhf>; Mon, 12 Aug 2002 12:37:35 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:42935 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S318739AbSHLQhe>; Mon, 12 Aug 2002 12:37:34 -0400
Subject: [PATCH] 2.5.31 add three help texts to arch/alpha/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Richard Henderson <rth@twiddle.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Aug 2002 10:38:21 -0600
Message-Id: <1029170301.2045.23.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds help texts to arch/alpha/Config.help for
CONFIG_ALPHA_EV67, CONFIG_DEBUG_RWLOCK and CONFIG_DEBUG_SEMAPHORE.

This has been in the -dj tree since about 2.5.7.
The texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.31/arch/alpha/Config.help.orig	Sat Aug 10 19:41:20 2002
+++ linux-2.5.31/arch/alpha/Config.help	Mon Aug 12 09:52:42 2002
@@ -251,6 +251,10 @@
 CONFIG_ALPHA_GAMMA
   Say Y if you have an AS 2000 5/xxx or an AS 2100 5/xxx.
 
+CONFIG_ALPHA_EV67
+  Is this a machine based on the EV67 core?  If in doubt, select N here
+  and the machine will be treated as an EV6.
+
 CONFIG_ALPHA_SRM
   There are two different types of booting firmware on Alphas: SRM,
   which is command line driven, and ARC, which uses menus and arrow
@@ -598,4 +602,15 @@
   and certain other kinds of spinlock errors commonly made.  This is
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
+
+CONFIG_DEBUG_RWLOCK
+  If you say Y here then read-write lock processing will count how many
+  times it has tried to get the lock and issue an error message after
+  too many attempts.  If you suspect a rwlock problem or a kernel
+  hacker asks for this option then say Y.  Otherwise say N.
+
+CONFIG_DEBUG_SEMAPHORE
+  If you say Y here then semaphore processing will issue lots of
+  verbose debugging messages.  If you suspect a semaphore problem or a
+  kernel hacker asks for this option then say Y.  Otherwise say N.
 




