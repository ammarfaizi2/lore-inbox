Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbTH3Wzh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 18:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbTH3Wzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 18:55:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64158 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262216AbTH3Wzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 18:55:35 -0400
Date: Sat, 30 Aug 2003 19:58:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check_gcc for i386
In-Reply-To: <20030830220517.GA20429@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Aug 2003, J.A. Magallon wrote:

> 
> On 08.30, Marcelo Tosatti wrote:
> > 
> > Hello,
> > 
> > Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE
> > changes from Alan, network drivers update from Jeff, amongst other fixes
> > and updates.
> > 
> 
> New try...
> Plz, could you include this on your queue ?
> 
> --- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18 23:40:25.000000000 +0200
> +++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000 +0200
> @@ -53,11 +53,11 @@
>  endif
>  
>  ifdef CONFIG_MPENTIUMIII
> -CFLAGS += -march=i686
> +CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
>  endif
>  
>  ifdef CONFIG_MPENTIUM4
> -CFLAGS += -march=i686
> +CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
>  endif
>  
>  ifdef CONFIG_MK6

OK, I forgot what that does. Can you please explain in detail what 
check_gcc does. 

