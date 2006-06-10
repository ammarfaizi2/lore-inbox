Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWFJBQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWFJBQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWFJBQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:16:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29875 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932609AbWFJBQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:16:12 -0400
Date: Sat, 10 Jun 2006 03:15:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
In-Reply-To: <e6cgjv$b8t$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.64.0606100257550.17704@scrub.home>
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home>
 <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home>
 <e6cgjv$b8t$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Jun 2006, H. Peter Anvin wrote:

> > > Actually, that isn't quite true.  One of the ways klibc is kept small
> > > is by not guaranteeing a stable ABI... and not having compatibility
> > > support for older kernels.  This is one of the kinds of luxuries that
> > > bundling offers.
> > 
> > It's indeed more of a luxury than a necessity.
> > How often does that really change?
> 
> A lot more often than you'd think.

Often enough?

> > If you wouldn't remove all old init code at once it would still be 
> > possible to build a kernel this way. Why are you making it mandatory? Why 
> > don't you leave it optional for a while and only gradually remove the old 
> > code? This way distributions/users can experiment with it regarding their 
> > current initrd/boot setups.
> 
> Linus vetoed that option years ago.

Name dropping is of course always impressive - scares little kids and all.
Could you please provide more info, what exactly he vetoed?

>  Anyway, the standalone version of
> klibc has been available for almost three years, and has been used by
> at least Debian for their initramfs code for a considerable amount of
> time.  It's not like it's an untested piece of code.

I didn't say that, the point is if e.g. Debian is already distributing it, 
why do we need another copy?

> > Why shouldn't klibc be part of the basic build tools? I asked this already 
> > earlier: where do you draw the line regarding duplication?
> 
> Judgement call.  I'm not sure I have done the best possible job,
> either, but you have to call it somewhere.

Well for now you pretty much just moved code, that was in the kernel 
before. What I'm trying to find out is what is coming next. How does e.g. 
udev or modules fit into the picture?

> > Are you going to duplicate every single tool, which might be needed
> > to build the kernel only to reduce outside dependencies? IMO that's
> > illusory for more complex setups anyway.
> 
> Hyperbole.

Why?

> >  Let's take booting from raid, in this case you need to install
> > mdadm anyway, which could also provide an initramfs version. This
> > way the setup tools can be generated from the same source, which
> > reduces duplication and maintenance overhead.
> 
> You don't need mdadm to boot from RAID.  kinit handles it just fine.
> At the same time, I do intend to continue to maintain the standalone
> klibc, which can be used to produce external binary trees.

So why can't we use that external copy? mdadm is only example, there are 
more - please explain your plans. How will they be integrated?

> > Just to be clear here, I really appreciate the work you've done, but I'm 
> > not exactly comfortable with merging a huge patch, which completely 
> > changes the boot sequence at once, without any clear plan of what's coming 
> > next. It would be a lot less problematic if the transition would be more 
> > gradually, which IMO is very well possible. Usually it's a requirement to 
> > split large patches, why should klibc be special?
> 
> When I asked Andrew how he'd like me to pass him the code, he said he
> was happy pulling my git tree.  This saved time for both of us, and
> made it easier and quicker for me to integrate fixes.  You can do so
> too, which will get you a full history of the development, in about
> 1,400 pieces.

For -mm that's fine, but do you seriously expect it to get merged like 
that. Again, what makes klibc so special, that it doesn't have to follow 
standard rules?

Please be more specific, you are avoiding any clear answer. I'm really 
trying to understand, why you're doing it this way and what speaks against 
the alternatives and what are the next steps?

bye, Roman
