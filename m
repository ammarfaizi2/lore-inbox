Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSKFB6c>; Tue, 5 Nov 2002 20:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbSKFB6c>; Tue, 5 Nov 2002 20:58:32 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:7608 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265513AbSKFB6a>; Tue, 5 Nov 2002 20:58:30 -0500
Date: Tue, 5 Nov 2002 19:05:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rob Landley <landley@trommello.org>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_TINY
Message-ID: <20021106020503.GG13102@opus.bloom.county>
References: <20021104195144.GC27298@opus.bloom.county> <Pine.LNX.3.96.1021105141149.17410L-100000@gatekeeper.tmr.com> <20021105195616.GF13102@opus.bloom.county> <200211051755.56586.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211051755.56586.landley@trommello.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 05:55:56PM +0000, Rob Landley wrote:
> On Tuesday 05 November 2002 19:56, Tom Rini wrote:
> > On Tue, Nov 05, 2002 at 02:26:08PM -0500, Bill Davidsen wrote:
> > > On Mon, 4 Nov 2002, Tom Rini wrote:
> > > > On Mon, Nov 04, 2002 at 02:13:48AM +0000, Rob Landley wrote:
> > > > > I've used -Os.  I've compiled dozens and dozens of packages with -Os.
> > > > >  It has always saved at least a few bytes, I have yet to see it make
> > > > > something larger.  And in the benchmarks I've done, the smaller code
> > > > > actually runs slightly faster.  More of it fits in cache, you know.
> > > >
> > > > Then we don't we always use -Os?
> >
> > [snip 6 good reasons]

Okay, let's just call it 5 then...

> 
> Reasons 1 and 2 were that you can't be sure it works on all compiler versions 
> and all platforms until you'e tried it, which you could say about anything.

Not every kernel person wants to, knows how to, or should have to debug
the compiler as well.

> Reason 3, 5, and 6 were about performance gains, when the point of CONFIG_TINY 
> is, in fact, size.

CONFIG_TINY is in fact about asking questions which should reduce the
size, and allowing the user to determine space / speed tradeoffs.

> > So why do we want to force it on for CONFIG_TINY?
> 
> 1) The point of CONFIG_TINY is size?

The point of CONFIG_TINY, as in the current patches is to offer a bunch
of tunables.  From what I read of the patch, nothing actually uses
CONFIG_TINY, except for config.in bits.  Therefore the point of
CONFIG_TINY is not about size, it's about asking questions.  So ask
another question.

> The setting in question is a default value.  CONFIG_TINY sets a lot of 
> defaults at once, and gives you something grep for if you don't like them.  I 
> realise this isn't what you want, but objecting to patches because they're 
> completely unrelated to what you want is kind of silly.

CONFIG_TINY sets no default values right now.  Go look at
http://www.jaquet.dk/kernel/config_tiny/2.5.44-allinone and tell me
where CONFIG_TINY sets defaults.

Anyhow, I hope to have enough time to finish up a rough cut of my
template work this week and post something for comments.  I've just got
to figure out how to get TWEAK_XXX to work in the Makefiles like
CONFIG_XXX does now.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
