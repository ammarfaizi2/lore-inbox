Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268244AbTBYUUQ>; Tue, 25 Feb 2003 15:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbTBYUUQ>; Tue, 25 Feb 2003 15:20:16 -0500
Received: from [195.223.140.107] ([195.223.140.107]:59270 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268244AbTBYUUP>;
	Tue, 25 Feb 2003 15:20:15 -0500
Date: Tue, 25 Feb 2003 21:30:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225203001.GV29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372680000.1046201260@flay>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 11:27:40AM -0800, Martin J. Bligh wrote:
> > the only solution is to do rmap lazily, i.e. to start building the rmap
> > during swapping by walking the pagetables, basically exactly like I
> > refill the lru with anonymous pages only after I start to need this
> > information recently in my 2.4 tree, so if you never need to pageout
> > heavily several giga of ram (like most of very high end numa servers),
> > you'll never waste a single cycle in locking or whatever other worthless
> > accounting overhead that hurts performance of all common workloads
> 
> Did you see the partially object-based rmap stuff? I think that does
> very close to what you want already.

I don't see how it can optimize away the overhead but I didn't look at
it for long.

Andrea
