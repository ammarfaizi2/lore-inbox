Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTA0VVc>; Mon, 27 Jan 2003 16:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbTA0VVc>; Mon, 27 Jan 2003 16:21:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16649 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267310AbTA0VVb>; Mon, 27 Jan 2003 16:21:31 -0500
Date: Mon, 27 Jan 2003 16:27:57 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: David C Niemi <lkernel2003@tuxers.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
In-Reply-To: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
Message-ID: <Pine.LNX.3.96.1030127162417.27928B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, David C Niemi wrote:

> 
> I have been experiencing some baffling SSH client hangs under 2.5.59 (and
> 55) in which the session totally hangs up after I have typed (typically)
> 10-100 characters.  Right before it hangs permanently, a character is
> echo'd back to the screen several seconds late.  Interestingly, data due
> back for my client which is initiated by the server side does make it, I 
> just can't type anything further.
> 
> To reproduce this: ssh in to a somewhat distant host.  At a command 
> prompt, hold down a letter key for a couple of minutes, or just type text 
> in.  If you cut'n'paste text, it rarely hangs (my guess is that this 
> requires a lot fewer round trips than interactive typing).  It should hang 
> before you get a screenful (sometimes the sessions hang even before they 
> are set up).

Sorry to say I sometimes see this on 2.4 kernels as well, even on PPP
dialed connections. The symptoms are that the local ssh client just stops
sending packets. That's very easy to tell with an external modem:-) The
connection is still fine, if I have multiple connections to the host only
one hangs, and I believe it's a client issue in ssh.

What I see may or may not be related to your problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

