Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314587AbSEBP7L>; Thu, 2 May 2002 11:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSEBP7K>; Thu, 2 May 2002 11:59:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24897 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314587AbSEBP7K>; Thu, 2 May 2002 11:59:10 -0400
Date: Thu, 2 May 2002 17:59:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502175946.H11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <E172gnj-0001pS-00@starship> <20020502024740.P11414@dualathlon.random> <20020502023711.GF32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 07:37:11PM -0700, William Lee Irwin III wrote:
> On Thu, May 02, 2002 at 02:47:40AM +0200, Andrea Arcangeli wrote:
> > Oh yeah, you save 1 microsecond every 10 years of uptime by taking
> > advantage of the potentially coalesced cacheline between the last page
> > in a node and the first page of the next node. Before you can care about
> > this optimizations you should remove from x86 the pgdat loops that are
> > not needed with discontigmem disabled like in x86 (this has nothing to
> > do with discontigmem/nonlinear). That wouldn't be measurable too but at
> > least it would be more worthwhile.
> 
> Which ones did you have in mind? I did poke around this area a bit, and

all of them, if you implement a mechanism to skip one of the pgdat
loops, you could skip them of all then.

> already have my eye on one...
> 
> 
> Cheers,
> Bill


Andrea
