Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSC2Uel>; Fri, 29 Mar 2002 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311865AbSC2Ueb>; Fri, 29 Mar 2002 15:34:31 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:28295 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S311841AbSC2UeY>; Fri, 29 Mar 2002 15:34:24 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 29 Mar 2002 12:39:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 IDE 27
In-Reply-To: <3CA470D8.3080103@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203291218350.975-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Martin Dalecki wrote:

> Davide Libenzi wrote:
> > On Thu, 28 Mar 2002, Martin Dalecki wrote:
> >
> >
> >>Thu Mar 21 03:17:48 CET 2002 ide-clean-27
> >>
> >>- Make for less terse error messages in ide-tape.c.
> >>
> >>- Replaced all timecomparisions done by hand with all the proper timer_after()
> >>   commands.
> >>
> >>- Remove the drive niec1 mechanisms alltogether. There are several reasons for
> >>   this:
> >
> >
> > I did not have the time to test it Martin but looking at the code i'm
> > pretty confident that this is the cause of the ide_set_handler()/timer
> > problem on my box ...
>
> Does it mean that you think that my guess was right?

ok, the nice1 defaulted to zero did not fix it but enabling the VIA
support yes, arghhh !!! i was using the VIA chipset w/out enabling it in
.config and this made the kernel to not probe it correctly and to force
off using_dma ( and io32bit ). this resulted, besides the ide_set_handler/timer
problem, in an throughput of 3.9 MB/sec against the 24 MB/sec that i'm getting now.
i need a vacation ...


(a couple of weeks ago i screwed up my patch-bot scripts that was hunging
by trying to merge 2.5.6-pre3 on 2.5.6 - not only i considered the
operation perfectly legal but i ended up asking Linus why he screwed up
the patch :-( )


- Davide



