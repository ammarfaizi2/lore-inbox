Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310547AbSCPUFB>; Sat, 16 Mar 2002 15:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310579AbSCPUEw>; Sat, 16 Mar 2002 15:04:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34824 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310547AbSCPUEg>; Sat, 16 Mar 2002 15:04:36 -0500
Date: Sat, 16 Mar 2002 12:02:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316125329.A20436@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203161158320.31971-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> On Sat, Mar 16, 2002 at 11:16:16AM -0800, Linus Torvalds wrote:
> > Show me a semi-sane architecture that _matters_ from a commercial angle.
> 
> I thought we were into this for the pure technical thrill-)

I don't know about you, but to me the difference between technological
thrill and masturbation is that real technology actually matters to real
people.

I'm not in it for some theoretical good. I want my code to make _sense_.

> > page tables. And I personally like how Hammer looks more than the ia64 VM 
> > horror.
> 
> No kidding. But  I want TLB load instructions. 

TLB load instructions + hardware walking just do not make much sense if 
you allow the loaded entries to be victimized.

Of course, you can have a separate "lock this TLB entry that I give you" 
thing, which can be useful for real-time, and can also be useful for 
having per-CPU data areas. 

But then you might as well consider that a BAT register ("block address 
translation", ppc has those too), and separate from the TLB.

		Linus

