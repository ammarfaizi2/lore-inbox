Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSE2Kvb>; Wed, 29 May 2002 06:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSE2Kva>; Wed, 29 May 2002 06:51:30 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:35339 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S314811AbSE2Kva>;
	Wed, 29 May 2002 06:51:30 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205291051.g4TApEC24775@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <20020527134413.E35@toy.ucw.cz> from Pavel Machek at "May 27, 2002
 01:44:14 pm"
To: Pavel Machek <pavel@suse.cz>
Date: Wed, 29 May 2002 12:51:14 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Steve Whitehouse <Steve@ChyGwyn.com>,
        linux kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Pavel Machek wrote:"
> Hi!
> 
> > Look in some of the block drivers, floppy.c or loop.c.  These do call
> > the task queue, even though that's only as an aid to the rest of the
> > kernel, because they know they can help at that point, and it's not at
> > all clear what context they're in.  Perhaps it's best to look in
> > floppy.c, which runs the task queue in its init routine!  I mean to say
> 
> Init routine is called from insmod context or at kernel bootup (from pid==1).

That's nitpicking!  That the kernel init routine runs after a process is
started is an accident (and I'm not sure it's true, but what the heck
..).  Where does it say that one can rely on this?

My point is that the disk task queue "just happens".  Maybe some days in
the life of the kernel development it happens in a process context,
and maybe some days it doesn't.  Conceptually, I don't see any necesity
that it should or ought to, and even if it does, I don't see why it
should be expected to run in the context of a particular process, let
alone the one you think it should run in, on, by, from ... 

> Both look like process context to me.

And both of the oranges in front of me look orange. Neverthess, I have
eaten some red oranges.

Peter
