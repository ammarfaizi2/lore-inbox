Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272343AbTHKIkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 04:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272381AbTHKIkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 04:40:37 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:12024 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S272343AbTHKIke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 04:40:34 -0400
Subject: Re: [PATCH]O14int
From: Martin Schlemmer <azarah@gentoo.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308111608.18241.kernel@kolivas.org>
References: <200308090149.25688.kernel@kolivas.org>
	 <200308091904.19222.kernel@kolivas.org>
	 <1060580691.13254.7.camel@workshop.saharacpt.lan>
	 <200308111608.18241.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060590900.13254.42.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 10:35:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 08:08, Con Kolivas wrote:
> On Mon, 11 Aug 2003 15:44, Martin Schlemmer wrote:
> > On Sat, 2003-08-09 at 11:04, Con Kolivas wrote:
> > > On Sat, 9 Aug 2003 01:49, Con Kolivas wrote:
> > > > More duck tape interactivity tweaks
> > >
> > > s/duck/duct
> > >
> > > > Wli pointed out an error in the nanosecond to jiffy conversion which
> > > > may have been causing too easy to migrate tasks on smp (? performance
> > > > change).
> > >
> > > Looks like I broke SMP build with this. Will fix soon; don't bother
> > > trying this on SMP yet.
> >
> > Not to be nasty or such, but all these patches have taken
> > a very responsive HT box to one that have issues with multiple
> > make -j10's running and random jerkyness.
> 
> A UP HT box you mean?

Given :D

> That shouldn't be capable of running multiple make -j10s 
> without some noticable effect. Apart from looking impressive, there is no 
> point in having 30 cpu heavy things running with only 1 and a bit processor 
> and the machine being smooth as silk; the cpu heavy things will just be 
> unfairly starved in the interest of appearance (I can do that easily enough). 
> Please give details if there is a specific issue you think I've broken or 
> else I wont know about it.
> 

My opinion when the first 3.06 with HT came out was also sceptic.
They did not perform that well.  Things did change though - with
the 8[67]5p chipsets and dual channel ddr400 it is a vast
improvement, even if only a P4 2.4C running HT.

To give a good example (right, not linux based :P), my brother
have pretty much the same system running XP.  With the P4T533-c
(rambus) running a 2.4B, he could not do video encoding at highest
priority (or even high) and be able to do much else.  With 875p
and 2.4C he do encoding at highest priority, get frame rates
of 28-35+ (with the dual pass, etc) which is higher than the old
2.4B, while playing C&C Generals, watching movie, etc.

My system runs two make -j24's (yes, just testing), while MP3's
play smooth and general moving between desktops and windows is
still smooth with the default scheduler.

After all - most of what I do is compile too many things while
trying to read email, browse, irc and listen to MP3's.  I do not
mind the obvious skip or two if really pushing the box, and after
all, interactivity is 50% in the mind (ok, maybe not that much),
but I do notice a degrade in 'interactivity' with your patches
and HT enabled on this box.

Another question - should bogomips (or some other type of general
system performance measurement) not have a bigger role in how
the scheduler work ?  Maybe I am on crack, but I assume a process
gets more 'slices' per second/minute on a 3GHz machine than on a
300MHz ?  It may already, have not checked =)

> > I am not so sure I for one want changes to the scheduler for
> > SMP (not UP interactivity ones anyhow).
> 
> They're not; the improvements should affect fairness on SMP as well and 
> although interactivity is what I'm addressing on the surface, fairness is the 
> real issue.
> 

Yes, but 'fairness' and 'interactivity' is not the same thing (IMHO).

'fairness' in my books means give each process enough time when it
is needed so that everything gets whatever it do done without
being 'forgotten' for too long, or having disk/whatever hold up too
badly, or starving a smaller process to death.

'interactivity' on the other hand means (my books again) starve
everything that would not be noticed by the user so that he can
'wiggle around windows' (sorry, seen this a few times, and could
not help myself =) to his heats content and still not get XMMS
to skip (ok, so maybe this may be once again too far fetched :-).

Just me.

NB: any chance to get you patches against vanilla/bk as well,
    as I in general like rolling my own kernels more than using
    mm, jc, etc (no offence guys).


Thanks,

-- 
Martin Schlemmer


