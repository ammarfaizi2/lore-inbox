Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSKEWuC>; Tue, 5 Nov 2002 17:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSKEWuC>; Tue, 5 Nov 2002 17:50:02 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:54219 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265236AbSKEWuB> convert rfc822-to-8bit; Tue, 5 Nov 2002 17:50:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Tom Rini <trini@kernel.crashing.org>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: CONFIG_TINY
Date: Tue, 5 Nov 2002 17:55:56 +0000
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021104195144.GC27298@opus.bloom.county> <Pine.LNX.3.96.1021105141149.17410L-100000@gatekeeper.tmr.com> <20021105195616.GF13102@opus.bloom.county>
In-Reply-To: <20021105195616.GF13102@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211051755.56586.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 19:56, Tom Rini wrote:
> On Tue, Nov 05, 2002 at 02:26:08PM -0500, Bill Davidsen wrote:
> > On Mon, 4 Nov 2002, Tom Rini wrote:
> > > On Mon, Nov 04, 2002 at 02:13:48AM +0000, Rob Landley wrote:
> > > > I've used -Os.  I've compiled dozens and dozens of packages with -Os.
> > > >  It has always saved at least a few bytes, I have yet to see it make
> > > > something larger.  And in the benchmarks I've done, the smaller code
> > > > actually runs slightly faster.  More of it fits in cache, you know.
> > >
> > > Then we don't we always use -Os?
>
> [snip 6 good reasons]

Reasons 1 and 2 were that you can't be sure it works on all compiler versions 
and all platforms until you'e tried it, which you could say about anything.

Reason 3, 5, and 6 were about performance gains, when the point of CONFIG_TINY 
is, in fact, size.

Reason 4 is inertia.  You are explicitly considering inertia a good reason, 
then?  I remember back around 1998, the argument over "-fno-strength-reduce" 
which accomplished nothing whatsoever (and was in fact disabled in gcc 2.7.x 
for i386) but was in the kernel compile for a long time becaue nobody could 
be bothered to remove it...

> So why do we want to force it on for CONFIG_TINY?

1) The point of CONFIG_TINY is size?

2) Why is any change a "force" when you have the source code?  Isn't "force" 
an intentionally loaded word?  I could just as easily say your objection 
still boils down to "I don't want a switch that actually does something, I 
want somebody to print out a to-do list and mail it to me so I can go through 
the kernel by hand and remove support for floppy drives other than the actual 
type I have from the legacy boot sector at the start of the kernel image."  
If you want to get into loaded words.

The setting in question is a default value.  CONFIG_TINY sets a lot of 
defaults at once, and gives you something grep for if you don't like them.  I 
realise this isn't what you want, but objecting to patches because they're 
completely unrelated to what you want is kind of silly.

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
