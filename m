Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289679AbSAJVED>; Thu, 10 Jan 2002 16:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289681AbSAJVDv>; Thu, 10 Jan 2002 16:03:51 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32526 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289679AbSAJVDg>; Thu, 10 Jan 2002 16:03:36 -0500
Date: Thu, 10 Jan 2002 13:08:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201101107120.2809-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201101307560.1493-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Linus Torvalds wrote:

>
> On Thu, 10 Jan 2002, Davide Libenzi wrote:
> > >
> > > It wasn't a good night for benchmarking.  I had a typo in the
> > > script to run chat reniced and as a result didn't collect any
> > > numbers for this.  In addition, the kernel with Davide's patch
> > > failed to boot with 8 CPUs enabled.  Can't see any '# CPU specific'
> > > mods in the patch.  In any case, here is what I do have.
> >
> > Doh !! Do you have a panic dump Mike ?
>
> I bet it's just the placement of "init_idle()" in init/main.c, which is
> unrelated to the scheduling proper, but if the kernel thread is started
> before the boot CPU has done its "init_idle()", then the scheduler state
> isn't really set up fully yet.
>
> (Old bug, I think its been there for a long time, I just think that the
> old scheduler didn't much care, and the "child runs first" logic in
> particular of the new scheduler probably just showed it more clearly)

Uhm, seems fixed in pre11. Did you fix it in pre10->pre11 stage ?



- Davide


