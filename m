Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTHZW21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbTHZW21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:28:27 -0400
Received: from aneto.able.es ([212.97.163.22]:29342 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263016AbTHZW2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:28:15 -0400
Date: Wed, 27 Aug 2003 00:28:12 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: insecure@mail.od.ua
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4: add check_gcc for P3/P4
Message-ID: <20030826222812.GA6566@werewolf.able.es>
References: <20030826082437.GA2017@werewolf.able.es> <200308262056.39595.insecure@mail.od.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200308262056.39595.insecure@mail.od.ua>; from insecure@mail.od.ua on Tue, Aug 26, 2003 at 19:56:39 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.26, insecure wrote:
> On Tuesday 26 August 2003 11:24, J.A. Magallon wrote:
> > Hi.
> >
> > Resending for 2.4.23-pre ;)
> >
> > --- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18
> > 23:40:25.000000000 +0200
> > +++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18
23:59:25.000000000
> > +0200
> > @@ -53,11 +53,11 @@
> >  endif
> >
> >  ifdef CONFIG_MPENTIUMIII
> > -CFLAGS += -march=i686
> > +CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
> >  endif
> >  Marcelo Tosatti <marcelo@conectiva.com.br>
> 
> This is a rather strange make statement
> 

Oops, silly cut'n'paste in balsa...
Here is the good one:

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
