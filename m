Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284302AbRLRRYA>; Tue, 18 Dec 2001 12:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284330AbRLRRX4>; Tue, 18 Dec 2001 12:23:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284302AbRLRRXm>; Tue, 18 Dec 2001 12:23:42 -0500
Date: Tue, 18 Dec 2001 09:22:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011218085059.A1176@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0112180918340.2867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Mike Kravetz wrote:
> On Tue, Dec 18, 2001 at 02:09:16PM +0000, Alan Cox wrote:
> > The scheduler is eating 40-60% of the machine on real world 8 cpu workloads.
> > That isn't going to go away by sticking heads in sand.
>
> Can you be more specific as to the workload you are referring to?
> As someone who has been playing with the scheduler for a while,
> I am interested in all such workloads.

Well, careful: depending on what "%" means, a 8-cpu machine has either
"100% max" or "800% max".

So are we talking about "we spend 40-60% of all CPU cycles in the
scheduler" or are we talking about "we spend 40-60% of the CPU power of
_one_ CPU out of 8 in the scheduler".

Yes, 40-60% sounds like a lot ("Wow! About half the time is spent in the
scheduler"), but I bet it's 40-60% of _one_ CPU, which really translates
to "The worst scheduler case I've ever seen under a real load spent 5-8%
of the machine CPU resources on scheduling".

And let's face it, 5-8% is bad, but we're not talking "half the CPU power"
here.

		Linus

