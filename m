Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSIOLIc>; Sun, 15 Sep 2002 07:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSIOLIc>; Sun, 15 Sep 2002 07:08:32 -0400
Received: from ns.suse.de ([213.95.15.193]:46094 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318014AbSIOLIb>;
	Sun, 15 Sep 2002 07:08:31 -0400
Date: Sun, 15 Sep 2002 13:13:24 +0200
From: Andi Kleen <ak@suse.de>
To: Stephen Lord <lord@sgi.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Samuel Flory <sflory@rackable.com>,
       Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020915131324.A13516@wotan.suse.de>
References: <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com> <20020913125345.GO11605@dualathlon.random> <3D825422.8000007@rackable.com> <20020913211844.GP11605@dualathlon.random> <1032014367.1050.2.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032014367.1050.2.camel@laptop.americas.sgi.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2002 at 09:39:24AM -0500, Steve Lord wrote:
> On Fri, 2002-09-13 at 16:18, Andrea Arcangeli wrote:
> 
> > So, returning to xfs, it is possible dbench really generates lots of
> > simultaneous vmaps because of its concurrency, so I would suggest to add
> > an atomic counter increased at every vmap/vmalloc and decreased at every
> > vfree and to check it after every increase storing the max value in a
> > sysctl, to see what's the max concurrency you reach with the vmaps. (you
> > can also export the counter via the sysctl, to verify for no memleaks
> > after unmounting xfs)
> > 
> > Andrea
> 
> There are no vmaps during normal operation on xfs unless you are
> setting extended attributes of more than 4K in size, or you
> used some more obscure mkfs options. Only filesystem recovery will
> use it otherwise. 

Perhaps the original poster used those obscure mkfs options? What option
will trigger huge allocations ? 


-Andi
