Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310437AbSCGSP7>; Thu, 7 Mar 2002 13:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSCGSPj>; Thu, 7 Mar 2002 13:15:39 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:42766 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287817AbSCGSP3>;
	Thu, 7 Mar 2002 13:15:29 -0500
Date: Thu, 7 Mar 2002 11:15:35 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020307111535.B32294@hq.fsmlabs.com>
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu> <E16izrK-00038v-00@starship.berlin> <20020307095046.A29364@hq.fsmlabs.com> <E16j2IV-0003B6-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16j2IV-0003B6-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Mar 07, 2002 at 07:07:23PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 07:07:23PM +0100, Daniel Phillips wrote:
> > Really? I thought LRUs were to approximate working sets. Obviously
> > if a program is kmallocing its working set is changing but that
> > does not tell us anything about whether it is a correct decision to
> > rip a page from the working set of another process.
> 
> We're getting way far from the original question here.  Our lru has no
> concept of working set, it's completely global.  That's not so great and
> it's another problem to tackle.  Sometime.

Global lru is an approximation of per-task working set. That's why it
works. But it's not perfect.

> 
> > > You won't find one if you don't look for it.
> > 
> > I'm too dumb to come up with a solution here, but you are the one
> > changing the interface, so surely you have a couple of "less borked"
> > solutions in mind - right?
> 
> Yes.  Well, I'm not alone here, ping Marcelo on that if you like.  This is
> known borkness that's been deferred while more pressing borkness is dealt
> with.

So you and Marcelo are planning on making changes to the semantics
of primitive memory allocation modules in the production kernel?

Can that be true? I hope not.



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

