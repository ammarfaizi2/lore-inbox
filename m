Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269824AbRHMVgt>; Mon, 13 Aug 2001 17:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269825AbRHMVgk>; Mon, 13 Aug 2001 17:36:40 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:49145 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S269824AbRHMVg0> convert rfc822-to-8bit; Mon, 13 Aug 2001 17:36:26 -0400
Date: Mon, 13 Aug 2001 17:36:42 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Subject: Re: Are we going too fast?
Message-ID: <Pine.LNX.4.20.0108131710420.1037-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 13 Aug 2001, PinkFreud wrote:
> 
> > Have a contact address for LSILOGIC?  I'll be happy to CC them in any
> > future bug reports.  It may also be useful to place this address in
> > comments at the top of the ncr53c8xx driver as well.
> 
> It is in fact Pamela Delaney, a LSILOGIC employee, who added support for
> the 53C1010 in the sym53c8xx driver version 1.6. This allowed me time for
> porting version 1.5 (without C1010 support) to FreeBSD (sym driver) and to
> add my own variant of C1010 support to sym. Pamela didn't seem to want to
> add her name and address in the source.  Anyway, you may want to have a
> look at the LSILOGIC web and ftp site for the Linux support. I would be
> surprised if you cannot find Pamela's email address.

I'll look.  Thanks.

> > I think I've proven a number of things to be broken in the 2.4.x series -
> > but they doesn't seem to be getting fixed.  My point was, perhaps more
> > effort should be put into fixing these bugs, rather than adding new
> > features to a supposedly stable series.
> 
> Matter of opinion. I would say that Linux-2.4 has been way long to come
> and wasn't quite ready for stable status. There are numerous other O/Ses

That's what I've been attempting to say, as well.  It seems to have been
released too quickly - minimal testing, too many bugs.

> that have had to suffer such a problem in their long life, especially
> commercial ones. Nothing that only applies to Linux here, in my
> experience.

I think Linux is something of a unique case here, though.  Linus wanted to get
2.4.x out quickly - and now there's more bugs to deal with than ever.  For
this level of (in?)stability, I'd still expect to see this as a development
kernel.  Please, don't get me wrong - I *do* realize the earlier in a kernel
series we are, the more problems will appear.  I just happen to think that
there are far too many for a series labeled 'stable'.  Either a third series
should be created for the interim, or perhaps the kernels need to be in
'devel' for a bit longer?

Just my 2 cents.

> > If Linux is trying to prove itself usable for the business world, how is
> > that going to help?  I'm not implying that I'm a business in any way,
> > shape, or form - but given that I think the majority of us want to see
> > Linux in the server rooms, and even on the desktop, what does this mean
> > for those users?
> 
> Btw, we are using some Linux machines at the company I work to. They
> donnot seem to run 2.4 kernels for the moment. As I am the only guy that
> also uses FreeBSD, I donnot want to risk FreeBSD 5 for real work for the
> same reason. :)

5.0 is current, 4.3 is release.  As I understand it, 'current' is the
equivalent of Linux's 'devel' and 'stable' the equivalent of Linux's 'stable'.

If that's the case, your refusal to use a 'current' release on a production
machine would be like refusing to use 2.3.x or 2.5.x on a production machine -
a very sound decision.  But what of 2.4.x?  It's called stable, but yet has a
ways to go.

> OTOH, we have software that explodes Solaris 8 in a millisecond but that
> works reliably on previous Solaris releases, but Solaris 8 is not that
> young an OS release as we know. Just an example that applies to a
> commercial Unix O/S...

True.  But is that due to a bug in the particular software, or the OS?  :P

> > I know plenty of Windows users who are quite upset at the lack of
> > stability.  They either don't know/understand that there are alternatives,
> > or feel it's too hard to switch to an alternative.
> 
> A windows machine is generally some melting pot of [an O/S + broken
> hardwares + broken drivers + broken applications + viruses] driven by
> unaware users. It is a miracle for such a thing to work enough for real
> work to be possible. Personnaly, I haven't problems with Windows. It runs
> games just fine and since I donnot use it for anything else, it just fit
> my needs. :-)

There's plenty of unaware users using Linux nowadays (RedHat, Mandrake, ...).
What does this mean for them?  Distributions are now including 2.4.x kernels.
What happens when their systems blow up, as the 3 I've used here have?

> > I definintely believe this (the random panic) to be a bug in your
> > ncr53c8xx driver.  ksymoops seemed to believe it to be the case, and
> > NetBSD seems to be working fine, which means it's not faulty hardware.
> 
> I have retrieved your bug report (emailed on 28 July 2001). I was in
> vacation at this date until yesterday. I cannot read thousands of emails
> in a couple of hours, sorry.

My apologies.  I understand you're busy.  I just got a bit frustrated when I
found that all three systems I've tried 2.4.x kernels on blew up.

> The problem is due to a NULL pointer being read from the driver DONE
> queue. This queue uses 0xfffffff as a tag for empty entries and valid
> addresses for entries pointing to completed CCBs. Since this driver is
> actually stable since years (only sym53c8xx was under development) it is
> likely the driver data structures that are screwed up from some other
> place rather than a driver bug, in my opinion. If this also happens on
> 2.2.x (x>=18) kernel release, it will be another story, obviously.

I haven't tried the later 2.2.x kernels on that machine.  Since I do plan on
using that system in some sort of production capacity, and since it's currently
running NetBSD without a problem, I don't think I'm going to get the chance to
run Linux on it any time in the near future.  I do, as mentioned earlier, have
an Alpha with the same controller, which currently operates just fine with
2.2.14.  I will be more than happy to install the latest 2.2.x kernel on it
when the NetBSD system replaces what it does, and see if it blows up.

> Regards,
>   Gérard.


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

