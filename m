Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRHWPzM>; Thu, 23 Aug 2001 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268997AbRHWPzC>; Thu, 23 Aug 2001 11:55:02 -0400
Received: from stanis.onastick.net ([207.96.1.49]:9233 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S268957AbRHWPyv>; Thu, 23 Aug 2001 11:54:51 -0400
Date: Thu, 23 Aug 2001 11:55:07 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823115506.D25051@sigkill.net>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010823103620.A6965@kittpeak.ece.umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Bob Glamm did have cause to say:

> The same argument applies now that applies when this argument first
> started when ESR announced CML to the list: my '386 with 8MB of
> RAM and it's 20MB of disk doesn't have the room (or speed, for
> that matter) to install the fad interpreted language of today.
> Besides, it'll take me 45 minutes to download the latest version
> of Python over my 28.8k modem.  And yes, I download the kernel patch
> by patch to minimize the download pain ;)

[stuff cut]

> It does surprise me that Linus would actually allow this to happen.

>From the original message:

> (For those of you who grumbled about adding Python to the build-tools
> set, Linus has uttered a ukase: CML2's reliance on Python is not an
> issue.  I have promised that once CML2 is incorporated I will actually
> *reduce* the kernel tree's net dependence on external tools, and I know
> exactly how to deliver on that promise.)

My suspicion is (and I have no inside knowledge on this) he is going to do
something along the lines of the python-to-c converter -- the only people
who need python after that is done are those people working on the
configuration *engine* (not the rules files, and certainly not just to
configure/build the kernel).  Although come to think of it, a stripped
down python interpreter (in C) would also work, with roughly the same
'build the tools along the way' as the current menuconfig.  Either way, I
would be very surprised if I downloaded a stable kernel and it -required-
python.

Those are the ways (off the top of my head) to reduce the dependence on
external tools and still use python. (Although it is one of my favorite
scripting languages, I agree that it is a bit much just to configure a
kernel.) I wouldn't be surprised if, while he was at it, a lot of the
other tool dependencies got pulled out (tcl/tk, etc) such that make
menuconfig requires only libncurses and gcc, make xconfig requires only
xlib and gcc, etc.

This message brought to you by my vivid imagination, and may bear little
to no resemblence to reality. Do not taunt Happy Fun Message. ;)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
