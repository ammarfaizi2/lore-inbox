Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136803AbRECN0O>; Thu, 3 May 2001 09:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136808AbRECN0E>; Thu, 3 May 2001 09:26:04 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:5902 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S136803AbRECNZy>; Thu, 3 May 2001 09:25:54 -0400
Message-Id: <200105031324.f43DOeaA030953@pincoya.inf.utfsm.cl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: stoffel@casc.com (John Stoffel), esr@thyrsus.com, cate@dplanet.ch,
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...] 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Thu, 03 May 2001 13:47:25 +0100." <E14vIW2-0005US-00@the-village.bc.nu> 
Date: Thu, 03 May 2001 09:24:40 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> In-Reply-To: <200105031232.f43CW7aA009990@pincoya.inf.utfsm.cl> from "Horst von
>      *** Brand" at May 03, 2001 08:32:07 AM
> > > No, we're just asking you to make the CML2 parser more tolerant of old
> > > and possibly broken configs.

> > It is _much_ easier on everybody involved to just bail out and ask the
> > user (once!) to rebuild the configuration from scratch starting from
> > the defaults.

> No. Every new kernel changes the constraints so every new kernel you have
> to reconfigure from scratch. That also makes it very hard to be sure you got
> the results right.

Really? I've mostly seen symbols added, very rarely did I see constraints
changed. But that might be just my narrow view on the matter...

> oldconfig has a simple algorithm that works well for current cases
> 
> Start at the top of the symbols in file order. If a symbol is new ask the
> user. If a symbol is now violating a constraint it gets set according to 
> existing constraints if not it gets set to its old value.

I understand that to mean: "If it is new and (at least somewhat)
unconstrained, ask the user.  If fully constrained, take that value
unconditionally." This is a _very_ different case from a broken
configuration as a starting point, in which constraints are violated with
the values as set.

Hell, I had to rebuild my .config files from scratch a few times already
because of wild changes in the hardware on which the resulting kernels
would have to run, its not _that_ big a deal to have to perhaps have to do
it once each time a new stable kernel series starts or so.

People, remember that doing certain things in software is just not worth
the effort.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
