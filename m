Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSBMXPt>; Wed, 13 Feb 2002 18:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289098AbSBMXPd>; Wed, 13 Feb 2002 18:15:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58887 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288748AbSBMXPV>; Wed, 13 Feb 2002 18:15:21 -0500
Date: Wed, 13 Feb 2002 18:13:51 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ben Greear <greearb@candelatech.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <3C6AE602.3080708@candelatech.com>
Message-ID: <Pine.LNX.3.96.1020213180951.12448L-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Ben Greear wrote:

> Bill Davidsen wrote:
> 
> > On Wed, 13 Feb 2002, Richard B. Johnson wrote:

> >>The advantage, of course is that if you are executing the kernel,
> >>it can give you all the information necessary to recreate a
> >>new one from the sources because its .config is embeded into
> >>itself. Once you have the ".config" file, you just do `make oldconfig`
> >>and you are home free.

> > But it does no such thing! You not only need the config file, you need the
> > source. So you now need to add to the kernel the entire source tree from
> > which it was built, or perhaps just a diff file from a kernel.org source,
> > which you will suitably compress, of course.
> 
> 
> Heh, if you want to exactly copy your existing kernel, just use the
> 'cp' command!  Saving the config is more useful for those of us who
> want to build a new kernel with new source that is *similar* to some
> existing kernel.  Also, when an interesting bug (ie panic) occurs,
> we can extract the .config automagically and send it along with
> the ksymoops decode to the maintainers.  It's always easier to reproduce
> the bug if you have the .config to the kernel that produced it.
> 
> Remember, you do not have to enable the feature.

No, but there's no reason to have it part of the kernel image as the only
solution. It works as a module, it works as a flat text data file in the
modules directory (except for those who can't match kernel to modules),
and ther's no reason why this can't exist somewhere which has no impact on
the size of the kernel image.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

