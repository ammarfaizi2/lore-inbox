Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310850AbSCNHJL>; Thu, 14 Mar 2002 02:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSCNHJB>; Thu, 14 Mar 2002 02:09:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3483 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S310850AbSCNHIx>; Thu, 14 Mar 2002 02:08:53 -0500
Date: Thu, 14 Mar 2002 02:08:34 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Dan Kegel <dkegel@ixiacom.com>
Cc: Ulrich Drepper <drepper@redhat.com>, darkeye@tyrell.hu, libc-gnats@gnu.org,
        gnats-admin@cygnus.com, sam@zoy.org,
        Xavier Leroy <Xavier.Leroy@inria.fr>, linux-kernel@vger.kernel.org,
        babt@us.ibm.com
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem (one li\ne)>
Message-ID: <20020314020834.Z2434@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet> <3C8FEC76.F1411739@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C8FEC76.F1411739@ixiacom.com>; from dkegel@ixiacom.com on Wed, Mar 13, 2002 at 04:19:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 04:19:02PM -0800, Dan Kegel wrote:
> Ulrich Drepper wrote:
> > 
> > On Wed, 2002-03-13 at 15:17, Dan Kegel wrote:
> > 
> > > So let's break the logjam and fix glibc's linuxthreads' pthread_create
> > > to [support profiling multithreaded programs]
> > 
> > I will add nothing like this.  The implementation is broken enough and
> > any addition just makes it worse.  If you patch your own code you'll get
> > what you want at your own risk.
> 
> OK.  What's the right way to fix this, then?

Surely don't use timer for profiling.
Have the compiler generate profiling calls both at function entry and exit
and use rdtsc/whatever other register your machine has (or even better
profiling registers) to note time of that function being entered/left.

	Jakub
