Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSAAHEl>; Tue, 1 Jan 2002 02:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbSAAHEc>; Tue, 1 Jan 2002 02:04:32 -0500
Received: from svr3.applink.net ([206.50.88.3]:51208 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287767AbSAAHEW>;
	Tue, 1 Jan 2002 02:04:22 -0500
Message-Id: <200201010704.g01740Sr016296@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Timothy Covell <timothy.covell@ashavan.org>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Date: Tue, 1 Jan 2002 01:00:13 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com> <20020101054301.YWGP617.femail27.sdc1.sfba.home.com@there>
In-Reply-To: <20020101054301.YWGP617.femail27.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 December 2001 15:41, Rob Landley wrote:
> On Sunday 30 December 2001 07:19 pm, Linus Torvalds wrote:
> > On Sun, 30 Dec 2001, Timothy Covell wrote:
> > > 	When X11 locks up, I can still kill it and my box lives.  When
> > > framebuffers crash, their is no recovery save rebooting.  Back in 1995
> > > I thought that linux VTs and X11 implemenation blew Solaris out of the
> > > water, and now we want throw away our progress?  I'm still astounded
> > > by the whole "oooh I can see  a penquin while I boot-up" thing?
> > > Granted, frame buffers have usage in embedded systems, but do they
> > > really have to be so deeply integrated??
> >
> > They aren't.
> >
> > No sane person should use frame buffers if they have the choice.
> >
> > Like your mama told you: "Just say no". Use text-mode and X11, and be
> > happy.
> >
> > Some people don't have the choice, of course.
> >
> > 		Linus
>
> X11 isn't always an improvement.  I've got an X hang on my laptop (about
> once a week) that freezes the keyboard and ignores mouse clicks.  Numlock
> doesn't change the keyboard LEDs, CTRL-ALT-BACKSPACE won't do a thing, and
> although I can ssh in and run top (and see the CPU-eating loop), kill won't
> take X down and kill-9 leaves the video display up so the console that
> thinks it's in text mode, but isn't, is still useless.  (And that's
> assuming I'm plugged into the network and have another box around to ssh in
> from...)
>
> Compiling a debug version of X to run under gdb via ssh is on my to-do
> list...
>
> A userspace program that takes over your main I/O devices modally and keeps
> them if it hangs isn't THAT much better than having the kernel ignore you
> directly...
>
> Rob

Well laptops traditionally are made with some rather funky stuff.  And laptops
are made to be shutdown and restarted often, so I'd just make sure that I ran
ReiserFS and/or ext3 on it and be happy when it works at all.

-- 
timothy.covell@ashavan.org.
