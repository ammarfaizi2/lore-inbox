Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277266AbRJDXuc>; Thu, 4 Oct 2001 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277270AbRJDXuW>; Thu, 4 Oct 2001 19:50:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44039 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277266AbRJDXuK>; Thu, 4 Oct 2001 19:50:10 -0400
Date: Thu, 4 Oct 2001 16:50:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0110041647130.975-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Oct 2001, Mike Kravetz wrote:

> On Thu, Oct 04, 2001 at 10:42:37PM +0000, Linus Torvalds wrote:
> > Could we try to hit just two? Probably, but it doesn't really matter,
> > though: to make the lmbench scheduler benchmark go at full speed, you
> > want to limit it to _one_ CPU, which is not sensible in real-life
> > situations.
>
> Can you clarify?  I agree that tuning the system for the best LMbench
> performance is not a good thing to do!  However, in general on an
> 8 CPU system with only 2 'active' tasks I would think limiting the
> tasks to 2 CPUs would be desirable for cache effects.

Yes, limiting to 2 CPU's probably gets better cache behaviour, and it
might be worth looking into why it doesn't. The CPU affinity _should_
prioritize it down to two, but I haven't thought through your theory about
IPI latency.

However, the reason 2.2.x does so well is that in 2.2.x it will stay on
_once_ CPU if I remember correctly. We basically tuned the scheduler for
lmbench, and not much else.

		Linus

