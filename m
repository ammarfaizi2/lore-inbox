Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281910AbRLICW3>; Sat, 8 Dec 2001 21:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282373AbRLICWT>; Sat, 8 Dec 2001 21:22:19 -0500
Received: from dsl-213-023-038-245.arcor-ip.net ([213.23.38.245]:44295 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281910AbRLICWL>;
	Sat, 8 Dec 2001 21:22:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Sun, 9 Dec 2001 03:24:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>,
        Hans Reiser <reiser@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CNHk-0000u4-00@starship.berlin> <1007834523.2566.2.camel@ixodes.goop.org>
In-Reply-To: <1007834523.2566.2.camel@ixodes.goop.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Cte0-00013u-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 8, 2001 07:02 pm, Jeremy Fitzhardinge wrote:
> On Fri, 2001-12-07 at 07:51, Daniel Phillips wrote:
> > I did try R5 in htree, and at least a dozen other hashes.  R5 was the 
> > worst of the bunch, in terms of uniformity of distribution, and caused a 
> > measurable slowdown in Htree performance.  (Not an order of magnitude, 
> > mind you, something closer to 15%.)
> 
> Did you try the ReiserFS teahash?  I wrote it specifically to address
> the issue you mentioned in the paper of an attacker deliberately
> generating collisions; the intention was that each directory (or maybe
> filesystem) have its own distinct hashing key.

Yes, I tried every hash in ReiserFS.  Please have a look at Larry McVoy's 
'linear congruential' hash in the bitkeeper code.  It's decent.  In fact, the 
only good hashes I've found after trolling all over the internet are that 
one, and the one I wrote, both based on combining a sequence of characters 
with a well-known pseudo-random number generation technique.

--
Daniel
