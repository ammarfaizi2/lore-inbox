Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSJWRrw>; Wed, 23 Oct 2002 13:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSJWRrw>; Wed, 23 Oct 2002 13:47:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7384 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265130AbSJWRrv>;
	Wed, 23 Oct 2002 13:47:51 -0400
To: Elladan <elladan@eskimo.com>
cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
       Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0 
In-reply-to: Your message of Tue, 22 Oct 2002 22:12:08 PDT.
             <20021023051208.GA1350@eskimo.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20719.1035395514.1@us.ibm.com>
Date: Wed, 23 Oct 2002 10:51:54 -0700
Message-Id: <E184Pfe-0005OF-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021023051208.GA1350@eskimo.com>, > : Elladan writes:
> gettimeofday() call frequency *can* be very high, but let's test it...

Oracle and possibly DB2 call gettimeofday to timestamp each potential
roll back transaction.  With a large machine, the number of calls to
gettimeofday() can be enormous, as well as one of the top few bottlenecks
for TPC-C style workloads (OLTP).

gerrit
