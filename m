Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbTH3WFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 18:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTH3WFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 18:05:35 -0400
Received: from [212.97.163.22] ([212.97.163.22]:46465 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262180AbTH3WFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 18:05:33 -0400
Date: Sun, 31 Aug 2003 00:05:17 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] check_gcc for i386
Message-ID: <20030830220517.GA20429@werewolf.able.es>
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Aug 30, 2003 at 17:48:22 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.30, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE
> changes from Alan, network drivers update from Jeff, amongst other fixes
> and updates.
> 

New try...
Plz, could you include this on your queue ?

--- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18 23:40:25.000000000 +0200
+++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000 +0200
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

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
