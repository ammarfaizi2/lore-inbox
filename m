Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311453AbSCNA2s>; Wed, 13 Mar 2002 19:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311455AbSCNA1y>; Wed, 13 Mar 2002 19:27:54 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:41489 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S311457AbSCNA1G>; Wed, 13 Mar 2002 19:27:06 -0500
Message-ID: <3C8FEC76.F1411739@ixiacom.com>
Date: Wed, 13 Mar 2002 16:19:02 -0800
From: Dan Kegel <dkegel@ixiacom.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com, sam@zoy.org,
        Xavier Leroy <Xavier.Leroy@inria.fr>, linux-kernel@vger.kernel.org,
        babt@us.ibm.com
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem  
 (one li\ne)>
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> On Wed, 2002-03-13 at 15:17, Dan Kegel wrote:
> 
> > So let's break the logjam and fix glibc's linuxthreads' pthread_create
> > to [support profiling multithreaded programs]
> 
> I will add nothing like this.  The implementation is broken enough and
> any addition just makes it worse.  If you patch your own code you'll get
> what you want at your own risk.

OK.  What's the right way to fix this, then?

Here are a few alternate ideas off the top of my head:

* Rip out Linuxthreads, replace it with NGPT, and
start fixing from there?  (Or does NGPT already fix this?)

* Rewrite Linux's setitimer(ITIMER_PROF,...) to set up an 
interval timer for all threads of the thread group.

* Implement the profil() system call from Solaris
( http://ua1vm.ua.edu/cgi-bin/man-cgi?profil+2 )

What's your favorite idea for getting profiling of
multithreaded programs working on Linux?

Thanks,
Dan
