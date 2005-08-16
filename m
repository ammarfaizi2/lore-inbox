Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVHPQgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVHPQgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVHPQgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:36:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49888 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030225AbVHPQgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:36:44 -0400
Date: Tue, 16 Aug 2005 18:37:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt5
Message-ID: <20050816163730.GA7879@elte.hu>
References: <20050816121843.GA24308@elte.hu> <1124206316.5764.14.camel@localhost.localdomain> <1124207046.5764.17.camel@localhost.localdomain> <1124208507.5764.20.camel@localhost.localdomain> <20050816163202.GA5288@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816163202.GA5288@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=AWL,UPPERCASE_50_75 autolearn=disabled SpamAssassin version=3.0.4
	0.9 UPPERCASE_50_75        message body is 50-75% uppercase
	-0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i removed some debug options from your .config, and that booted. 
> Here's the diff between the good and bad .config's. Trying to narrow 
> it down further.

even narrower diff below. My guess would be on 
CONFIG_DEBUG_STACKOVERFLOW.

	Ingo

--- .config.good01	2005-08-16 18:19:05.410509952 +0200
+++ .config.bad00	2005-08-16 18:10:00.242388104 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.13-rc6-rt6
-# Tue Aug 16 18:13:48 2005
+# Tue Aug 16 18:05:14 2005
 #
 CONFIG_X86=y
 CONFIG_MMU=y
@@ -156,7 +156,6 @@
 # CONFIG_MATH_EMULATION is not set
 CONFIG_MTRR=y
 CONFIG_HAVE_DEC_LOCK=y
-# CONFIG_REGPARM is not set
 CONFIG_SECCOMP=y
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_250 is not set
@@ -1242,21 +1241,25 @@
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_PREEMPT=y
 CONFIG_DEBUG_IRQ_FLAGS=y
-# CONFIG_WAKEUP_TIMING is not set
+CONFIG_WAKEUP_TIMING=y
+# CONFIG_WAKEUP_LATENCY_HIST is not set
 CONFIG_PREEMPT_TRACE=y
 # CONFIG_CRITICAL_PREEMPT_TIMING is not set
 # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
+CONFIG_LATENCY_TIMING=y
+CONFIG_LATENCY_TRACE=y
+CONFIG_MCOUNT=y
 CONFIG_RT_DEADLOCK_DETECT=y
 # CONFIG_DEBUG_RT_LOCKING_MODE is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
-# CONFIG_DEBUG_INFO is not set
+CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_FS is not set
-# CONFIG_USE_FRAME_POINTER is not set
+CONFIG_FRAME_POINTER=y
 CONFIG_EARLY_PRINTK=y
-# CONFIG_DEBUG_STACKOVERFLOW is not set
+CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_KPROBES is not set
-# CONFIG_DEBUG_STACK_USAGE is not set
+CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_4KSTACKS is not set
 CONFIG_X86_FIND_SMP_CONFIG=y
