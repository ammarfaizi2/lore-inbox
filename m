Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310642AbSCPUsb>; Sat, 16 Mar 2002 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310646AbSCPUsY>; Sat, 16 Mar 2002 15:48:24 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:21261 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310642AbSCPUsR>;
	Sat, 16 Mar 2002 15:48:17 -0500
Date: Sat, 16 Mar 2002 13:47:32 -0700
From: yodaiken@fsmlabs.com
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: yodaiken@fsmlabs.com, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316134732.C21439@hq.fsmlabs.com>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel> <20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel> <p73g0301f79.fsf@oldwotan.suse.de> <20020316125711.B20436@hq.fsmlabs.com> <20020316210504.A24097@wotan.suse.de> <20020316131219.C20436@hq.fsmlabs.com> <200203162027.g2GKRqf13432@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200203162027.g2GKRqf13432@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sat, Mar 16, 2002 at 01:27:52PM -0700
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 01:27:52PM -0700, Richard Gooch wrote:
> yodaiken@fsmlabs.com writes:
> > On Sat, Mar 16, 2002 at 09:05:04PM +0100, Andi Kleen wrote:
> > > That will hopefully change eventually because 2M pages are a bit help for
> > > a lot of applications that are limited by TLB thrashing, but needs some 
> > > thinking on how to avoid the fragmentation trap (e.g. I'm considering
> > > to add a highmem zone again just for that and use rmap with targetted
> > > physical freeing to allocating them) 
> > 
> > To me, once you have a G of memory, wasting a few meg on unused
> > process memory seems no big deal.
> 
> I'm not happy to throw away 2 MiB per process. My workstation has 1
> GiB of RAM, and 65 processes (and that's fairly low compared to your
> average desktop these days, because I just use olwm and don't have a
> fancy desktop or lots of windows). You want me to throw over 1/8th of
> my RAM away?!?

Why not?  If you just ran vim on console you'd be more productive and
not need all those worthless processes. 

At 4KB/page and 8bytes/pte a
1G process will need at least 2MB of pte alone ! Add in the 4 layers,
the software VM struct, ...


> 
> And in fact, isn't it going to be more than 2 MiB wasted per process?
> For each shared object loaded, only partial pages are going to be
> used. *My* libc is less than 700 KiB, so I'd be wasting most of a page
> to map it in.

You're using a politically incorrect libc. 
But sure, big pages are not always good.


> I want that 1 GiB of RAM to be used to cache most of my data. Those
> NASA 1km/pixel satellite mosaics of the world are pretty big, you know
> (21600x21600x3 per hemisphere:-).


> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

