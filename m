Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311397AbSCMWKo>; Wed, 13 Mar 2002 17:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311396AbSCMWKe>; Wed, 13 Mar 2002 17:10:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26885 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311397AbSCMWKX>;
	Wed, 13 Mar 2002 17:10:23 -0500
Date: Wed, 13 Mar 2002 22:10:22 +0000
From: wli@holomorphy.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020313221022.H14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Andrea Arcangeli <andrea@suse.de>,
	wli@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
	riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
In-Reply-To: <20020313021838.G14628@holomorphy.com> <Pine.LNX.3.95.1020313134921.28928A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020313134921.28928A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Mar 13, 2002 at 02:06:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 02:06:48PM -0500, Richard B. Johnson wrote:
> [SNIPPED..]

Nice move. No one will have the foggiest idea without hunting for
my prior message whether your comments on what I said are accurate.


On Wed, Mar 13, 2002 at 02:06:48PM -0500, Richard B. Johnson wrote:
> You might want to look at www.eece.unm.edu/faculty/heileman/hash/hash.html
> rather than assuming everyone is uninformed. Source-code is provided
> for several hashing functions as well as source-code for tests. This
> is a relatively old reference although it addresses both the chaos
> and fractal methods discussed here, plus chaotic probe strategies
> in address hashing.

You've presented a paper that attempts to establish a connection
between chaos theory and hashing by open addressing. I'm not convinced
chaos theory is all that, but some of their measurement techniques
appear useful, and I'll probably try using them, despite the fact Linux
appears to favor hashing by separate chaining.

This URL has not convinced me you are informed, and I don't really want
to be convinced whether you're informed or not. Your contributions to
these threads have been far less than enlightening or helpful thus far.


On Wed, Mar 13, 2002 at 02:06:48PM -0500, Richard B. Johnson wrote:
> A fast random number generator is essential to produce meaningful
> tests within a reasonable period of time. It is also used within one
> of the hashing functions to 'guess' at the direction of displacement
> when an insertion slot is not immediately located, as well as the
> displacement mechanism for several chaotic methods discussed.

I don't buy this, and the reason why is that hashing is obviously
sensitive to the input distribution. To defeat any hash function,
you need only produce a distribution concentrated on a set hashing
to the same number. If your distribution is literally uniform, then
you'll never do better (by one measure) than least residue mod hash
table size. You need to produce a realistic set of test keys. The key
distributions you actually want to hash will be neither of the above.
(Though one should verify it doesn't do poorly on uniform input, it's
little more than a sanity check.)


On Wed, Mar 13, 2002 at 02:06:48PM -0500, Richard B. Johnson wrote:
> Using your own hash-function as a template for tests of the same
> hash-function, as you propose, is unlikely to provide meaningful
> results.

I'm not proposing that. I have no idea why you think I am.

If I may summarize, if you're going to use random number generation
to simulate test inputs, verify the distribution of the test inputs
you generate actually resembles the thing you're trying to simulate.

It's far more productive to get samples of kernel virtual addresses
of the objects whose addresses you're hashing, or inode numbers from
real filesystems, or filenames, or whatever, than to just feed it a
stream of numbers spewed by some random number generator no one's
heard of, and that's not going to change in the least. For a Monte
Carlo simulation of its usage in the kernel, you're going to need to
actually figure out how to simulate those things' distributions.


Hmm, I wouldn't be suprised to get a bunch of "YHBT" messages after
this but the chaos theory paper does have some useful stuff for
analyzing hash table performance. Distributions' entropies and Lyapunov
exponents of hash functions should be easy enough to compute.


Bill
