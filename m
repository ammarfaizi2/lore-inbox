Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265914AbSKDHHI>; Mon, 4 Nov 2002 02:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbSKDHHI>; Mon, 4 Nov 2002 02:07:08 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:9602 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265914AbSKDHHE> convert rfc822-to-8bit; Mon, 4 Nov 2002 02:07:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: CONFIG_TINY
Date: Mon, 4 Nov 2002 02:13:33 +0000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021030233605.A32411@jaquet.dk> <20021031132607.E21801@borg.org> <20021031185308.GE30193@opus.bloom.county>
In-Reply-To: <20021031185308.GE30193@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211012054.34338.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 18:53, Tom Rini wrote:
> On Thu, Oct 31, 2002 at 01:26:07PM -0500, Kent Borg wrote:
> > On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> > > In other words, s/CONFIG_TINY/CONFIG_FINE_TUNE, and ask about
> > > anything / everything which might want to be tuned up.
> >
> > Please, no.  Keep this simple.
>
> We can keep it simple, as long as we keep it flexible.

If having the source isn't enough flexibility for you, it's not possible TO 
have enough flexibility for you.

The point of CONFIG_TINY is that anybody interested in looking at how to trim 
the fat on their kernel has something to grep for, and it's als a quick and 
dirty way to say "this kernel will go on boot floppy or eprom boot image" 
without having to spend two days micro-managing.

Having "config_8_million_tweaks" is actually counter-productive.  It's quite 
possible to give people so many buttons and levers they can't find the two 
they're interested in, and there will ALWAYS be instances where you have to 
go diddle the source.

Are you seriously suggesting that every single #defined constant should be 
editable from make menuconfig?  If not, you acknowledge that there IS a line 
that needs to be drawn.  And the place it has CURRENTLY been drawn (what IS 
in make menuconfig) is a darn good starting point for discussion of where it 
should be.

> > I don't want a bunch of configs that abstract out everything I might
> > want to tamper with to make a small system.  The only way I am going
> > to make sense out of them will be to look at the source controlled by
> > each anyway.  I would rather search the source for CONFIG_TINY and see
> > a single, coherent, and sensible set of concrete changes that make
> > things smaller.  Let me mangle and customize from there, it will be
> > much easier for me to understand what I am doing.
>
> Templates would help out here.  Right now, if something isn't a config
> option, you have to dig into the source to tune things.

More or less by definition, yes.

> This isn't
> really nice since to tweak most things you only need to change a few
> constants.

You're against people having to modify the source at all, then.  That 
argument's not going far around here, you realise this don't you?

> The problem is finding all of these constants, and the
> places where maybe someone used a number derrived from the constant, and
> so on..

1) This is a seperate argument.  Your'e trying to bolt your personal pet 
project on to the CONFIG_TINY discussion, and they have nothing to do with 
each other.

2) Provide a patch.  The CONFIG_TINY people have a patch.  You do not.  You 
lose.

> > > Then this becomes a truely useful set of options, since as Alan
> > > pointed out in one of the earlier CONFIG_TINY threads, his Athlon
> > > could benefit from some of these 'tiny' options too.
> >
> > Certainly, if there are potential config options that would be truly
> > useful to general folks, then by all means, yes!, make them separate
> > options.  (Isn't that what has been going on all along?)
>
> I would hope it was, but it doesn't seem like that's been what's going
> on..

Because you haven't personally done it, and nobody else seems to be 
interested.

> > But let us
> > not put in a config for every imaginable tuning and then pretend that
> > hiding them behind a CONFIG_FINE_TUNE somehow doesn't make them any
> > less a groady mess.
>
> Let's not pretend that changing > 1 tunable param with 1 CONFIG question
> makes it any better than it is now.

Let's not pretend having one config option for every #define in anything more 
than a semantic difference as far as the #defines are concerned, and on top 
of that it lowers the value of menuconfig by polluting it with stuff that 
very few people should ever have to care about.

> Building a 'tiny' kernel should have nothing to do with any of this.

Oh good, we agree on something.

Start a new thread then, and stop objecting to CONFIG_TINY.

> Don't think 'tiny' think 'flexible'.

Nobody's working on CONFIG_FLEXIBLE.  You're trying to hijack a project with a 
different agenda because it doesn't do something totally unrelated that you 
think should be done.

>  And I'm not necessarily saying it
> has to be N CONFIG options (Matt Porter's template idea is rather
> tempting), just that things have to be:
> a) Flexible enough such that someone who wants to tweak param X doesn't
> have to know every intricate detail of subsystem Y just to tune things.

And the universe in general should be easily manipulated by people who don't 
understand how it actually works.  This is called "magic".

> b) Done in a way that doesn't clutter up the code in question (ideally
> s/some_constant/SOME_DEFINE).
> c) Be simple enough such that people don't shoot their feet off, at
> least not unintentionally.

It should also have the ability to turn lead into gold and make people 
younger.  I don't think you'll find anybody who disagrees that these would be 
great things for it to be able to do.

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?



