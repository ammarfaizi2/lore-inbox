Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293390AbSCOWFF>; Fri, 15 Mar 2002 17:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293381AbSCOWEz>; Fri, 15 Mar 2002 17:04:55 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:33299 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S293373AbSCOWEo>; Fri, 15 Mar 2002 17:04:44 -0500
Message-ID: <3C926E0B.1A0EE311@ixiacom.com>
Date: Fri, 15 Mar 2002 13:56:27 -0800
From: Dan Kegel <dank@ixiacom.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Dan Kegel <dkegel@ixiacom.com>, Ulrich Drepper <drepper@redhat.com>,
        darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com,
        sam@zoy.org, Xavier Leroy <Xavier.Leroy@inria.fr>,
        linux-kernel@vger.kernel.org, babt@us.ibm.com
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem 
 (one li\ne)>
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet> <3C8FEC76.F1411739@ixiacom.com> <20020314020834.Z2434@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> 
> On Wed, Mar 13, 2002 at 04:19:02PM -0800, Dan Kegel wrote:
> > Ulrich Drepper wrote:
> > >
> > > On Wed, 2002-03-13 at 15:17, Dan Kegel wrote:
> > >
> > > > So let's break the logjam and fix glibc's linuxthreads' pthread_create
> > > > to [support profiling multithreaded programs]
> > >
> > > I will add nothing like this.  The implementation is broken enough and
> > > any addition just makes it worse.  If you patch your own code you'll get
> > > what you want at your own risk.
> >
> > OK.  What's the right way to fix this, then?
> 
> Surely don't use timer for profiling.
> Have the compiler generate profiling calls both at function entry and exit
> and use rdtsc/whatever other register your machine has (or even better
> profiling registers) to note time of that function being entered/left.

That's a different style of profiling.  There is a fellow
working on that (see http://sourceforge.net/projects/fnccheck )
but there's value in the gprof-style of profiling as well.
(For instance, I suspect it's lower overhead.)

I think it's reasonable for us to get gprof working; it's
a useful part of classic Unix, and the fix looks easy.

Ulrich, do you at least agree that it would be desirable for
gprof to work properly on multithreaded programs?

- Dan
