Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316265AbSERCOH>; Fri, 17 May 2002 22:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSERCOG>; Fri, 17 May 2002 22:14:06 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:34321 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316265AbSERCOF>;
	Fri, 17 May 2002 22:14:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Sat, 18 May 2002 03:14:10 +0200."
             <20020518011410.GD29509@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 May 2002 12:13:51 +1000
Message-ID: <14957.1021688031@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002 03:14:10 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>
>you're right if we need a make clean it's because the buildsystem is
>broken. However one thing that happens all the time to me, is that I
>change an header like mm.h or sched.h and ~everything needs to be
>rebuilt then.

That is an orthogonal problem to kbuild 2.5.  The spaghetti that is the
include tree needs to be cleaned up, other people are working on that.

>Now the only regression I can
>see is that kbuild was quite slower in compiling the kernel from scrach
>(so I suspect that for me after editing mm.h it would take more time
>with kbuild2.5 to reach the vmlinux generation than it took with the old
>buildsystem after the make clean) Is that the case, or did you improved
>the performance of kbuild recently?

Since release 2.0 [1], kbuild 2.5 has been faster as well as more
accurate than the old build system.  A couple of people have complained
that some restricted operations are slower in kbuild 2.5 [2] but
overall it is faster, more accurate and provides more facilities,
especially for people building multiple kernels.

[1] http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-13/0771.html
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=102064198628442&w=2

