Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTEBShY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTEBShY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:37:24 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:47006 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261305AbTEBShX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:37:23 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 May 2003 11:50:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Florian Weimer <fw@deneb.enyo.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <87fznx42to.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.50.0305021138490.1904-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
 <Pine.LNX.4.50.0305020948550.1904-100000@blue1.dev.mcafeelabs.com>
 <87llxp43ii.fsf@deneb.enyo.de> <Pine.LNX.4.50.0305021126200.1904-100000@blue1.dev.mcafeelabs.com>
 <87fznx42to.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Florian Weimer wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
>
> > On Fri, 2 May 2003, Florian Weimer wrote:
> >
> >> Davide Libenzi <davidel@xmailserver.org> writes:
> >>
> >> > Ingo, do you want protection against shell code injection ? Have the
> >> > kernel to assign random stack addresses to processes and they won't be
> >> > able to guess the stack pointer to place the jump.
> >>
> >> If your software is broken enough to have buffer overflow bugs, it's
> >> not entirely unlikely that it leaks the stack address as well (IIRC,
> >> BIND 8 did).
> >
> > Leaking the stack address is not a problem in this case, since the next
> > run will be very->very->very likely different.
>
> Usually, you can't afford a fork() and execve() for each request you
> process. 8-(

You just do it once in your main() task and one for each thread. It's not
so bad. Only thing is a ( tunable ) waste of stack space.


> (In addition, GCC might optimize away those alloca() calls.)

Luckily enough it doesn't. I checked this a long time ago since I had the
same fear due the builtin_alloca.



- Davide

