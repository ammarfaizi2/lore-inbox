Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSJYSvc>; Fri, 25 Oct 2002 14:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJYSvc>; Fri, 25 Oct 2002 14:51:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29419 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261549AbSJYSv3>;
	Fri, 25 Oct 2002 14:51:29 -0400
Message-ID: <3DB992B7.E8919930@us.ibm.com>
Date: Fri, 25 Oct 2002 11:51:35 -0700
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
		<3DB97C90.2DF810E6@us.ibm.com> <1035570043.5646.191.camel@plars>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> On Fri, 2002-10-25 at 12:17, mingming cao wrote:
> >
> > shmctl01    3  FAIL  :  # of attaches is incorrect - 0
> I guess you are running it with -i2?
No, I did not use -i2.

What I did is just run ./shmctl01

>  I just tried shmctl01 -i2 on a
> 2.5.44 kernel and did not get this error.
Sorry, Paul.  Could you try 2.5.44-mm4?  I saw the error on clean
2.5.44-mm4(without my patch). And I remember I saw this on 2.5.42-mm2
also. 

Here is what I saw:

[root@elm3b83 shmctl]# ./shmctl01
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    3  FAIL  :  # of attaches is incorrect - 0
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    4  PASS  :  new mode and change time are correct

[root@elm3b83 shmctl]# ./shmctl01 -i2
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    3  FAIL  :  # of attaches is incorrect - 0
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    4  PASS  :  new mode and change time are correct
shmctl01    1  BROK  :  couldn't create the shared memory segment
shmctl01    2  BROK  :  Remaining cases broken
shmctl01    3  BROK  :  Remaining cases broken
shmctl01    4  BROK  :  Remaining cases broken
