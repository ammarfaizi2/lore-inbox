Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287464AbSAEClI>; Fri, 4 Jan 2002 21:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287467AbSAECk6>; Fri, 4 Jan 2002 21:40:58 -0500
Received: from dsl-213-023-043-154.arcor-ip.net ([213.23.43.154]:42761 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287464AbSAECkw>;
	Fri, 4 Jan 2002 21:40:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Date: Sat, 5 Jan 2002 03:44:06 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin> <20020104173923.B10391@holomorphy.com>
In-Reply-To: <20020104173923.B10391@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Mgoj-0001Ew-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 02:39 am, William Lee Irwin III wrote:
> 2 or 3 shift/adds is really not possible, the population counts of the
> primes in those ranges tends to be high, much to my chagrin.

It doesn't really have to be a prime, being relatively prime is also 
good, i.e., not too many or too small factors.  Surely there's a multiplier 
in the right range with just two prime factors that can be computed with 3 
shift-adds.

> I actually
> tried unrolling it by hand a few times, and it was slower than
> multiplication on i386 (and uncomfortably lengthy).

Right, it's not worth it unless you can get it down to a handful of 
shift-adds.  How does 2**17 - 1 (Mersenne prime #6) with right-shift by
(16 - bits) work?

> I believe to address architectures where multiplication is prohibitively
> expensive I should do some reading to determine a set of theoretically
> sound candidates for non-multiplicative hash functions and benchmark them.
> Knuth has some general rules about design but I would rather merely test
> some already verified by someone else and use the one that benches best
> than duplicate the various historical efforts to find good hash functions.

It would be nice if you could just look up good ones in a cookbook, but you 
can't, that cookbook doesn't exist.

--
Daniel
