Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTHZIYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbTHZIYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:24:41 -0400
Received: from aneto.able.es ([212.97.163.22]:32907 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263268AbTHZIYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:24:39 -0400
Date: Tue, 26 Aug 2003 10:24:37 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4: add check_gcc for P3/P4
Message-ID: <20030826082437.GA2017@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Resending for 2.4.23-pre ;)

--- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18
23:40:25.000000000 +0200
+++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000
+0200
@@ -53,11 +53,11 @@
 endif
 
 ifdef CONFIG_MPENTIUMIII
-CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
 endif
 Marcelo Tosatti <marcelo@conectiva.com.br>
 ifdef CONFIG_MPENTIUM4
-CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
 endif
 
 ifdef CONFIG_MK6


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
