Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315342AbSEBSKf>; Thu, 2 May 2002 14:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315345AbSEBSKe>; Thu, 2 May 2002 14:10:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8529 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315344AbSEBSKd>; Thu, 2 May 2002 14:10:33 -0400
Date: Thu, 2 May 2002 20:10:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502201043.L11414@dualathlon.random>
In-Reply-To: <3971861785.1020330424@[10.10.2.3]> <E173Juk-0000Qr-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:58:02AM -0700, Gerrit Huizenga wrote:
> In message <3971861785.1020330424@[10.10.2.3]>, > : "Martin J. Bligh" writes:
> > > With numa-q there's a 512M hole in each node IIRC. that's fine
> > > configuration, similar to the wildfire btw.
> > 
> > There's 2 different memory models - the NT mode we use currently
> > is contiguous, the PTX mode is discontiguous. I don't think it's
> > as simple as a 512Mb fixed size hole, though I'd have to look it
> > up to be sure.
> 
> No - it definitely isn't as simple as a 512 MB hole.  Depends on how much

I meant that as an example, I recall that was valid config, 512M of ram
and 512M hole, then next node 512M ram and 512M hole etc... Of course it
must be possible to vary the mem size if you want more or less ram in
each node but still it doesn't generate a problematic layout for
discontigmem (i.e. not 256 discontigous chunks or something of that
order).

> memory is in each node, holes could be all kinds of sizes.  You could,
> in theory, have had 128 MB in one node and 8 GB in another node.  I don't
> think we had holes within the node from the software side - I think the
> requirement was that all DIMMS were added in low to high memory slots.
> Not sure what forced that requirement - could have been PTX, BIOS,
> cache controllers, etc.
> 
> gerrit


Andrea
