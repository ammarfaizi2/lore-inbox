Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310597AbSCPUZv>; Sat, 16 Mar 2002 15:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310598AbSCPUZl>; Sat, 16 Mar 2002 15:25:41 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:39692 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310597AbSCPUZe>;
	Sat, 16 Mar 2002 15:25:34 -0500
Date: Sat, 16 Mar 2002 13:25:12 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316132512.B21439@hq.fsmlabs.com>
In-Reply-To: <20020316125329.A20436@hq.fsmlabs.com> <Pine.LNX.4.33.0203161158320.31971-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0203161158320.31971-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 16, 2002 at 12:02:59PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:02:59PM -0800, Linus Torvalds wrote:
> 
> On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> > On Sat, Mar 16, 2002 at 11:16:16AM -0800, Linus Torvalds wrote:
> > > Show me a semi-sane architecture that _matters_ from a commercial angle.
> > 
> > I thought we were into this for the pure technical thrill-)
> 
> I don't know about you, but to me the difference between technological
> thrill and masturbation is that real technology actually matters to real
> people.

Beyond me. Some kind of sophisticated California thing that us
poor folks in New Mexico can hardly imagine, I suppose. 

> 
> I'm not in it for some theoretical good. I want my code to make _sense_.
> 
> > > page tables. And I personally like how Hammer looks more than the ia64 VM 
> > > horror.
> > 
> > No kidding. But  I want TLB load instructions. 
> 
> TLB load instructions + hardware walking just do not make much sense if 
> you allow the loaded entries to be victimized.

If you have TLB load, you can sabotage hw walking and at least see whether
you can beat it. I think it could be done, because the OS could adapt to
the characteristics of the process - using perhaps on mm layout for 
kde applets and a different one for oracle ...


> Of course, you can have a separate "lock this TLB entry that I give you" 
> thing, which can be useful for real-time, and can also be useful for 
> having per-CPU data areas. 
> 
> But then you might as well consider that a BAT register ("block address 
> translation", ppc has those too), and separate from the TLB.

Bats are a good start. What I'd like is also a "small unpaged
process base/limit" set of registers or two.


---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

