Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310635AbSCHBTT>; Thu, 7 Mar 2002 20:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310634AbSCHBTJ>; Thu, 7 Mar 2002 20:19:09 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:17156 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S310633AbSCHBS4>; Thu, 7 Mar 2002 20:18:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks 
In-Reply-To: Your message of "Thu, 07 Mar 2002 10:33:32 CDT."
             <20020307153228.3A6773FE06@smtp.linux.ibm.com> 
Date: Fri, 08 Mar 2002 12:22:14 +1100
Message-Id: <E16j95K-00047G-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020307153228.3A6773FE06@smtp.linux.ibm.com> you write:
> On Thursday 07 March 2002 07:50 am, Arjan van de Ven wrote:
> > Rusty Russell wrote:
> > > This is a userspace implementation of rwlocks on top of futexes.
> >
> > question: if rwlocks aren't actually slower in the fast path than
> > futexes,
> > would it make sense to only do the rw variant and in some userspace
> > layer
> > map "traditional" semaphores to write locks ?
> > Saves half the implementation and testing....
> 
> I m not in favor of that. The dominant lock will be mutexes.

To clarify: I'd love this, but rwlocks in the kernel aren't even
vaguely fair.  With a steady stream of overlapping readers, a writer
will never get the lock.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
