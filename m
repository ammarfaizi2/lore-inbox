Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTAVRZE>; Wed, 22 Jan 2003 12:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbTAVRZE>; Wed, 22 Jan 2003 12:25:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62660 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262201AbTAVRZD>; Wed, 22 Jan 2003 12:25:03 -0500
Date: Wed, 22 Jan 2003 18:34:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: test suite?
Message-ID: <20030122173405.GF1733@fs.tum.de>
References: <Pine.LNX.4.44.0301220840530.2622-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301220840530.2622-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 08:44:05AM -0500, Robert P. J. Day wrote:
> 
>   i've noticed references to "test suites" for kernels, but
> is there any one-step convenient way to select every possible
> option for test-compiling a new kernel, just to see if it builds?
> perhaps an "everything" option?
> 
>   and, related to that, should such a kernel theoretically
> work?  as in, are there any options that would be mutually
> exclusive that would cause such a build to fail?

It shouldn't be possible to select mutually exclusive options.


I'm using three .config's:

1. CONFIG_MODULES not set, everything else turned on
2. CONFIG_MODULES and CONFIG_HOTPLUG not set, everything else turned on
3. as much as possible modular

With 2.4.20 there are no compile errors with the first two and only two
errors at "depmod" with the third one (one of these two compile errors
is clearly pathological).

The bigger problem are unusual .config's, e.g. if you turn off common
things like CONFIG_PCI or CONFIG_NET.

Another example is that in 2.4.20 there's a problem with the compilation
of one specific net driver (fixed in 2.4.21-pre) if you select this
specific net driver and not additionally one or more of several other
net drivers.

Unfortunately there doesn't seem to be a good solution for this problem
that doesn't need O(n^2) .config's for n kernel options.


> still thinking about reorganizing the overall option structure,
> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

