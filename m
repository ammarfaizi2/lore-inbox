Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129338AbQKFJjP>; Mon, 6 Nov 2000 04:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129357AbQKFJjE>; Mon, 6 Nov 2000 04:39:04 -0500
Received: from [62.254.209.2] ([62.254.209.2]:4856 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S129338AbQKFJi4>;
	Mon, 6 Nov 2000 04:38:56 -0500
Date: Mon, 6 Nov 2000 09:38:53 +0000 (GMT)
From: Stephen Landamore <stephenl@zeus.com>
To: Thomas Pollinger <tpolling@rhone.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT] TCP/IP weirdness in 2.2.15
In-Reply-To: <5.0.0.25.0.20001103173708.034fb360@stargate>
Message-ID: <Pine.LNX.4.10.10011060917300.6962-100000@phaedra.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, 3 Nov 2000, Thomas Pollinger wrote:
> Running a 'cvs get' on the Linux clients of a larger source tree
> eventually hangs the client in the middle of the get process. The
> hang is *always* reproduceable (however it does not always hang at
> the same place, sometimes after 1', sometimes after 5' to
> 10'). Several runs on Win NT did not show this problem.
[...]
> At last, I tried to do the same on another HP-UX box and there was
> no blocking at all.
>
> What is interesting to know is that between the HP-UX server and the
> HP client is a Linux router with a 3c905 card, 2.2.14 kernel.

Let me see if I understand this correct:

	Client	Router	Server
	------------------------------------
	Linux	Linux	HPUX		Bad
	WinNT	Linux	HPUX		Good
	HPUX	Linux	HPUX		Good

With all Linux boxes version 2.2.something

Is this correct?

This is slightly different from my situation; I had a Linux client and
Linux server directly connected to the same switch (3Com Superstack
II, FWIW)

I found the client always hung in my test; this was only visible at
the end of a SPEC run. Analysing tcpdump etc showed that in fact it
died somewhere early in the test, almost always before 10 minutes
worth of run.

In the end I 'fixed' the problem by using a HPUX server :-/ ... I
observe that there _are_ some SPECweb99 submissions with Linux (the
Tux result), I'm curious to know if the people who actually did the
test run experienced any problems...

Perhaps if I get time I'll repeat the experiment with (a) the most
recent Alan pre-2.2 kernel and (b) the most recent 2.4-test kernel...

I'll re-iterate my original request, which was not "it's broke - can
you fix it" but was "okay, how do I go about tracking this one down?"

cheers,
stephen

--
Stephen Landamore, <slandamore@zeus.com>              Zeus Technology
Tel: +44 1223 525000                      Universally Serving the Net
Fax: +44 1223 525100                              http://www.zeus.com
Zeus Technology, Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
