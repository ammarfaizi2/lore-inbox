Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271926AbTGRW5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271927AbTGRW5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:57:12 -0400
Received: from aneto.able.es ([212.97.163.22]:42176 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271926AbTGRW5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:57:05 -0400
Date: Sat, 19 Jul 2003 01:12:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre7
Message-ID: <20030718231200.GE6166@werewolf.able.es>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jul 18, 2003 at 21:53:25 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.18, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre7.
> 
> This is a feature freeze, only bugfixes will be accepted from now on.
> 

Could you include at least this, for completeness ?

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

And how about the 'inline -> always_inline' patch ? It can be considered
as a bug that breaks the build with gcc3. If you consider it appropiate,
I will resend.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre6-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.3mdk))
