Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293297AbSCEPFQ>; Tue, 5 Mar 2002 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293288AbSCEPFG>; Tue, 5 Mar 2002 10:05:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5985 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293243AbSCEPE7>; Tue, 5 Mar 2002 10:04:59 -0500
Date: Tue, 5 Mar 2002 16:01:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305160138.E20606@dualathlon.random>
In-Reply-To: <20020305024046.Y20606@dualathlon.random> <Pine.LNX.4.44L.0203050921510.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203050921510.1413-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 09:22:25AM -0300, Rik van Riel wrote:
> On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> > On Mon, Mar 04, 2002 at 10:26:30PM -0300, Rik van Riel wrote:
> > > On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> > > > On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
> > > > > This could be expressed as:
> > > > >
> > > > > "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
> > > > > "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA
> 
> > the example you made doesn't have highmem at all.
> >
> > > has 1 ZONE_NORMAL and 1 ZONE_DMA while it has multiple
> > > HIGHMEM zones...
> >
> > it has multiple zone normal and only one zone dma. I'm not forgetting
> > that.
> 
> Your reality doesn't seem to correspond well with NUMA-Q
> reality.

Not sure to understand your point, current code should be fine for all
the classic numas, and for the case you were making too. Anyways
whatever is wrong for NUMA-Q it's not a problem introduced with the
classzone design because that's completly orthogonal to whatever numa
heuristics in the allocator and memory balancing.

Andrea
