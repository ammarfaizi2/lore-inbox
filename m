Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311465AbSCNBOL>; Wed, 13 Mar 2002 20:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311464AbSCNBOB>; Wed, 13 Mar 2002 20:14:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2314 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311465AbSCNBNx>; Wed, 13 Mar 2002 20:13:53 -0500
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
To: dkegel@ixiacom.com (Dan Kegel)
Date: Thu, 14 Mar 2002 01:28:40 +0000 (GMT)
Cc: drepper@redhat.com (Ulrich Drepper), darkeye@tyrell.hu, libc-gnats@gnu.org,
        gnats-admin@cygnus.com, sam@zoy.org,
        Xavier.Leroy@inria.fr (Xavier Leroy), linux-kernel@vger.kernel.org,
        babt@us.ibm.com
In-Reply-To: <3C8FEC76.F1411739@ixiacom.com> from "Dan Kegel" at Mar 13, 2002 04:19:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lK2q-000811-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are a few alternate ideas off the top of my head:
> 
> * Rip out Linuxthreads, replace it with NGPT, and
> start fixing from there?  (Or does NGPT already fix this?)
> 
> * Rewrite Linux's setitimer(ITIMER_PROF,...) to set up an 
> interval timer for all threads of the thread group.
> 
> * Implement the profil() system call from Solaris
> ( http://ua1vm.ua.edu/cgi-bin/man-cgi?profil+2 )
> 
> What's your favorite idea for getting profiling of
> multithreaded programs working on Linux?

Kernel support is not needed  for this, do it in user space. Or prove it
has to be in kernel space
