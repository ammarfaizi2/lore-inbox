Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269653AbUJVGb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269653AbUJVGb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269841AbUJSQyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:54:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:51396 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269779AbUJSQio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:44 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037582673@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:01 -0700
Message-Id: <1098203761440@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.55.6, 2004/09/04 18:56:35+02:00, greg@kroah.com

ksysfs: don't build ksysfs if CONFIG_SYSFS is not enabled.

Thanks to Kay Sievers for pointing this out.
  
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 kernel/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-10-19 09:23:25 -07:00
+++ b/kernel/Makefile	2004-10-19 09:23:25 -07:00
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o ksysfs.o
+	    kthread.o 
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
@@ -24,6 +24,7 @@
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_SYSFS) += ksysfs.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is

