Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311464AbSCNBRl>; Wed, 13 Mar 2002 20:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311466AbSCNBRb>; Wed, 13 Mar 2002 20:17:31 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:21256 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S311464AbSCNBRP>; Wed, 13 Mar 2002 20:17:15 -0500
Message-ID: <3C8FF822.D4F38B09@ixiacom.com>
Date: Wed, 13 Mar 2002 17:08:50 -0800
From: Dan Kegel <dkegel@ixiacom.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ulrich Drepper <drepper@redhat.com>, darkeye@tyrell.hu, libc-gnats@gnu.org,
        gnats-admin@cygnus.com, sam@zoy.org,
        Xavier Leroy <Xavier.Leroy@inria.fr>, linux-kernel@vger.kernel.org,
        babt@us.ibm.com
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
In-Reply-To: <E16lK2q-000811-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Here are a few alternate ideas off the top of my head:
> >
> > * Rip out Linuxthreads, replace it with NGPT, and
> > start fixing from there?  (Or does NGPT already fix this?)
> >
> > * Rewrite Linux's setitimer(ITIMER_PROF,...) to set up an
> > interval timer for all threads of the thread group.
> >
> > * Implement the profil() system call from Solaris
> > ( http://ua1vm.ua.edu/cgi-bin/man-cgi?profil+2 )
> >
> > What's your favorite idea for getting profiling of
> > multithreaded programs working on Linux?
> 
> Kernel support is not needed  for this, do it in user space. Or prove it
> has to be in kernel space

I'm all in favor of a userspace fix.  I suggested a patch
to glibc to fix this.  Ulrich rejected it; I'm trying
to coax out of him how he thinks profiling of multithreaded
programs on Linux should be fixed.

I hope we can all at least agree that
  cc foo.c -pg -pthread
  ./a.out
  gprof a.out
should work in Linux without any workarounds on the part of the programmer...

- Dan


- Dan
