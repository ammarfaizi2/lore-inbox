Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSJYTK2>; Fri, 25 Oct 2002 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261563AbSJYTK2>; Fri, 25 Oct 2002 15:10:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:65236 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261561AbSJYTKZ>;
	Fri, 25 Oct 2002 15:10:25 -0400
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch
From: Paul Larson <plars@linuxtestproject.org>
To: cmm@us.ibm.com
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       manfred@colorfullife.com, lkml <linux-kernel@vger.kernel.org>,
       dipankar@in.ibm.com, lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <3DB992B7.E8919930@us.ibm.com>
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>
	<3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com> 
	<3DB880E8.747C7EEC@us.ibm.com> <1035555715.3447.150.camel@plars> 
	<3DB97C90.2DF810E6@us.ibm.com> <1035570043.5646.191.camel@plars> 
	<3DB992B7.E8919930@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Oct 2002 14:06:59 -0500
Message-Id: <1035572820.5646.211.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 13:51, mingming cao wrote:
> Paul Larson wrote:
> > 
> > On Fri, 2002-10-25 at 12:17, mingming cao wrote:
> > >
> > > shmctl01    3  FAIL  :  # of attaches is incorrect - 0
> > I guess you are running it with -i2?
> No, I did not use -i2.
Maybe I just read it wrong.

> What I did is just run ./shmctl01
> 
> >  I just tried shmctl01 -i2 on a
> > 2.5.44 kernel and did not get this error.
> Sorry, Paul.  Could you try 2.5.44-mm4?  I saw the error on clean
> 2.5.44-mm4(without my patch). And I remember I saw this on 2.5.42-mm2
> also. 
> 
> Here is what I saw:
I still have my results from testing 2.5.44-mm4, here's a cut and paste
from shmctl01:

<<<test_start>>>
tag=shmctl01 stime=1035486589
cmdline="shmctl01"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    3  PASS  :  new mode and change time are correct
shmctl01    4  PASS  :  shared memory appears to be removed
<<<execution_status>>>
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>

I havn't seen this test fail before but I'll be happy to do more testing
with your patch to see if I can reproduce it.  You may also want to
consider updating LTP to the newest version.  I'm fairly certain that
shmctl01 hasn't been changed since the version you have, but just to be
consistent you may want to do that.

Thanks,
Paul Larson

