Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273724AbRJIIpg>; Tue, 9 Oct 2001 04:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273729AbRJIIp0>; Tue, 9 Oct 2001 04:45:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35207 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273724AbRJIIpH>; Tue, 9 Oct 2001 04:45:07 -0400
Date: Tue, 9 Oct 2001 14:18:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: "Paul E. McKenney" <pmckenne@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011009141832.B10410@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com> <3BC2A3B3.3020004@wipro.com> <20011009131626.A10410@in.ibm.com> <3BC2B399.8030000@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BC2B399.8030000@wipro.com>; from balbir.singh@wipro.com on Tue, Oct 09, 2001 at 01:51:45PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 01:51:45PM +0530, BALBIR SINGH wrote:
> Dipankar Sarma wrote:
> 
> >Either you see the element or you don't. If you want to avoid duplication,
> >you could do a locked search before inserting it.
> >Like I said before, lock-less lookups are useful for read-mostly
> >data. Yes, updates are costly, but if they happen rarely, you still benefit.
> >
> How does this compare to the Read-Copy-Update mechanism? Is this just another way of implementing
> it, given different usage rules.

Fundamentally, yes, RCU is a method for lock-less lookup. It is just
that RCU is elaborate enough to allow you deletion and freeing of
data as well.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
