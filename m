Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310489AbSCLJHs>; Tue, 12 Mar 2002 04:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310491AbSCLJHh>; Tue, 12 Mar 2002 04:07:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310489AbSCLJHY>; Tue, 12 Mar 2002 04:07:24 -0500
Date: Tue, 12 Mar 2002 07:36:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312073659.Z10413@dualathlon.random>
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312053152.D687@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312053152.D687@holomorphy.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 05:31:52AM +0000, wli@holomorphy.com wrote:
> On Tue, Mar 12, 2002 at 04:19:58AM +0000, wli@parcelfarce.linux.theplanet.co.uk wrote:
> > 	http://www.samba.org/~anton/linux/pagecache/pagecache_before.png
> > 
> > 	is a histogram of the pagecache hash function's bucket distribution
> > 	on an SMP ppc64 machine after some benchmark run.
> > 
> > 	http://www.samba.org/~anton/linux/pagecache/pagecache_after.png
> > 
> > 	has a histogram of a Fibonacci hashing hash function's bucket
> > 	distribution on the same machine after an identical benchmark run.
> 
> akpm just pointed out to me these histograms are not quite the best
> comparisons as the tables differ in size. I'll get something webabble

yes, I also noticed it immediatly, 250000 buckets vs 8million buckets...
Not only that, now I also noticed it seems there is a different number
of entries into the two hashes.

> soon with head-to-head comparisons. OTOH the general nature of things
> should be clear and the behavior of that hash function visible.

I won't be really surprised if you can beat the pagecache hash with big
files. Fibonacci/mul may very well be better there. I'm not sure if you
can beat it on the small files though, and still one should always take
into account the cache effects, the monitoring of the hash distribution
isn't the end of the story.

I would be mostly interested to see a comparions for the hashfn of the
wait_table too, that is the thing we were discussing here.

Andrea
