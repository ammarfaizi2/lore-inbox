Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbTCNV4U>; Fri, 14 Mar 2003 16:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbTCNV4U>; Fri, 14 Mar 2003 16:56:20 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:50833 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262628AbTCNV4T>; Fri, 14 Mar 2003 16:56:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Mar 2003 14:16:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jonathan Lemon <jlemon@flugsvamp.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <200303142143.h2ELheqx076668@mail.flugsvamp.com>
Message-ID: <Pine.LNX.4.50.0303141412260.1903-100000@blue1.dev.mcafeelabs.com>
References: <local.mail.linux-kernel/Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <local.mail.linux-kernel/20030311142447.GA14931@bjl1.jlokier.co.uk.lucky.linux.kernel>
 <local.mail.linux-kernel/20030314155947.GD13106@netch.kiev.ua>
 <200303142143.h2ELheqx076668@mail.flugsvamp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Jonathan Lemon wrote:

> In article <local.mail.linux-kernel/Pine.LNX.4.50.0303140845480.1903-100000@blue1.dev.mcafeelabs.com> you write:
> >On Fri, 14 Mar 2003, Valentin Nechayev wrote:
> >
> >>  Tue, Mar 11, 2003 at 14:27:50, jamie wrote about "Re: [patch, rfc]
> >lt-epoll ( level triggered epoll ) ...":
> >>
> >> > Actually I think _this_ is cleanest: A three-way flag per registered
> >> > fd interest saying whether to:
> >> >
> >> > 	1. Report 0->1 edges for this interest.  (Initial 1 counts as an event).
> >> > 	2. Continually report 1 levels for this interest.
> >> > 	3. One-shot, report the first time 1 is noted and unregister.
> >> >
> >> > ET poll is equivalent to 1.  LT poll is equivalent to 2.  dnotify's
> >> > one-shot mode is equivalent to 3.
> >>
> >> kqueue can do all three variants (1st with EV_CLEAR, 3rd with EV_ONESHOT).
> >>
> >> So, result of this whole epoll work is trivially predictable - Linux will have
> >> analog of "overbloated" and "poorly designed" kqueue, but more poor
> >> and with incompatible interface, adding its own stone to hell of
> >> different APIs. Congratulations.
> >
> >See, this is a free world, and I very much respect your opinion. On the
> >other side you might want to actually *read* the kqueue man page and find
> >out of its 24590 flags, where 99% of its users will use only 1% of its
> >functionality. Talking about overbloating. You might also want to know
> >that quite a few kqueue users currently running on your favourite OS, are
> >moving to Linux+epoll. The reason is still unclear to me, but I can leave
> >you to discover it as exercise.
>
> FUD. You should know that in the normal case, kq users don't use any
> flags, but they are available for those people who are doing specific
> things.  But I bet you knew that already and just want to slam something
> that isn't epoll.

Please, consider reading the message that generated the response before
generating superfluous noise. Expecially those "overbloated" and "poorly
designed" thingies. In my books overbloat is the presence of features that
99% of users simply ignore.



- Davide

