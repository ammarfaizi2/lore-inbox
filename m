Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSJYSYD>; Fri, 25 Oct 2002 14:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSJYSYD>; Fri, 25 Oct 2002 14:24:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44698 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261524AbSJYSYD>;
	Fri, 25 Oct 2002 14:24:03 -0400
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch
From: Paul Larson <plars@linuxtestproject.org>
To: cmm@us.ibm.com
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       manfred@colorfullife.com, lkml <linux-kernel@vger.kernel.org>,
       dipankar@in.ibm.com, lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <3DB97C90.2DF810E6@us.ibm.com>
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>
	<3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com> 
	<3DB880E8.747C7EEC@us.ibm.com> <1035555715.3447.150.camel@plars> 
	<3DB97C90.2DF810E6@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Oct 2002 13:20:42 -0500
Message-Id: <1035570043.5646.191.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 12:17, mingming cao wrote:
>
> shmctl01    3  FAIL  :  # of attaches is incorrect - 0
I guess you are running it with -i2?  I just tried shmctl01 -i2 on a
2.5.44 kernel and did not get this error.
shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
pass #1 shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
pass #2
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    0  INFO  :  shmdt() failed - 22
shmctl01    3  PASS  :  new mode and change time are correct
shmctl01    4  PASS  :  shared memory appears to be removed
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
shmctl01    3  PASS  :  new mode and change time are correct
shmctl01    4  PASS  :  shared memory appears to be removed

If I can find some time, I'll try to grab your patch and see if I can
reproduce the error on my machine.

-Paul Larson

