Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKNDTL>; Wed, 13 Nov 2002 22:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSKNDSN>; Wed, 13 Nov 2002 22:18:13 -0500
Received: from dp.samba.org ([66.70.73.150]:3001 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261418AbSKNDSD>;
	Wed, 13 Nov 2002 22:18:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rusty@rustcorp.com.au, kaos@ocs.com.au,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk... 
In-reply-to: Your message of "Wed, 13 Nov 2002 16:06:03 CDT."
             <3DD2BEBB.8040003@pobox.com> 
Date: Thu, 14 Nov 2002 14:53:50 +1100
Message-Id: <20021114032456.381C42C06E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD2BEBB.8040003@pobox.com> you write:
> Petr Vandrovec wrote:
> 
> > Hi Rusty,
> >   I'm probably missing something important, but do you have any plans
> > to integrate module-init-tools into modutils, or extend module-init-tools
> > functionality to make them usable? I tried module-init-tools 0.6
> > and I must say that I'm really surprised that it is possible to make
> > such change after feature freeze, without maintaining at least minimal
> > usability.
> >
> >   If there are modutils which can live with new module system, please
> > point me to them. But I did not found such.
> 
> 
> I'm hoping that Rusty will work with Keith to integrate support for 
> 2.5.x into the existing modutils package...  it's rather annoying to 
> have two totally different modutils when switching between 2.[024].x and 
> 2.5.x kernels.

The current method is that on "make install" the module-init-tools
move the old ones to xxx.old (if they exist), and do a backwards
compat check every time they start (and execvp xxx.old on every older
kernel).  If it doesn't work for you, please report.

To package them, the distros will probably hack modutils into
module-init-tools/old or something and make them install themselves as
xxx.old automatically.  Code apprediated.

> /me is building drivers into the kernel for now, which slows down 
> debugging, because modules are broken on ia32 and module support isn't 
> present on alpha at all anymore [AFAICS]...

Yes, I've been distracted, sorry.  I only implemented i386, ia64,
sparc, sparc64, ppc and ppc64 (some untested in-kernel, but linking
logic works).  I have access to an Alpha, but work has stopped while I
try to keep up with everything else.  RTH can probably complete it in
a fraction of the time I could anyway.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
