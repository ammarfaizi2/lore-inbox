Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291265AbSBGUQy>; Thu, 7 Feb 2002 15:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291271AbSBGUQs>; Thu, 7 Feb 2002 15:16:48 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:4 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291272AbSBGUQV>;
	Thu, 7 Feb 2002 15:16:21 -0500
Date: Thu, 7 Feb 2002 13:15:50 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: yodaiken@fsmlabs.com, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@transmet.com,
        mingo@elte.hu, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207131550.A21935@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy> <20020207125853.B21354@hq.fsmlabs.com> <1013112523.9534.75.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1013112523.9534.75.camel@phantasy>; from rml@tech9.net on Thu, Feb 07, 2002 at 03:08:02PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 03:08:02PM -0500, Robert Love wrote:
> On Thu, 2002-02-07 at 14:58, yodaiken@fsmlabs.com wrote:
> 
> > On Thu, Feb 07, 2002 at 01:40:59PM -0500, Robert Love wrote:
> > > We shouldn't engage in wholesale changing of spinlocks to semaphores
> > > without a priority-inheritance mechanism.  And _that_ is the bigger
> > > issue ...
> > 
> > Cool. We can then have the Solaris "this usually doesn't fail on test" priority
> > inherit read/write lock.  I can hardly wait.
> 
> Or, we could do things right and not.

I'd love to hear how things could be done right here. 
There seem to be 3 choices for reader writer locks
	1. Do the right thing and say no to inheritance: and this
	means no inheritance on mutexes either.
	2. Use the Solaris - "sometimes kinda works" method.
	3. Make readers/writer locks very slow and expensive e.g
	a complete list of reader identities that with atomic insert/delete
	and with check for uniqueness on insert! Not to mention the write
	promotion, any interactions between the "favor writes" design it should
	have and inheritance, links for a mutex inheriting lock to follow down
	the complete tree of paths from the r/w lock ...


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

