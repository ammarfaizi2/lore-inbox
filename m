Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265122AbSJaC7s>; Wed, 30 Oct 2002 21:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSJaC7s>; Wed, 30 Oct 2002 21:59:48 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:45841 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265122AbSJaC7q>; Wed, 30 Oct 2002 21:59:46 -0500
Date: Thu, 31 Oct 2002 03:06:10 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] oprofile: tiny makefile tidy
Message-ID: <20021031030610.GB3642@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


please apply

thanks
john


diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/Makefile linux/arch/i386/oprofile/Makefile
--- linux-linus/arch/i386/oprofile/Makefile	Wed Oct 16 19:08:39 2002
+++ linux/arch/i386/oprofile/Makefile	Thu Oct 31 02:26:34 2002
@@ -1,5 +1,3 @@
-vpath %.c = . $(TOPDIR)/drivers/oprofile
-
 obj-$(CONFIG_OPROFILE) += oprofile.o
  
 DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
@@ -9,8 +7,6 @@
  
 oprofile-objs := $(DRIVER_OBJS) init.o timer_int.o
 
-ifdef CONFIG_X86_LOCAL_APIC
-oprofile-objs += nmi_int.o op_model_athlon.o op_model_ppro.o
-endif
+oprofile-$(CONFIG_X86_LOCAL_APIC) += nmi_int.o op_model_athlon.o op_model_ppro.o
  
 include $(TOPDIR)/Rules.make
