Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbTCNWhh>; Fri, 14 Mar 2003 17:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbTCNWhh>; Fri, 14 Mar 2003 17:37:37 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:914 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261246AbTCNWhf>; Fri, 14 Mar 2003 17:37:35 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Mar 2003 14:57:51 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jonathan Lemon <jlemon@flugsvamp.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030314162712.A77383@flugsvamp.com>
Message-ID: <Pine.LNX.4.50.0303141444350.1903-100000@blue1.dev.mcafeelabs.com>
References: <local.mail.linux-kernel/Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <local.mail.linux-kernel/20030311142447.GA14931@bjl1.jlokier.co.uk.lucky.linux.kernel>
 <local.mail.linux-kernel/20030314155947.GD13106@netch.kiev.ua>
 <200303142143.h2ELheqx076668@mail.flugsvamp.com>
 <Pine.LNX.4.50.0303141412260.1903-100000@blue1.dev.mcafeelabs.com>
 <20030314162712.A77383@flugsvamp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Jonathan Lemon wrote:

> > > >> So, result of this whole epoll work is trivially predictable - Linux will have
> > > >> analog of "overbloated" and "poorly designed" kqueue, but more poor
> > > >> and with incompatible interface, adding its own stone to hell of
> > > >> different APIs. Congratulations.
> > > >
> > > >See, this is a free world, and I very much respect your opinion. On the
> > > >other side you might want to actually *read* the kqueue man page and find
> > > >out of its 24590 flags, where 99% of its users will use only 1% of its
> > > >functionality. Talking about overbloating. You might also want to know
> > > >that quite a few kqueue users currently running on your favourite OS, are
> > > >moving to Linux+epoll. The reason is still unclear to me, but I can leave
> > > >you to discover it as exercise.
> > >
> > > FUD. You should know that in the normal case, kq users don't use any
> > > flags, but they are available for those people who are doing specific
> > > things.  But I bet you knew that already and just want to slam something
> > > that isn't epoll.
> >
> > Please, consider reading the message that generated the response before
> > generating superfluous noise. Expecially those "overbloated" and "poorly
> > designed" thingies. In my books overbloat is the presence of features that
> > 99% of users simply ignore.
>
> I've read the entire thread.
>
> I'm responding to your hyperbole about "XXX flags", which is pure
> exaggeration.  I might as well say that epoll is "limited" and
> "single-purpose", since it is not capable of doing the same things
> that kqueue can do.  In my book, engineering should make the common
> case fast, and the uncommon case possible.  You seem to be ignoring
> the latter.
>
> If you want to call those features you don't use, "bloat", fine.  But
> they *are* useful to many (>> 1) people, and they were added because
> there was no other way to solve their problem.  You should see the
> laundry list of items/features/extensions/flags I declined to add, usually
> because they were too special-purpose.

Let's start again. We were talking about APIs and there was a guy that
wrote that kqueue is better than epoll. I then replied that API are a
matter of personal opinions and that I prefer epoll, with other guys
pretty much following this taste. What I don't like of kqueue is 1)
multiplexing of a single funtion doing 23 different tasks 2) has many
options that A) increase code size B) are used by 2% of its users. This
was inserted in the context where I explicitly said that API are a matter
of personal taste. Then a guy came out with "overbloated" and "poorly
designed", and I replied to him. And no, you don't need 47 flags/options
to do things that people di for ages using poll(2). You're pushing code
inside the kernel when *many* of those things can be done in user space.
Why should the 98% of users using the bare minimum API to pay the price of
those extra features ? Let me guess you're going to say that those extra
features have no cost ... yeah right.




- Davide

