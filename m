Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130536AbQKIMj1>; Thu, 9 Nov 2000 07:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQKIMjR>; Thu, 9 Nov 2000 07:39:17 -0500
Received: from mars.foursticks.com.au ([150.101.72.105]:16273 "EHLO
	mars.foursticks.com.au") by vger.kernel.org with ESMTP
	id <S130509AbQKIMjB>; Thu, 9 Nov 2000 07:39:01 -0500
From: Paul Schulz <paul@mars.foursticks.com.au>
To: linux-kernel@vger.kernel.org
Subject: [Patch] QoS as modules in 2.4.0-test10 not compiling.
Reply-To: pschulz@foursticks.com
Message-Id: <E13tqyk-0002gK-00@mars.foursticks.com.au>
Date: Thu, 09 Nov 2000 23:08:54 +1030
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've been trying to compile the kernel with the QoS code as modules.

The net/Makefile didn't have 'sched' listed as a module subdirectory,
so it wasntt getting walked in a make_modules... any way, the
following patch fixes the problem.

Paul Schulz (pschulz@foursticks.com.au)
Foursticks Systems

--- net/Makefile.old	Thu Nov  9 23:06:00 2000
+++ net/Makefile	Thu Nov  9 22:18:40 2000
@@ -7,7 +7,7 @@
 
 O_TARGET :=	network.o
 
-mod-subdirs :=	ipv4/netfilter ipv6/netfilter ipx irda atm netlink
+mod-subdirs :=	ipv4/netfilter ipv6/netfilter ipx irda atm netlink sched
 export-objs :=	netsyms.o
 
 subdir-y :=	core ethernet

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
