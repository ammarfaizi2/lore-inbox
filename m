Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTJNSgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTJNSgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:36:10 -0400
Received: from adsl-68-248-220-49.dsl.klmzmi.ameritech.net ([68.248.220.49]:11791
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S262881AbTJNSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:35:57 -0400
From: tabris <tabris@tabris.net>
To: Maciej Zenczykowski <maze@cela.pl>, jlnance@unity.ncsu.edu
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Date: Tue, 14 Oct 2003 14:35:52 -0400
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310141435.52571.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 October 2003 12:27 pm, Maciej Zenczykowski wrote:
> > Let me concur with the sentiments on this thread.
> >
> > When I started using Linux, it was on a 40 MHz 386 with 8Megs of ram
> > and a 200 Meg HD.  This was a reasonably typical machine for the time
> > (1993). I ran X on this machine, and it was fine running several
> > Xterms and you could play the X version of Tetris or gnuchess.  I
> > used this machine to write the program I was working on for my
> > Masters degree.
> >
> > Today, a machine with specs like I quoted above seems hopelessly
> > slow. However, I was able to do useful work on it in 1993, and the
> > same sort of work would still be useful today.  You of course are not
> > going to be able to run mozilla and KDE on it, but lynx, slrn, mutt,
> > and fvwm will work fine.  There are many people who will never be
> > able to afford to buy a computer but could find someone to give them
> > one of these "hopelessy outdated" machines for nothing.  If we can
> > ensure that Linux keeps working on these machines, it will be a good
> > thing.
>
> On one hand I agree with you - OTOH: why not run an older version of
> the kernel? Are kernel versions 2.2 or even 2.0 really not sufficient
> for such a situation?  It should be noted that newer kernels are adding
> a whole lot of drivers which aren't much use with old hardware anyway
> and only a little actual non-driver related stuff (sure it's an
> oversimplification, but...).  Just like you don't expect to run the
> latest
> games/X/mozilla/kde/gnome on old hardware perhaps you shouldn't run the
> latest kernel... perhaps you should...
>
> Sure I would really like to be able to compile a 2.6 for my
> firewall (486DX33+40MB-2MB badram) - but is this the way to go?
>
Well... So far, 2.4 is enough for my routers. BUT, I also cannot put more 
than 32-40MB into them (i just don't have the budget to go buy 16MB FP or 
EDO DIMMs when I already have a bunch of 8MB DIMMs.

I started my project running 2.2, but that wasn't enough for what I 
needed. It might have been fine for the most part, but iproute2 doesn't 
work completely on 2.2, and there's no IPTABLES. sure, ipchains is 
simpler to config by hand, but I still want to use iptables when I can 
for the increased flexibility.

Simple fact. not everything can, or will, be backported. And not everybody 
can just make their own raw distribution. (tho it might have helped if i 
had used debian instead of RedHat on my router). and many modern distro 
installers don't like 32MB RAM... that's what i ran into.


> As for making the kernel smaller - perhaps a solution would be to code
> all strings as error codes and return ERROR#42345 or something instead
> of the full messages - there seem to be quite a lot of them.  I don't
> mean to suggest this solution for all compilations but perhaps a switch
> to remove strings and replace them with ints and then a seperately
> generated file of errnum->string. I'd expect that between 10-15% of the
> uncompressed kernel is currently pure text.
>

Considered already. Was tied into i18n. was considered impractical, esp 
w/o a realtime LANANA services or equiv for error numbers.

> Perhaps int->string conversion could be done by a loadable module or a
> userspace program?
>
> Just my 3c and some ideas.
>
> Of course part of the problem is that by designing the kernel for high
> mem situations we're using more memory hogging algorithms.  It's a
> simple matter of features vs mem footprint.
>
> I'm not convinced either way - and I'm just posting this
> as a voice in this discussion...
>
> Cheers,
> MaZe.
>
--
tabris
-
Coward, n.:
	One who in a perilous emergency thinks with his legs.
		-- Ambrose Bierce, "The Devil's Dictionary"

