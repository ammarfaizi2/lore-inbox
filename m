Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310371AbSCGPnI>; Thu, 7 Mar 2002 10:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310370AbSCGPm6>; Thu, 7 Mar 2002 10:42:58 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52145 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S310371AbSCGPmr>; Thu, 7 Mar 2002 10:42:47 -0500
Date: Thu, 7 Mar 2002 10:42:41 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: arjanv@redhat.com, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Message-ID: <20020307104241.D24040@devserv.devel.redhat.com>
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au> <3C8761FF.A10E50D9@redhat.com> <20020307153228.3A6773FE06@smtp.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020307153228.3A6773FE06@smtp.linux.ibm.com>; from frankeh@watson.ibm.com on Thu, Mar 07, 2002 at 10:33:32AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 10:33:32AM -0500, Hubertus Franke wrote:
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
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> I m not in favor of that. The dominant lock will be mutexes.

if there's no extra cost I don't care which is dominant; having one well
tested path is worth it then. If there is extra cost then yes a split is
better.
