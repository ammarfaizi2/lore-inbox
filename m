Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288432AbSBDElA>; Sun, 3 Feb 2002 23:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288420AbSBDEkv>; Sun, 3 Feb 2002 23:40:51 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:4357 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S288354AbSBDEkf>; Sun, 3 Feb 2002 23:40:35 -0500
Date: Sun, 3 Feb 2002 23:47:30 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Dan Kegel <dank@kegel.com>, Kev <klmitch@MIT.EDU>
Cc: Arjen Wolfs <arjen@euro.net>, <coder-com@undernet.org>,
        <feedback@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <3C5DFF0F.3B5EFFC0@kegel.com>
Message-ID: <Pine.LNX.4.44.0202032344310.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2002, Dan Kegel wrote:

> Kev wrote:
> > If that's true, I confess I can't quite see your point even still.  Once
> > the event is generated, ircd should read or write as much as it can, then
> > not pay any attention to the socket until readiness is again signaled by
> > the generation of an event.  Sorry if I'm being dense here...
>
> If you actually do read or write *until an EWOULDBLOCK*, no problem.
> If your code has a path where it fails to do so, it will get stuck,
> as no further readiness events will be forthcoming.  That's all.

It seems kind of odd, at first, but it does make sense in a inverted sort
of way.  Basically you aren't going to get any signals from the kernel
until the EWOULDBLOCK state clears.  Consider what would happen if you
received a signal every time you could, say send. Your process would be
flooded with signals, which of course wouldn't work.  If you want to take
a look at the Hybrid-7 cvs tree, let me know and I can give you a copy of
it.  I just got the sigio stuff working correctly in their.

Regards,

Aaron

