Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSL3StD>; Mon, 30 Dec 2002 13:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSL3StD>; Mon, 30 Dec 2002 13:49:03 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:5627 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S267049AbSL3StC> convert rfc822-to-8bit; Mon, 30 Dec 2002 13:49:02 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
To: Margit Schubert-While <margitsw@t-online.de>
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Date: Mon, 30 Dec 2002 19:56:00 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212301955.29912.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>drivers/char/char.o: In function `sysrq_handle_preempt_log': 
>drivers/char/char.o(.text+0x1c79e): undefined reference to `show_preempt_log' 

Please apply

http://infolinux.de/jp15/076_sysrq-preempt-log-fix

Patchset .bz2 archive will be updated.

Jörg

--- linux-jp15/drivers/char/sysrq.c.orig	2002-12-30 19:48:15.000000000 +0100
+++ linux-jp15/drivers/char/sysrq.c	2002-12-30 19:48:35.000000000 +0100
@@ -27,7 +27,7 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
-
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 
 #include <asm/ptrace.h>

