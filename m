Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314456AbSEBOKI>; Thu, 2 May 2002 10:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSEBOKH>; Thu, 2 May 2002 10:10:07 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:13213 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314457AbSEBOJU>;
	Thu, 2 May 2002 10:09:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: discontiguous memory platforms
Date: Wed, 1 May 2002 16:08:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172umC-0001zd-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 16:00, Roman Zippel wrote:
> Hi,
> 
> On Wed, 1 May 2002, Daniel Phillips wrote:
> 
> > > Just to throw in an alternative: On m68k we map currently everything
> > > together into a single virtual area. This means the virtual<->physical
> > > conversion is a bit more expensive and mem_map is simply indexed by the
> > > the virtual address.
> > 
> > Are you talking about mm_ptov and friends here?  What are the loops for?
> 
> It simply searches through all memory nodes, it's not really efficient.
> 
> > Could you please describe the most extreme case of physical discontiguity
> > you're handling?
> 
> I can't assume anything. I'm thinking about calculating the table
> dynamically and patching the kernel at bootup, we are already doing
> something similiar in the Amiga/ppc kernel.

Maybe this is a good place to try out a hash table variant of
config_nonlinear.  It's got to be more efficient than searching all the
nodes, don't you think?

-- 
Daniel
