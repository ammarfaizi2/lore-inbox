Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270022AbUJNKXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbUJNKXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270025AbUJNKXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:23:42 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:18322 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S270022AbUJNKXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:23:39 -0400
Message-ID: <15261.195.245.190.94.1097749350.squirrel@195.245.190.94>
In-Reply-To: <20041014120007.01c26760@mango.fruits.de>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
    <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
    <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
    <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
    <20041014105711.654efc56@mango.fruits.de>
    <20041014091953.GA21635@elte.hu>
    <20041014120007.01c26760@mango.fruits.de>
Date: Thu, 14 Oct 2004 11:22:30 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Florian Schmidt" <mista.tapas@gmx.net>
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Daniel Walker" <dwalker@mvista.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Andrew Morton" <akpm@osdl.org>,
       jackit-devel@lists.sourceforge.net
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 14 Oct 2004 10:23:38.0222 (UTC) FILETIME=[DE7FD0E0:01C4B1D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Florian Schmidt wrote:
>
> CC'ed jackit-devel mailing list, cause this might be interesting for them,
> too.
>
> Ah, btw: U0 booted fine here.. Seems to run allright, too (for everything
> non jackd). Only thing is:
>
> When starting jackd i get a floating point exception. Dunno where that
> comes from:
>
> ~$ jackd -d alsa -p 512
> jackd 0.99.0
> Copyright 2001-2003 Paul Davis and others.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
>
> loading driver ..
> creating alsa driver ... hw:0|hw:0|512|2|48000|0|0|nomon|swmeter|-|32bit
> control device hw:0
> configuring for 48000Hz, period = 512 frames, buffer = 2 periods
> Couldn't open hw:0 for 32bit samples trying 24bit instead
> Couldn't open hw:0 for 24bit samples trying 16bit instead
> Couldn't open hw:0 for 32bit samples trying 24bit instead
> Couldn't open hw:0 for 24bit samples trying 16bit instead
> Floating point exception
>

This does not happen on my laptop.

Testing also 2.6.9-rc4-mm1-U0, but a slightly custom jack 0.99.5 (cvs)
patched with "my" max_delayed_usecs suite.

And jackd it's pumping while I'm writing this lines: jackd -R -d alsa,
against bundled crapsound (ali5451).

My laptop is a P4 2.53Ghz, running on Mandrake 10.1c (gcc 3.4.1, glibc
2.3.3 NPTL).

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

