Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273136AbRIJCC7>; Sun, 9 Sep 2001 22:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273139AbRIJCCt>; Sun, 9 Sep 2001 22:02:49 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:45253
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S273136AbRIJCCf>; Sun, 9 Sep 2001 22:02:35 -0400
Date: Sun, 09 Sep 2001 22:02:52 -0400
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1311640000.1000087372@tiny>
In-Reply-To: <20010910035519.B11329@athlon.random>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org>
 <Pine.LNX.4.33.0109091724120.22033-100000@penguin.transmeta.com>
 <20010910030405.A11329@athlon.random> <1299510000.1000086297@tiny>
 <20010910035519.B11329@athlon.random>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 10, 2001 03:55:19 AM +0200 Andrea Arcangeli
<andrea@suse.de> wrote:

>> The idea is more or less what has been discussed, but it did assume one
>> blocksize per mapping.  Of course, set_blocksize and invalidate_buffers
> 
> hmm, this sounds a bit odd, there must be only one "physical address
> space", the whole point of the change is to have only one and to kill
> all the aliasing issues this way. 

Sorry, I wasn't clear...when I wrote the first patch, your stuff didn't
exist ;-)  The original idea was to generalize it out so any mapping could
be used, yours will do nicely.

> In turn also set_blocksize will be
> nearly a noop and it won't matter anymore the granularity of the I/O,
> there won't be alias allowed anymore because the backing store of the
> cache (the "physical address space") will be shared by all the users
> regardless of the blocksize.
> 
> getblk should unconditionally alloc a new bh entity and only care to map
> it to the right cache backing store with a pagecache hash lookup.

Nods.

-chris

