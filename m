Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311195AbSCPXf5>; Sat, 16 Mar 2002 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311198AbSCPXfs>; Sat, 16 Mar 2002 18:35:48 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:22288 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S311195AbSCPXfi>;
	Sat, 16 Mar 2002 18:35:38 -0500
Date: Sat, 16 Mar 2002 16:34:58 -0700
From: yodaiken@fsmlabs.com
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: yodaiken@fsmlabs.com, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316163458.A25041@hq.fsmlabs.com>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel> <20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel> <p73g0301f79.fsf@oldwotan.suse.de> <20020316125711.B20436@hq.fsmlabs.com> <20020316210504.A24097@wotan.suse.de> <20020316131219.C20436@hq.fsmlabs.com> <200203162027.g2GKRqf13432@vindaloo.ras.ucalgary.ca> <20020316134732.C21439@hq.fsmlabs.com> <200203162105.g2GL5H914363@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200203162105.g2GL5H914363@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sat, Mar 16, 2002 at 02:05:17PM -0700
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 02:05:17PM -0700, Richard Gooch wrote:
> > Why not?  If you just ran vim on console you'd be more productive and
> > not need all those worthless processes. 
> 
> Yeah, right.

I was just trying to be nice.

> > At 4KB/page and 8bytes/pte a
> > 1G process will need at least 2MB of pte alone ! Add in the 4 layers,
> > the software VM struct, ...
> 
> This isn't a dedicated bigass-image display box. It's a workstation.
> It's where I read email, hack kernels, write visualisation tools and
> stuff like that.
> 
> And I can afford a few MiB of RAM for PTE's and such for *the one
> process which is mapping my huge data files*! That's effectively a
> small, one-time cost. Every other process doesn't have a significant
> PTE cost.

Well, it's a matter of target. I'm thinking about our customers who
do high grade image processing on a stream of gig+ bitmaps. They need
64 (some are already painfully stranded on Alphas) and they don't use these
boxes for email. 

> > But sure, big pages are not always good.
> 
> Hm. With wide TLB's, what are the benefits to big pages? One

tlb miss rates, mm structure overhead and setup/teardown, swap speed,

---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

