Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284958AbRLTGad>; Thu, 20 Dec 2001 01:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286171AbRLTGaX>; Thu, 20 Dec 2001 01:30:23 -0500
Received: from harddata.com ([216.123.194.198]:29194 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S284958AbRLTGaR>;
	Thu, 20 Dec 2001 01:30:17 -0500
Date: Wed, 19 Dec 2001 23:30:04 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 does not boot my Alphas
Message-ID: <20011219233004.A9573@mail.harddata.com>
In-Reply-To: <20011216160404.A2945@mail.harddata.com> <200112181535.fBIFZEH16236@pinkpanther.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112181535.fBIFZEH16236@pinkpanther.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 18, 2001 at 03:35:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 03:35:13PM +0000, Alan Cox wrote:
Michal Jaegermann wrote:
> > A kernel with the highest version which I managed to boot so far,
> > on both machines, is 2.4.13-ac8.
> 
> Those and more went into 2.4.16+ so I believe that its probably a new 
> breakage not a lost diff

After a long head scratching and a number of tests it looks to me
now that this was a false alarm.  Something seems to be funky with
these new 1500's (caches?).  2.4.17rc2 recompiled with the same
configuration, both generic and a board specific kind, but compiled
on UP1100 does boot UP1100 and it seems to be ok.  At least I can
recompile another kernel while using it. :-)  Unfortunately I do not
have an access to these 1500's anymore so I cannot check if these
new binaries change anything there.  If you wonder about compiler
and binutils versions in all tests they were the same (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-87)) with this exception that in
one test i used _also_ a pretty old egcs and 2.4.17rc2 and this
kernel, recompiled on UP1100, behaved too.

To make waters considerable more muddy 2.4.9-12 binaries from Red Hat
updates to 7.1 distribution, which definitely were compiled somewhere
else, not once managed to finish booting UP1500.  UP1100 booted that
way, although this was possible, was behaving "strange" throwing
some "machine checks" and weird oopses.  This may mean that a hardware
is broken but it may also mean that this particular kernel is stomping
on some memory areas where it should not.  It is rather the second
as I did not observe anything of that sort with other kernels I am
using there.

  Michal
  michal@harddata.com
