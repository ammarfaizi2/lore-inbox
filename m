Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTFZWzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTFZWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:54:49 -0400
Received: from aneto.able.es ([212.97.163.22]:18837 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263375AbTFZWv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:51:57 -0400
Date: Fri, 27 Jun 2003 01:06:09 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] gcc_check for x86
Message-ID: <20030626230609.GK3827@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jun 27, 2003 at 00:03:02 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.27, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> 
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.
> 

I think this is useful and safe. Plz, can you apply for next pre ?

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
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
