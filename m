Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSIIQs2>; Mon, 9 Sep 2002 12:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSIIQs2>; Mon, 9 Sep 2002 12:48:28 -0400
Received: from waste.org ([209.173.204.2]:38355 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317512AbSIIQs1>;
	Mon, 9 Sep 2002 12:48:27 -0400
Date: Mon, 9 Sep 2002 11:53:03 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020909165303.GA31597@waste.org>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com> <alg3ct$pru$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alg3ct$pru$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2002 at 06:03:09PM +0000, David Wagner wrote:
> D. Hugh Redelmeier wrote:
> >The Intel (and, I assume, the AMD) hardware random generator cannot be
> >audited.

...

> Rather, to audit the Intel RNG, the first thing to do is to run
> statistical tests on the input to SHA-1.  Ideally, you'd like to do
> this before the von Neumann stage, but since the von Neumann compensator
> is in hardware, that's not possible.  Fortunately, you can do the
> auditing on the output of the von Neumann stage, and this is almost
> as good.  Because the von Neumann filter does only very light conditioning,
> any flaws in the input to the von Neumann stage are likely to be apparent
> after the output stage as well, if you have a large number of samples.

This argument assumes you have knowledge of the inner workings of this
step. To the best of my knowledge no one outside of Intel has cracked
open this chip and actually tested that this black box _does what it
says its doing_. This is what is meant by auditing.

Randomness tests like DIEHARD are absolutely useless for anything
other than telling you the spectral uniformity of a source, which is
no indication as to whether it's deterministic or not.

> Both of these tests have been performed.  Paul Kocher has looked
> carefully at the Intel RNG, and given it high scores.  See
>   http://www.cryptography.com/resources/whitepapers/IntelRNG.pdf

What right-thinking paranoid would place any faith in an analysis with
an Intel copyright? This is practically marketing fluff anyway.

> Of course, there are no guarantees.  But let's look at the alternatives.
> If you pick software-based noise sources, there's always the risk that
> they may fail to produce useful entropy.  (For instance, you sample the
> soundcard, but 5% of machines have no soundcard and hence give no
> entropy, or 5% of the time you get back stuff highly correlated to
> 60Hz AC.)  The risk that a software-based noise source fails seems much
> higher than the risk that the Intel RNG has a backdoor.

But we can actually audit the former and decided whether to trust it.
For the Intel part, we only have faith. If you're one of the numerous
governments that's bought crypto solutions from respectable
corporations for your diplomatic communications that later turned out
to be backdoored, that faith doesn't have much currency. See Lotus
Notes and Crypto AG for two of the more notorious cases.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
