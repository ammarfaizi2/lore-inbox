Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313465AbSC2PzZ>; Fri, 29 Mar 2002 10:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313467AbSC2PzP>; Fri, 29 Mar 2002 10:55:15 -0500
Received: from air-2.osdl.org ([65.201.151.6]:26120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313465AbSC2PzD>;
	Fri, 29 Mar 2002 10:55:03 -0500
Date: Fri, 29 Mar 2002 07:55:02 -0800
From: Bob Miller <rem@osdl.org>
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Compile problems with 2.5.7
Message-ID: <20020329075502.A6029@build.pdx.osdl.net>
In-Reply-To: <006201c1d729$a7fa1520$41448fd5@telemach.net> <20020329155438.3fcdc054.Gregor.Fajdiga@telemach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grega,

The easiest thing to do to fix your problem is to edit kernel/Makefile
and remove acct.o.  The patch below (suppied by Andrey Klochko)
will work.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


--- linux-2.5/kernel/Makefile.orig	Thu Mar 28 13:50:52 2002
+++ linux-2.5/kernel/Makefile	Thu Mar 28 13:24:12 2002
@@ -14,13 +14,13 @@
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
-	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
+	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o kthread.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
-obj-$(CONFIG_CONFIG_BSD_PROCESS_ACCT) += acct.o
+obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 
 ifneq ($(CONFIG_IA64),y)

