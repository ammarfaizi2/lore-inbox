Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287751AbSAAFn3>; Tue, 1 Jan 2002 00:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287755AbSAAFnT>; Tue, 1 Jan 2002 00:43:19 -0500
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:46761 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287751AbSAAFnC>; Tue, 1 Jan 2002 00:43:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Timothy Covell <timothy.covell@ashavan.org>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Date: Mon, 31 Dec 2001 16:41:19 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020101054301.YWGP617.femail27.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 December 2001 07:19 pm, Linus Torvalds wrote:
> On Sun, 30 Dec 2001, Timothy Covell wrote:
> > 	When X11 locks up, I can still kill it and my box lives.  When
> > framebuffers crash, their is no recovery save rebooting.  Back in 1995
> > I thought that linux VTs and X11 implemenation blew Solaris out of the
> > water, and now we want throw away our progress?  I'm still astounded
> > by the whole "oooh I can see  a penquin while I boot-up" thing?
> > Granted, frame buffers have usage in embedded systems, but do they
> > really have to be so deeply integrated??
>
> They aren't.
>
> No sane person should use frame buffers if they have the choice.
>
> Like your mama told you: "Just say no". Use text-mode and X11, and be
> happy.
>
> Some people don't have the choice, of course.
>
> 		Linus

X11 isn't always an improvement.  I've got an X hang on my laptop (about once 
a week) that freezes the keyboard and ignores mouse clicks.  Numlock doesn't 
change the keyboard LEDs, CTRL-ALT-BACKSPACE won't do a thing, and although I 
can ssh in and run top (and see the CPU-eating loop), kill won't take X down 
and kill-9 leaves the video display up so the console that thinks it's in 
text mode, but isn't, is still useless.  (And that's assuming I'm plugged 
into the network and have another box around to ssh in from...)

Compiling a debug version of X to run under gdb via ssh is on my to-do list...

A userspace program that takes over your main I/O devices modally and keeps 
them if it hangs isn't THAT much better than having the kernel ignore you 
directly...

Rob
