Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314723AbSECQ5O>; Fri, 3 May 2002 12:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314776AbSECQ5N>; Fri, 3 May 2002 12:57:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27932 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314723AbSECQ5M>; Fri, 3 May 2002 12:57:12 -0400
Date: Fri, 3 May 2002 18:58:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020503185806.A1396@dualathlon.random>
In-Reply-To: <20020503103813.K11414@dualathlon.random> <E173fVi-0002Ic-00@starship> <20020503182028.C14505@dualathlon.random> <E173g7P-0002J6-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 06:41:15PM +0200, Daniel Phillips wrote:
> On Friday 03 May 2002 18:20, Andrea Arcangeli wrote:
> > On Fri, May 03, 2002 at 06:02:18PM +0200, Daniel Phillips wrote:
> > > and solves 75% of the problem.  It's not just ia32 numa that will benefit
> > > from it.  For example, MIPS supports 16K pages in software, which will
> > 
> > the whole change would be specific to ia32, I don't see the connection
> > with mips. There would be nothing to share between ia32 2M pages and
> > mips 16K pages.
> 
> The topic here is 'page clustering'.  The idea is to use one struct page for
> every four 4K page frames on ia32.

ah ok, I meant physical hardware pages. physical hardware pages should
be doable without common code changes, a software PAGE_SIZE or the
PAGE_CACHE_SIZE raises non trivial problems instead.

Andrea
