Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbTGIWxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbTGIWxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:53:23 -0400
Received: from aneto.able.es ([212.97.163.22]:37804 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S268722AbTGIWxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:53:19 -0400
Date: Thu, 10 Jul 2003 01:07:54 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.22-pre3: P3 and P4 for chekc_gcc
Message-ID: <20030709230754.GA18564@werewolf.able.es>
References: <20030709223355.GA2604@werewolf.able.es> <3F0C9EE8.2050005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3F0C9EE8.2050005@pobox.com>; from jgarzik@pobox.com on Thu, Jul 10, 2003 at 01:02:00 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.10, Jeff Garzik wrote:
> J.A. Magallon wrote:
> > --- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18 23:40:25.000000000 +0200
> > +++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000 +0200
> > @@ -53,11 +53,11 @@
> >  endif
> >  
> >  ifdef CONFIG_MPENTIUMIII
> > -CFLAGS += -march=i686
> > +CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
> >  endif
> >  
> >  ifdef CONFIG_MPENTIUM4
> > -CFLAGS += -march=i686
> > +CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
> >  endif
> 
> 
> Looks ok to me (I run this patch locally, and also am the one who 
> submitted the check_gcc patch).
> 
> I haven't had any problems at all, but I'm curious if anyone has any 
> negative feedback...  It's rather easy to be conservative and ignore the 
> patch, since -march=i686 should always work.
> 

Just curious, what can go wrong ? Only if gcc has a bug when scheduling
insns for P4, for example, or if gcc spits some special that does not
work as supposed...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
