Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSFBOAe>; Sun, 2 Jun 2002 10:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317185AbSFBOAe>; Sun, 2 Jun 2002 10:00:34 -0400
Received: from dsl-213-023-038-078.arcor-ip.net ([213.23.38.78]:28052 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317184AbSFBOAd>;
	Sun, 2 Jun 2002 10:00:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Peter Osterlund <petero2@telia.com>,
        Thunder from the hill <thunder@ngforever.de>
Subject: Re: KBuild 2.5 Impressions
Date: Sun, 2 Jun 2002 16:00:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Peter Osterlund <petero2@telia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206020601320.29405-100000@hawkeye.luckynet.adm> <m24rglhmhu.fsf@ppro.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17EVu0-0000Ph-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 June 2002 14:51, Peter Osterlund wrote:
> Thunder from the hill <thunder@ngforever.de> writes:
> > Problem #2 (make NO_MAKEFILE_GEN) is a bit tricky with the new concept. 
> > You may try to maintain it, but I wonder where you'll end up.
> 
> On my system I get 0.40s with NO_MAKEFILE_GEN compared to 3.41s
> without, so my system is fast enough even without NO_MAKEFILE_GEN. I
> just find it strange that the documentation says bug reports will be
> ignored. If it breaks unintentionally in future kernels, fixing it
> would probably not be too hard. Or are you planning to remove this
> feature altogether?

I think what he's saying is that the feature is a hack and isn't supposed
to work properly all the time, so don't complain about if it doesn't.  I
think that's a reasonable attitude.  There's yet more speed to be gained
by building the proper machinery for deciding reliably when the makefile
has to be rebuilt, and maybe doing the job incrementally, but that's not
the task at hand, that's a project for somebody to take their time and
do properly later.  It's exactly this kind of work Keith has provided a
solid base for.

FYI, the way it works is, it just fails to do the makefile rebuild,
relying on human intelligence and experience to know that nothing
changed that would require a rebuild.  IOW, use at your own risk.  I
doubt this feature will go away, because anything that speeds up a
edit/compile/kaboom cycle that much is going to be happily used by a
significant number of madmen.  If it breaks for some reason, such as
a new feature of bugfix that requires the makefile to *always* be
updated, somebody will step up to fix it.

-- 
Daniel
