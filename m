Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132699AbRDORIp>; Sun, 15 Apr 2001 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132728AbRDORIe>; Sun, 15 Apr 2001 13:08:34 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.121.49]:61422 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S132699AbRDORI2>; Sun, 15 Apr 2001 13:08:28 -0400
Date: Sun, 15 Apr 2001 10:08:35 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: <vivid_liou@dlink.com.tw>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: can't use printk in linux 2.4.2 module
Message-ID: <Pine.LNX.4.31.0104151007150.984-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try the following patch to linux/kernel/Makefile. If it works fine let me
know and we can get it into the standard tree.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

--- Makefile.orig	Sun Apr 15 10:06:40 2001
+++ Makefile	Sun Apr 15 10:06:51 2001
@@ -9,7 +9,7 @@

 O_TARGET := kernel.o

-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o printk.o

 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \

