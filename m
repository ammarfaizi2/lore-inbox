Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281064AbRKPUUh>; Fri, 16 Nov 2001 15:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281538AbRKPUU1>; Fri, 16 Nov 2001 15:20:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64426 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281064AbRKPUUP>; Fri, 16 Nov 2001 15:20:15 -0500
Date: Fri, 16 Nov 2001 12:20:05 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Davide Libenzi <davidel@xmailserver.org>
Subject: Real Time Runqueue
Message-ID: <20011116122005.E1152@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you may know, a few of us are experimenting with multi-runqueue
scheduler implementations.  One area of concern is where to place
realtime tasks.  It has been my assumption, that POSIX RT semantics
require a specific ordering of tasks such as SCHED_FIFO and SCHED_RR.
To accommodate this ordering, I further believe that the simplest
solution is to ensure that all realtime tasks reside on the same
runqueue.  In our MQ scheduler we have a separate runqueue for all
realtime tasks.  The problem is that maintaining a separate realtime
runqueue is a pain and results in some fairly complex/ugly code.

Since I'm not a realtime expert, I would like to ask if my assumption
about strict ordering of RT tasks is accurate.  Also, is anyone aware
of other ways to approach this problem?

Thanks,
-- 
Mike
