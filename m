Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314575AbSEBP3Q>; Thu, 2 May 2002 11:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314598AbSEBP3P>; Thu, 2 May 2002 11:29:15 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:1204 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314575AbSEBP3O>;
	Thu, 2 May 2002 11:29:14 -0400
Date: Fri, 3 May 2002 01:28:25 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502152825.GE10495@krispykreme>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <20020502030113.Q11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> is this machine a numa machine? If not then discontigmem will work just
> fine. also it's a matter of administration, even if it's a numa machine
> you can use it just optimally with discontigmem+numa. Regardless of what
> we do if the partitioning is bad the kernel will do bad. If you create
> zillon discontigous nodes of 256K each, you'd need waste memory to
> handle them regardless of nonlinear or discontigmem (with discontigmem
> you will waste more memory than nonlinear yes, exactly because it's more
> powerful, but I think a machine with an huge lot of non contigous 256K
> chunks is misconfigured, it's like if you pretend to install linux on a
> machine after you partitioned the HD with thousand of logical volumes
> large 256K each [for the sake of this example let's assume there are
> more than 256LV available in LVM], a sane partitioning requires you to
> have at least a partition for /usr large 1 giga, depends what you're
> doing of course, but requiring sane partitioning it's an admin problem
> not a kernel problem IMHO).

Its not a NUMA machine, its one that allows shared processor logical
partitions. While I would prefer the hypervisor to give each partition
a nice memory map (and internally maintain a mapping to real memory)
it does not. I can imagine if the machine has been up for many months
memory could become very fragmented.

Also when we do hotplug memory support will discontigmem be able to
efficiently handle memory turning up all over the place in the memory
map?

Anton
