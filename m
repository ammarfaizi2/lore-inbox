Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310681AbSCPVjy>; Sat, 16 Mar 2002 16:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310721AbSCPVjo>; Sat, 16 Mar 2002 16:39:44 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:18190 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310681AbSCPVjk>;
	Sat, 16 Mar 2002 16:39:40 -0500
Date: Sat, 16 Mar 2002 14:39:16 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316143916.A23204@hq.fsmlabs.com>
In-Reply-To: <20020316131219.C20436@hq.fsmlabs.com> <Pine.LNX.4.33.0203161223290.31971-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0203161223290.31971-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 16, 2002 at 12:34:29PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:34:29PM -0800, Linus Torvalds wrote:
> 
> On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> > 
> > To me, once you have a G of memory, wasting a few meg on unused process 
> > memory seems no big deal.
> 
> It's not the process memory, and it is a whole lot than a "few meg" if 
> your page size is 2M.

I forget what an extremist you are. My claim is that
some processes benefit from big pages, some do not.
A 16G process needs 2^25 bytes of PTE at 4kbytes/page if I
did the numbers right. Just populating 4 million odd  page tables is a 
pain. I might be wrong about it, but I wonder if just scaling
up from a working 32 bit strategy gets you anywhere.
If you want to optimize for gnome, you get a very different
layout. But Hammer and ia64 are supposedly designed for huge
databases, routing tables, and images. Our good friends at Intel
claim "carrier grade" Linux  needs to run threaded apps
with 10,000 threads to depose Solaris in telecom - all sharing the
same monster address space. 

> Admit it, you're just wrong. 2M page sizes are _not_ useful for the common
> case, and won't be for years to come.

What's the "common case" for 64 bit ? Do you really think it will
be on desktop soon?

> 
> In short, youäre 

Don't use umlauts unless you are ready to back it up.


> 
> > They say:
> > 	Hammer microarchitecture features a flush filter allowing multiple
> > 	processes to share TLB without SW intervention.
> > 
> > Not a lot of technical detail in that.
> 
> I suspect it's some special case for windows with a special MSR that 
> enables something illegal that just works well for whatever patterns 
> windows does.

sounds like it from what Andi wrote. disappointing.

> 
> 		Linus

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

