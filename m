Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291311AbSBGVCG>; Thu, 7 Feb 2002 16:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291308AbSBGVBg>; Thu, 7 Feb 2002 16:01:36 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:16391 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291307AbSBGVB2>;
	Thu, 7 Feb 2002 16:01:28 -0500
Date: Thu, 7 Feb 2002 14:00:56 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207140056.A23179@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013113285.11659.84.camel@phantasy> <20020207133602.C21935@hq.fsmlabs.com> <E16Yvbr-00015i-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16Yvbr-00015i-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Feb 07, 2002 at 09:57:35PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 09:57:35PM +0100, Daniel Phillips wrote:
> On February 7, 2002 09:36 pm, yodaiken@fsmlabs.com wrote:
> > > P.S. If this is going to turn into another priority-inheritance flame, I
> > > am stopping here.  Let's take it off-list or just drop it, please.  I'd
> > > much prefer to discuss the current combilock issue which is at hand. ;)
> > 
> > It's the same issue.
> 
> Not necessarily, look at Ingo's observation about replacing semaphores with 
> combi-locks as opposed to replacing spinlocks with combi-locks.

The underlying issue is an attempt to find a magic trick that will make
hard synchronization problems go away. The result is usually something that
makes hard synchronization problems more obscure. Ingo points to a case,
apparently triggered only by a wierd benchmark artefact where a queue of very
short term operations builds up a queue of expensive process reschedules. The
problem is that the same semaphore is used to for slow and fast operations
and the solution is to split them apart somehow or to conclude that its not
an important case. 

As Ingo points out, you need some actual positive results here, not a plausibility
argument.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

