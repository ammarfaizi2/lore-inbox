Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSEAXRL>; Wed, 1 May 2002 19:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSEAXRK>; Wed, 1 May 2002 19:17:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17460 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314094AbSEAXRJ>; Wed, 1 May 2002 19:17:09 -0400
Date: Thu, 2 May 2002 01:17:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Cc: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502011750.M11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 11:05:47AM -0700, Jesse Barnes wrote:
> On Wed, May 01, 2002 at 04:23:41AM +0200, Andrea Arcangeli wrote:
> > What's the advantage? And after you can have more than one mem_map,
> > after you added this "vector", then each mem_map will match a
> > discontigmem pgdat. Tell me a numa machine where there's an hole in the
> > middle of a node. The holes are always intra-node, never within the
> > nodes themself. So the nonlinear-numa should fallback to the stright
> 
> Just FYI, there _are_ many NUMA machines with memory holes in the
> middle of a node.  Check out the discontig patch at
> http://sf.net/projects/discontig for more info.

so ia64 is one of those archs with a ram layout with huge holes in the
middle of the ram of the nodes? I'd be curious to know what's the
hardware advantage of designing the ram layout in such a way, compared
to all other numa archs that I deal with. Also if you know other archs
with huge holes in the middle of the ram of the nodes I'd be curious to
know about them too. thanks for the interesting info!

Andrea
