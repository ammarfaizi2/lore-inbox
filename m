Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273656AbRIWWMc>; Sun, 23 Sep 2001 18:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273661AbRIWWMW>; Sun, 23 Sep 2001 18:12:22 -0400
Received: from fysh.org ([212.47.68.126]:35342 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S273656AbRIWWMH>;
	Sun, 23 Sep 2001 18:12:07 -0400
From: zefram@fysh.org
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
Message-Id: <E15lHUG-0001N5-00@bowl.fysh.org>
Date: Sun, 23 Sep 2001 23:12:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>Your xterm is not following Linux policy - this is a solved problem in
>Linuxspace. Debian bit the bullet a few years ago and did the neccessary
>deed to make all their terminal emulators and console match.

So Linux policy is to support only terminals that generate ^? for
backspace?  I thought Unix-like systems were supposed to be usable from a
great variety of text terminals.  Debian's policy works when your universe
consists solely of Linux machines configured to Debian specifications,
where your terminals are just the Linux console, xterm and screen,
but it fails to handle glass ttys, or xterms running on other systems.

I recall the reaction when someone proposed changing zsh's line editor
(ZLE) to treat backspace and delete characters differently.  Just among
the developers we have users of a wide variety of terminals, and the
proposed change would have broken the line editor for many of us.
As it is, ZLE just works, with no extra effort, on any text terminal,
and we get no complaints.

>                                                   Original telnet has
>IAC sequences to send a "delete" regardless of keymapping policies that
>are not known at end points.

Yes, it was a nice model, a pity it fell out of use.  Telnet defined a
Network Virtual Terminal, that was intended to be a common terminal type
to be emulated on all Telnet sessions, which would have eliminated the
need for the server to know what terminal type was being used on the
client end.  Of course, the NVT was a product of its time: no cursor
addressing, no display attributes, and on the input side only a single
erase key.  The closest equivalent to this model that is currently in
use is the de facto almost-universal capability to emulate a VT100.

These days telnet connections (and rsh and ssh) are used more as dumb
pipes to talk to the user's actual terminal.  We can't change that,
and the result is that Unix systems have to handle whatever terminal
type the user is using.

-zefram
