Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVAMVaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVAMVaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVAMV3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:29:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:48013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261705AbVAMVXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:23:15 -0500
Date: Thu, 13 Jan 2005 13:22:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, grendel@caudium.net,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1105649837.6031.54.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0501131307430.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net> 
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>  <20050112185133.GA10687@kroah.com>
  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>  <20050112161227.GF32024@logos.cnet>
  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>  <20050112174203.GA691@logos.cnet>
  <1105627541.4624.24.camel@localhost.localdomain>  <20050113194246.GC24970@beowulf.thanes.org>
  <20050113115004.Z24171@build.pdx.osdl.net>  <20050113202905.GD24970@beowulf.thanes.org>
  <1105645267.4644.112.camel@localhost.localdomain>
 <1105649837.6031.54.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Arjan van de Ven wrote:
>
> On Thu, 2005-01-13 at 19:41 +0000, Alan Cox wrote:
> 
> > So the non-disclosure argument is perhaps put as "equality of access at
> > the point of discovery means everyone gets rooted.". And if you want a
> > lot more detail on this read papers on the models of security economics
> > - its a well studied field.
> 
> or in other words: you can write an exploit faster than y ou can write
> the fix, so the thing needs delaying until a fix is available to make it
> more equal.

That's a bogus argument, and anybody who looks at MS practices and 
is at all honest with himself should see it as a bogus argument.

I think MS _still_ to this day will stand up and say that they have had no
zero-day exploits. Exactly because they count "zero-day" as the day things
get publically released. Never mind that exploits where (and are)  
privately available on cracking networks for months before. They just
haven't been publically released BECAUSE EVERYBODY IS PARTICIPATING IN THE
GAME.

The written rule in this community is "no honest person will report a bug
before its time is through". Which automatically means that you get 
branded as being "bad" if you ever rock the boat. That's a piece of 
bullshit, and anybody who doesn't admit it is being totally dishonest with 
himself.

Me, I consider that to be dirty.

Does Linux have a better track record than MS? Damn right it does. We've 
had fewer problems, and I think there are more people out there standing 
up for what's right anyway. Less PR people deathly afraid of rockign the 
boat. Better technology, and fewer horrid design mistakes.

But that doesn't mean that all the same things aren't true for vendor-sec 
that are true for MS. They are just bad to a (much, I hope) smaller 
degree.

So instead, let's look at FACTS:

 - fixing a security bug is almost always much easier than writing an 
   exploit.  Arjan, your argument simply isn't true except for the worst 
   possible fundamental design issues. You should know that. In the case 
   of "uselib()", it was literally four lines of obvious code - all the 
   rest was just to make sure that there weren't any other cases like that
   lurking around.

 - There are more white-hats around than black-hats, but they are often 
   less "driven" and motivated. Now _that_, I would argue, is the real 
   problem with early disclosure - motivation.  The people really 
   motivated to find the bugs are the people who are also motivated to
   mis-use them. However, vendor-sec and "the game" just makes it more 
   worth-while for security firms to participate in it - it gives them the 
   "good PR" thing. And how much can you trust the "gray hats"?

And this is why I believe vendor-sec is part of the problem. If you don't
see that, then you're blinding yourself to the downsides, and trying to
only look at the upsides.

Are there advantages and upsides? Yes. Are there disadvantages?  
Indubitably. And anybody who disregards the disadvantages as "inevitable"
is not really interested in fixing the game.

			Linus
