Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSIXNgT>; Tue, 24 Sep 2002 09:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261672AbSIXNgS>; Tue, 24 Sep 2002 09:36:18 -0400
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:14733 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S261669AbSIXNgS>;
	Tue, 24 Sep 2002 09:36:18 -0400
Date: Tue, 24 Sep 2002 15:40:18 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Michael Sinz <msinz@wgate.com>
cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       Peter Waechtler <pwaechtler@mac.com>, <linux-kernel@vger.kernel.org>,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <3D90547A.8070203@wgate.com>
Message-ID: <Pine.LNX.4.44.0209241537340.2383-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Michael Sinz wrote:

> The problem was very quickly noticed as other students quickly learned
> how to make use of such "solutions" to their performance wants.  We
> relatively quickly had to add process level accounting of thread CPU
> usage such that any thread in a process counted to that process's
> CPU usage/timeslice/etc.  It basically made the scheduler into a
> 2-stage device - much like user threads but with the kernel doing
> the work and all of the benefits of kernel threads.  (And did not
> require any code recompile other than those people who were doing
> the many-threads CPU hog type of thing ended up having to revert as
> it was now slower than the single thread-per-CPU code...)

Then you can just as well use fork(2) and split into processes with the 
same result. The solution is not thread specific, it is resource limits 
and/or per user cpu accounting. 

Several raytracers can (could?) split the workload into multiple 
processes, some being started on other computers over rsh or similar.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


