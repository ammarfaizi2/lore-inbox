Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289726AbSAJV6i>; Thu, 10 Jan 2002 16:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289724AbSAJV6Z>; Thu, 10 Jan 2002 16:58:25 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:49028 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289722AbSAJV6H>; Thu, 10 Jan 2002 16:58:07 -0500
Date: Thu, 10 Jan 2002 13:57:58 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
Message-ID: <20020110135758.C15171@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0201101457390.4885-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201101457390.4885-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Jan 10, 2002 at 03:19:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I run 3 cpu-hog tasks on a 2 CPU system, then 1 task will get an
entire CPU while the other 2 tasks share the other CPU (easily verified
by a simple test program).  On previous versions of the scheduler
'balancing' this load was achieved by the global nature of time slices.
No task was given a new time slice until the time slices of all runnable
tasks had expired.  In the current scheduler, the decision to replenish
time slices is made at a local (pre-CPU) level.  I assume the load
balancing code should take care of the above workload?  OR is this the
behavior we desire?  We certainly have optimal cache use.

-- 
Mike
