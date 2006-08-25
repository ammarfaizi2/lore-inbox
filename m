Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWHYHV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWHYHV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWHYHV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:21:58 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:10970 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751155AbWHYHV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:21:57 -0400
Date: Fri, 25 Aug 2006 09:26:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
Message-ID: <20060825072654.GC30453@uranus.ravnborg.org>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433068.3012.115.camel@pmac.infradead.org> <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr> <1156439110.3012.147.camel@pmac.infradead.org> <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:01:27AM +0200, Jan Engelhardt wrote:
> >> Compiling files on their own (`make drivers/foo/bar.o`) seems to make 
> >> the optimization void. Sure, most people don't stop compiling in 
> >> between. Just a note
> >
> >Actually I'm not entirely sure what you write is true. It'll _build_
> >fs/jffs2/read.o, for example, but it still won't then use it when I make
> >the kernel -- it'll just use fs/jffs2/jffs2.o which is built from all
> >the C files with --combine. So the optimisation isn't lost.
> 
> Umm then it spends double the time in compilation, doing:
> 
>   read.o <- read.c
It will only do this if you ask for it.
The question was what happened when you did make read.o

>   foo.o <- foo.c
>   bar.o <- bar.c
>   built-in.o <- read.c foo.c bar.c
> 
> (cf. default current:
>   built-in.o <- read.o foo.o bar.o)

And this discussion is btw. mood. If the general opinion is that we shall
include the -combine support all the kbuild infrastructure will anyway
be redone.
There are several small things that are not addressed in todays
implementation and that will be fixed one way or the other.

	Sam
