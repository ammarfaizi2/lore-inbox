Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314146AbSEBAVq>; Wed, 1 May 2002 20:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSEBAVq>; Wed, 1 May 2002 20:21:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:27811 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314146AbSEBAVp>;
	Wed, 1 May 2002 20:21:45 -0400
Date: Thu, 2 May 2002 10:20:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502002010.GA14243@krispykreme>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> so ia64 is one of those archs with a ram layout with huge holes in the
> middle of the ram of the nodes? I'd be curious to know what's the
> hardware advantage of designing the ram layout in such a way, compared
> to all other numa archs that I deal with. Also if you know other archs
> with huge holes in the middle of the ram of the nodes I'd be curious to
> know about them too. thanks for the interesting info!

>From arch/ppc64/kernel/iSeries_setup.c:

 * The iSeries may have very large memories ( > 128 GB ) and a partition
 * may get memory in "chunks" that may be anywhere in the 2**52 real
 * address space.  The chunks are 256K in size.

Also check out CONFIG_MSCHUNKS code and see why I'd love to see a generic
solution to this problem.

Anton
