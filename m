Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311610AbSCNMxO>; Thu, 14 Mar 2002 07:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311608AbSCNMxF>; Thu, 14 Mar 2002 07:53:05 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:33953 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311609AbSCNMwx>;
	Thu, 14 Mar 2002 07:52:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: root@chaos.analogic.com, wli@holomorphy.com
Subject: Re: 2.4.19pre2aa1
Date: Thu, 14 Mar 2002 13:47:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
In-Reply-To: <Pine.LNX.3.95.1020314071041.3534A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020314071041.3534A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lUdc-0000Oz-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2002 01:18 pm, Richard B. Johnson wrote:
> On Wed, 13 Mar 2002 wli@holomorphy.com wrote:
> > [big swinging math stuff]
>
> Listen you incompetent amoeba. I attempted to tell you in a nice
> way that your apparent mastery of technical mumbo-jumbo will be
> detected by many who have actual knowledge and expertise in the
> area in which you pretend to be competent.

You were way wide of the mark, though admittedly Bill reacted more 
agressively than necessary, it's what happens when you use steroids to build 
up your math muscles ;-)

Bill knows what a pseudorandom generator is, and how to use it for testing 
hash functions, so do I.  I don't really like the one you showed, though I 
appeciate the fact it's a couple of assembly instructions and has a decent 
period.  Did you run a spectral test[1] on it?  I'd be surprised if the 
results are pretty, though pleasantly surprised.  I have one myself sitting 
around somewhere that's 2 or 3 instructions long, based on an LSR, which does 
have some analyzable properties.  Though for serious testing I wouldn't use 
it - I'd crack my Numerical Recipes in C or use urandom, taking it on faith 
that the coder was duly diligent.  A few cycles saved evaluating the hash 
just isn't worth it if you then have to wonder if patterns in your generator 
are showing through to your test results.

You missed a lot if you didn't notice the quality of Bill's work on the hash.
I 100% agree with his approach[2].  The fact he managed to satisfy davem 
should tell you a lot - we now have nice, short multiplicative hashes to use 
that get evaluated as fast shift-adds on sparc.  These hashes have *provably* 
good behavior.  Thanks Bill.

[1] see Knuth
[2] well, I sort of put him up to it...

-- 
Daniel
