Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261878AbSI3BCh>; Sun, 29 Sep 2002 21:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261884AbSI3BCh>; Sun, 29 Sep 2002 21:02:37 -0400
Received: from crack.them.org ([65.125.64.184]:21260 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261878AbSI3BCA>;
	Sun, 29 Sep 2002 21:02:00 -0400
Date: Sun, 29 Sep 2002 21:07:46 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20020930010746.GA28120@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020929152731.GA10631@averell> <20020929235141.GA1090@krispykreme> <20020930003121.GB2805@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020930003121.GB2805@averell>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 02:31:21AM +0200, Andi Kleen wrote:
> On Mon, Sep 30, 2002 at 01:51:41AM +0200, Anton Blanchard wrote:
> > 
> > Hi Andi,
> > 
> > > Also added an noinline macro to wrap __attribute__((noinline)). That's 
> > > not used yet. It tells the compiler that it should never inline, which
> > > may be useful to prevent some awful code generation for those misguided
> > > folks who use -O3 (gcc often screws up the register allocation of a 
> > > function completely when bigger functions are inlined). 
> > 
> > Could you also add an always inline? It would be useful for functions
> > like context_switch, where we require it to be inlined (otherwise it
> > falls outside scheduling_functions_{start,end}_here and wchan handling
> > fails).
> 
> Ok. gcc supports it with __attribute__((always_inline))
> 
> Suggestions for a name? alwaysinline would be a bit lengthy.

Stick with always_inline?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
