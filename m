Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318278AbSIKCIu>; Tue, 10 Sep 2002 22:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318282AbSIKCIu>; Tue, 10 Sep 2002 22:08:50 -0400
Received: from packet.digeo.com ([12.110.80.53]:48263 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318278AbSIKCIt>;
	Tue, 10 Sep 2002 22:08:49 -0400
Message-ID: <3D7EAA58.335D479B@digeo.com>
Date: Tue, 10 Sep 2002 19:28:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michel Eyckmans (MCE)" <mce@pi.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 randomly freezes under X (seems input related)
References: <200209110157.g8B1vapp006206@jebril.pi.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 02:13:30.0135 (UTC) FILETIME=[D250DA70:01C25938]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michel Eyckmans (MCE)" wrote:
> 
> Greetz,
> 
> On 2.5.34, moving the mouse around (just moving, not clicking) under
> an (almost) idle X "almost" reliably freezes my machine if I just do
> it long enough. I write "almost" because:
> 
>  1) It happened on 14 out of 15 sessions, sometimes immediately
>     after logging in. I gave up on the one exception after trying
>     for more than 5 minutes.
> 
>  2) It might be related to whether there is some background activity.
>     I have a shell script that forks a lot of stuff in quick succession
>     and it seems that a lockup is guaranteed if I move my mouse while
>     that script is running. The script is not a requirement, though.
> 
> Sadly, only the reset button helps and of course nothing useful shows
> up in the logs. :-( I tried very hard to reproduce it on a virtual
> console, but failed no matter how hard I stressed the box. So X "must"
> be part of the problem somehow.
> 
> This is 2.5.34 on a dual Pentium, gcc 2.95, no preempt, AT keyboard
> & serial mouse. I never got 2.5.32 and 2.5.33 to compile/boot, so the
> problem may not be all that new. 2.5.31 works OK (not fine, but OK).
> 

Me too.  Dual PIII, 2.5.34+localhacks.  It's happened a couple
of times.  The system locks up and the CPU fans go nuts.  In X, so
no info available.

There are a few locking problems in 2.5.34 which _may_ be fixed
now, but they only seem to affect CLONE_THREAD.  It would be worth
grabbing the latest `gzipped full patch' from 
http://www.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/
though.
