Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318955AbSH1UW2>; Wed, 28 Aug 2002 16:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318957AbSH1UW2>; Wed, 28 Aug 2002 16:22:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318955AbSH1UW0>; Wed, 28 Aug 2002 16:22:26 -0400
Date: Wed, 28 Aug 2002 13:29:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dominik Brodowski <devel@brodo.de>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <1030566353.7290.71.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0208281327140.8978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Aug 2002, Alan Cox wrote:
> 
> If you look at the papers on the original ARM cpufreq code you'll see a
> case where very long granuality user driven policy is pretty much
> essential. The kernel sometimes does not have enough information.

Alan, that is _not_ the point here.

It's ok to tell the kernel these "long-term" policies. But it has to be 
told as a POLICY, not as a random number. Because I can show you a hundred 
other cases where the user mode code does _not_have_a_clue_.

That's my argument. The kernel should be given a _policy_, not a "this 
frequency". Because a frequency is provably not enough, and can be quite 
hurtful.

And I do not want to get people used to passing in frequencies, when I can 
absolutely _prove_ that it's the wrong thing for 99% of all uses.

		Linus

