Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSJYRQr>; Fri, 25 Oct 2002 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSJYRQq>; Fri, 25 Oct 2002 13:16:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20192 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261499AbSJYRQp>; Fri, 25 Oct 2002 13:16:45 -0400
Message-ID: <3DB97C90.2DF810E6@us.ibm.com>
Date: Fri, 25 Oct 2002 10:17:04 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       manfred@colorfullife.com, lkml <linux-kernel@vger.kernel.org>,
       dipankar@in.ibm.com, lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>
		<3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com> 
		<3DB880E8.747C7EEC@us.ibm.com> <1035555715.3447.150.camel@plars>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> On Thu, 2002-10-24 at 18:23, mingming cao wrote:
> > Thanks for your quick feedback.  I did LTP tests on it--it passed(well,
> > I saw a failure on shmctl(), but the failure was there since 2.5.43
> > kernel).  I will do more stress tests on it soon.
> Which shmctl() test is this?  To my knowledge, there are no current
> known issues with shmctl tests.  There is however one with sem02 in
> semctl() that last I heard has been partially fixed in the kernel and
> still needs to be fixed in glibc.  Is that the one you are referring to,
> or is there really some other shmctl test in LTP that is failing?

Here is the failure I saw on LTP test.  The one failed is 
/ltp-20020807/testcases/kernel/syscalls/ipc/shmctl/shmctl01

<<<test_start>>>
tag=shmctl01 stime=1035475025
cmdline="shmctl01"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
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
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    3  FAIL  :  # of attaches is incorrect - 0
shmctl01    4  PASS  :  new mode and change time are correct
<<<execution_status>>>
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
