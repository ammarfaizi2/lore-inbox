Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314131AbSDFKX6>; Sat, 6 Apr 2002 05:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314133AbSDFKX6>; Sat, 6 Apr 2002 05:23:58 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14344 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314131AbSDFKX5>;
	Sat, 6 Apr 2002 05:23:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.19-pre6 standardize aacraid/Makefile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 20:23:47 +1000
Message-ID: <17525.1018088627@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the makefile for aacraid to use common kbuild 2.4 rules.

Index: 19-pre6.1/drivers/scsi/aacraid/Makefile
--- 19-pre6.1/drivers/scsi/aacraid/Makefile Mon, 10 Dec 2001 10:51:02 +1100 kaos (linux-2.4/O/f/4_Makefile 1.1 644)
+++ 19-pre6.1(w)/drivers/scsi/aacraid/Makefile Sat, 06 Apr 2002 18:24:46 +1000 kaos (linux-2.4/O/f/4_Makefile 1.1 644)
@@ -1,16 +1,10 @@
 
 EXTRA_CFLAGS	+= -I$(TOPDIR)/drivers/scsi
 
+O_TARGET	:= aacraid.o
+obj-m		:= $(O_TARGET)
 
-O_TARGET	:= dummy.o
-
-list-multi	:= aacraid.o
-aacraid-objs	:= linit.o aachba.o commctrl.o comminit.o commsup.o \
+obj-y		:= linit.o aachba.o commctrl.o comminit.o commsup.o \
 		   dpcsup.o rx.o sap1sup.o
 
-obj-$(CONFIG_SCSI_AACRAID) += aacraid.o
-
 include $(TOPDIR)/Rules.make
-
-aacraid.o: $(aacraid-objs)
-	$(LD) -r -o $@ $(aacraid-objs)

