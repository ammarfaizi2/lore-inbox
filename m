Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbTFRVyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265556AbTFRVyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:54:21 -0400
Received: from aneto.able.es ([212.97.163.22]:55792 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265555AbTFRVyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:54:19 -0400
Date: Thu, 19 Jun 2003 00:08:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [RFC][PATCH] missing gcc_check's for i386/2.4.21
Message-ID: <20030618220813.GA3768@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This adds the missing gcc_check's to use optimized flags for kernel build
in i386 arch. Picked from 2.5.72.

Is it suitable for apply ?

TIA

--- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18 23:40:25.000000000 +0200
+++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000 +0200
@@ -45,7 +45,7 @@
 endif
 
 ifdef CONFIG_M586MMX
-CFLAGS += -march=i586
+CFLAGS += $(call check_gcc,-march=pentium-mmx,-march=i586)
 endif
 
 ifdef CONFIG_M686
@@ -53,11 +53,11 @@
 endif
 
 ifdef CONFIG_MPENTIUMIII
-CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
 endif
 
 ifdef CONFIG_MPENTIUM4
-CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
 endif
 
 ifdef CONFIG_MK6
@@ -74,11 +74,11 @@
 endif
 
 ifdef CONFIG_MWINCHIPC6
-CFLAGS += -march=i586
+CFLAGS += $(call check_gcc,-march=winchip-c6,-march=i586)
 endif
 
 ifdef CONFIG_MWINCHIP2
-CFLAGS += -march=i586
+CFLAGS += $(call check_gcc,-march=winchip2,-march=i586)
 endif
 
 ifdef CONFIG_MWINCHIP3D


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
