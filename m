Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSHBPea>; Fri, 2 Aug 2002 11:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHBPe3>; Fri, 2 Aug 2002 11:34:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315218AbSHBPe3>; Fri, 2 Aug 2002 11:34:29 -0400
Date: Fri, 2 Aug 2002 08:39:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.44.0208021118120.28515-100000@serv>
Message-ID: <Pine.LNX.4.44.0208020833110.18265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Roman Zippel wrote:
>
> If these programs are so mission-critical, they better do some error
> checking. Your atomic write will fail on a full disk and if the
> information is that important, the program has to handle that.

The logging thing is logging. It's critical for performance tuning, it's
critical for later finding of errors, but it's still secondary.

It's also performance-critical in a very real way.

> I looked around a bit and it doesn't look that portable. UNIX systems seem
> to have this behaviour, but not all POSIX systems.

POSIX is a hobbled standard, and does not matter.

We're not making a "POSIX-compliant OS". People have done that before:
see all the RT-OS's out there, and see even the NT POSIX subsystem.

They are uninteresting.

Linux is a _real_ OS, not some "we filled in the paperwork and it is now
standards compliant".

And being a real OS means taking the real world into account.

And the real world says that it's not acceptable to make up your own
semantics, unless you have some _damn_ good reason for doing so.

Let's turn the tables here. I'm not interested in your "but.." arguments
at all. I've refuted every single one, and I've refuted them with cold
hard facts.

The fact is, there is _zero_ reason to change existing functionality.

We already do this right, and there is no reason to _break_ the fact that
we do it right. Can you come up with a _single_ reason for why we should
break existing standardized binary interfaces?

Binary compatibility is important. As is the larger issue of generic UNIX
compatibility. You had better have some really strong arguments for why
you would think I'd be willing to break compatibility. So far you have had
_no_ arguments for the question "Why?".

			Linus

