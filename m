Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263369AbTCNQds>; Fri, 14 Mar 2003 11:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbTCNQds>; Fri, 14 Mar 2003 11:33:48 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:41094 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263369AbTCNQdq>; Fri, 14 Mar 2003 11:33:46 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Mar 2003 08:53:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Valentin Nechayev <netch@netch.kiev.ua>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030314155947.GD13106@netch.kiev.ua>
Message-ID: <Pine.LNX.4.50.0303140845480.1903-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <20030311142447.GA14931@bjl1.jlokier.co.uk.lucky.linux.kernel>
 <20030314155947.GD13106@netch.kiev.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Valentin Nechayev wrote:

>  Tue, Mar 11, 2003 at 14:27:50, jamie wrote about "Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...":
>
> > Actually I think _this_ is cleanest: A three-way flag per registered
> > fd interest saying whether to:
> >
> > 	1. Report 0->1 edges for this interest.  (Initial 1 counts as an event).
> > 	2. Continually report 1 levels for this interest.
> > 	3. One-shot, report the first time 1 is noted and unregister.
> >
> > ET poll is equivalent to 1.  LT poll is equivalent to 2.  dnotify's
> > one-shot mode is equivalent to 3.
>
> kqueue can do all three variants (1st with EV_CLEAR, 3rd with EV_ONESHOT).
>
> So, result of this whole epoll work is trivially predictable - Linux will have
> analog of "overbloated" and "poorly designed" kqueue, but more poor
> and with incompatible interface, adding its own stone to hell of
> different APIs. Congratulations.

See, this is a free world, and I very much respect your opinion. On the
other side you might want to actually *read* the kqueue man page and find
out of its 24590 flags, where 99% of its users will use only 1% of its
functionality. Talking about overbloating. You might also want to know
that quite a few kqueue users currently running on your favourite OS, are
moving to Linux+epoll. The reason is still unclear to me, but I can leave
you to discover it as exercise.



> Linus was true: Linux is just for fun, not for work.

You're right here. We're having *a lot* of fun listening this kind of
statements.




- Davide

