Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbREEVQA>; Sat, 5 May 2001 17:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135444AbREEVPu>; Sat, 5 May 2001 17:15:50 -0400
Received: from [209.195.52.31] ([209.195.52.31]:55816 "HELO [209.195.52.31]")
	by vger.kernel.org with SMTP id <S135380AbREEVPq>;
	Sat, 5 May 2001 17:15:46 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Date: Sat, 5 May 2001 13:05:43 -0700 (PDT)
Subject: Re: 2.4.4 fork() problems (maybe)
In-Reply-To: <20010505213744.B1809@lisa.links2linux.home>
Message-ID: <Pine.LNX.4.33.0105051258540.1277-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the problems found by the fork change, would it possibly be worth
making the fork behavior a compile time option (with a big warning that
child-first behavior is known to break some software)

that way people who are running software without the bugs can gain the
performance advantage and people can then test other software to discover
what has bugs in it and then fix the software so that the change can be
made permanent in a future release.

I also ran into one additional piece of software that appears to be
stopped by the fork change. The Citrix ICA client (essentially remote
display for a multi-use win NT box) locks up a few seconds after the mouse
it moved.

David Lang

 On Sat, 5 May 2001,
Marc Schiffbauer wrote:

> Date: Sat, 5 May 2001 21:37:44 +0200
> From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
> To: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: 2.4.4 fork() problems (maybe)
>
> * Magnus Naeslund(f) schrieb am 05.05.01 um 21:07 Uhr:
> > Hello, I saw that there was something changed on how fork() works, and
> > wonder if this could be the cause my problem.
> > When i do a "su - <user>" it just hangs.
> > When i run strace on it i see that it forks and wait()s on the child.
> >
> > Sometimes when i strace the su command it succeeds to give me a shell,
> > sometimes not.
> > But it allways fails when i don't strace it.
> >
>
> Hi Magnus,
>
> use 2.4.5-pre1 instead, Linus has undone the fork()-change for some
> reason ;-)
>
> Cheers
> -Marc
>
>
> --
> +-O . . . o . . . O . . . o . . . O . . .  ___  . . . O . . . o .-+
> | Ein neuer Service von Links2Linux.de:   /  o\   RPMs for SuSE   |
> | --> PackMan! <-- naeheres unter        |   __|   and  others    |
> | http://packman.links2linux.de/ . . . O  \__\  . . . O . . . O . |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
