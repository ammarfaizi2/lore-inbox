Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSKNEAX>; Wed, 13 Nov 2002 23:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKNEAX>; Wed, 13 Nov 2002 23:00:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18693 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261693AbSKNEAV>;
	Wed, 13 Nov 2002 23:00:21 -0500
Message-ID: <3DD32152.3020909@pobox.com>
Date: Wed, 13 Nov 2002 23:06:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: kaos@ocs.com.au, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk...
References: <20021114032456.381C42C06E@lists.samba.org>
In-Reply-To: <20021114032456.381C42C06E@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> In message <3DD2BEBB.8040003@pobox.com> you write:
>
> >Petr Vandrovec wrote:
> >
> >
> >>Hi Rusty,
> >>  I'm probably missing something important, but do you have any plans
> >>to integrate module-init-tools into modutils, or extend 
> module-init-tools
> >>functionality to make them usable? I tried module-init-tools 0.6
> >>and I must say that I'm really surprised that it is possible to make
> >>such change after feature freeze, without maintaining at least minimal
> >>usability.
> >>
> >>  If there are modutils which can live with new module system, please
> >>point me to them. But I did not found such.
> >
> >
> >I'm hoping that Rusty will work with Keith to integrate support for
> >2.5.x into the existing modutils package...  it's rather annoying to
> >have two totally different modutils when switching between 2.[024].x and
> >2.5.x kernels.
>
>
> The current method is that on "make install" the module-init-tools
> move the old ones to xxx.old (if they exist), and do a backwards
> compat check every time they start (and execvp xxx.old on every older
> kernel).  If it doesn't work for you, please report.
>
> To package them, the distros will probably hack modutils into
> module-init-tools/old or something and make them install themselves as
> xxx.old automatically.  Code apprediated.


That's what I meant about working with existing modutils.  I can't think 
that anybody is excited about the extra work involved in supporting two 
modutils packages for years to come.

The backward compat thing is really a hack, and not system software done 
right :(  modutils should not need to rename all its binaries *.old -- 
and have that be the default that users see when installing the rpm.  No 
company worth its shareholders would release a package full of "*.old" 
binaries.  Come on...

If its politics that is preventing you from submitting modutils 
packages, then I encourage you to publicly post modutils patches, so 
that the early adopters, distros, and others can use those and have 
their existing systems continue to work seamlessly between 2.4 and 2.5. 
  Please?

foo.old is not a solution we want with us long-term... and booting into 
older kernels will be with us long-term.


> >/me is building drivers into the kernel for now, which slows down
> >debugging, because modules are broken on ia32 and module support isn't
> >present on alpha at all anymore [AFAICS]...
>
>
> Yes, I've been distracted, sorry.  I only implemented i386, ia64,
> sparc, sparc64, ppc and ppc64 (some untested in-kernel, but linking
> logic works).  I have access to an Alpha, but work has stopped while I
> try to keep up with everything else.  RTH can probably complete it in
> a fraction of the time I could anyway.


Well, that more than satisfies my objection here, then.  Thanks.  I only 
saw ia32 modifications go into the kernel... I'm glad others have been 
tested, or at least played with, on multiple architectures.  I'm sure if 
rth doesn't tackle alpha module loading, Ivan or I will have it done :)

	Jeff



