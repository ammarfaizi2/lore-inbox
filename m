Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293647AbSCPBZh>; Fri, 15 Mar 2002 20:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293643AbSCPBZ2>; Fri, 15 Mar 2002 20:25:28 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18684
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293647AbSCPBZO>; Fri, 15 Mar 2002 20:25:14 -0500
Date: Fri, 15 Mar 2002 17:26:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Davidsen <davidsen@tmr.com>, Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020316012628.GC363@matchmail.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Bill Davidsen <davidsen@tmr.com>, Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020314133223.B19636@suse.de> <Pine.LNX.3.96.1020314104230.9248A-100000@gatekeeper.tmr.com> <20020314171259.I22054@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314171259.I22054@dualathlon.random>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 05:12:59PM +0100, Andrea Arcangeli wrote:
> On Thu, Mar 14, 2002 at 10:53:01AM -0500, Bill Davidsen wrote:
> > On Thu, 14 Mar 2002, Dave Jones wrote:
> > 
> > > On Thu, Mar 14, 2002 at 03:28:01AM +0100, Andrea Arcangeli wrote:
> > >  > Only in 2.4.19pre3aa2: 21_pte-highmem-f00f-1
> > >  > 
> > >  > 	vmalloc called before smp_init was an hack, right way
> > >  > 	is to use fixmap. CONFIG_M686 doesn't mean much these
> > >  > 	days, but it's ok and probably most vendors will use it
> > >  > 	for the smp kernels, so it will save 4096 of the vmalloc space.
> > >  > 	I just didn't wanted to clobber the code with || CONFIG_K7 ||
> > >  > 	CONFIG_... | ... given all the other f00f stuff is also
> > >  > 	conditional only to M686 and probably nobody bothered to compile
> > >  > 	it out for my same reason 
> > > 
> > >  Brian Gerst had a patch a few months back to introduce a CONFIG_F00F
> > >  if a relevant CONFIG_Mxxx was chosen[1]. It never got applied anywhere, but makes
> > >  more sense than the CONFIG_M686 we currently use. 
> > >  
> > > [1] 386/486/586. With addition of my Vendor choice menu, we could even further
> > >     narrow it down to Intel only.
> > 
> >   Since vendors (and consultants) like to build a single kernel for use on
> > multiple machines, it would be nice if this could be done by some init
> > code (released) and a module. I don't know what the overhead would be,
> > perhaps the runtime code is so small it's not worth doing. Does that mean
> 
> Correct. I think the CONFIG option isn't worthwhile in the first place
> and this is why I only left the CONFIG_M686 knowing most smp kernels are
> compiled that way.  4096bytes of virtual vmallc space and some houndred

Does that mean kernels compiled for 486 and smp won't be protected from F00F?
