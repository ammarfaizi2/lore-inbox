Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289386AbSAODWW>; Mon, 14 Jan 2002 22:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289388AbSAODWM>; Mon, 14 Jan 2002 22:22:12 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:55301 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289386AbSAODV5>; Mon, 14 Jan 2002 22:21:57 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jan 2002 19:27:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ed Tomlinson <tomlins@cam.org>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
Subject: Re: [patch] O(1) scheduler-H6/H7 and nice +19
In-Reply-To: <20020115031905.01B0624AC1@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.40.0201141927090.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Ed Tomlinson wrote:

> On January 14, 2002 09:33 pm, Davide Libenzi wrote:
> > try to replace :
> >
> > PRIO_TO_TIMESLICE() and RT_PRIO_TO_TIMESLICE() with :
> >
> > #define NICE_TO_TIMESLICE(n)    (MIN_TIMESLICE + ((MAX_TIMESLICE - \
> > 	MIN_TIMESLICE) * ((n) + 20)) / 39)
> >
> >
> > NICE_TO_TIMESLICE(p->__nice)
>
> Not sure about this change.  gkrellm shows the compile getting about 40%
> cpu.  Best result here seems to be with a larger range of timeslices.  ie
> 1-15 ((10*HZ)/1000...) instead lets the compile get 80% of the cpu.  wonder
> if this might be the way to go?

What's the MIN/MAX_TIMESLICE range that you used to get 80% of cpu ?




- Davide


