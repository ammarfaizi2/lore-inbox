Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314398AbSEBNV0>; Thu, 2 May 2002 09:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSEBNV0>; Thu, 2 May 2002 09:21:26 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:29084 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314398AbSEBNVZ>;
	Thu, 2 May 2002 09:21:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: discontiguous memory platforms
Date: Wed, 1 May 2002 15:21:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Ralf Baechle <ralf@uni-koblenz.de>, Russell King <rmk@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205021041570.23113-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172u39-0001wn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 10:50, Roman Zippel wrote:
> Hi,
> 
> On Thu, 2 May 2002, Andrea Arcangeli wrote:
> 
> > What I
> > care about is not to clobber the common code with additional overlapping
> > common code abstractions.
> 
> Just to throw in an alternative: On m68k we map currently everything
> together into a single virtual area. This means the virtual<->physical
> conversion is a bit more expensive and mem_map is simply indexed by the
> the virtual address.

Are you talking about mm_ptov and friends here?  What are the loops for?
Could you please describe the most extreme case of physical discontiguity
you're handling?

> It works nicely, it just needs two small patches in the initializition
> code, which aren't integrated yet. I think it's very close to what Daniel
> wants, only that the logical and virtual address are identical.

Yes, since logical and virtual kernel addresses in config_nonlinear differ
only by a constant (PAGE_OFFSET) then setting the constant to zero gives
me your case.

-- 
Daniel
