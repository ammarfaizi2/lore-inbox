Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265363AbSJXJXK>; Thu, 24 Oct 2002 05:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265364AbSJXJXK>; Thu, 24 Oct 2002 05:23:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:20885 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265363AbSJXJXI>; Thu, 24 Oct 2002 05:23:08 -0400
Date: Thu, 24 Oct 2002 15:05:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
Message-ID: <20021024150516.C11418@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3DB7A581.9214EFCC@aitel.hist.no> <3DB7A80C.7D13C750@digeo.com> <3DB7AC97.D31A3CB2@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB7AC97.D31A3CB2@digeo.com>; from akpm@digeo.com on Thu, Oct 24, 2002 at 08:22:07AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 08:22:07AM +0000, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > Hopefully the rcu fix in -mm4 will cure this.
> 
> Oh.  It was in -mm3 too.  But something went wrong with the
> dcache shrinking there.

Hmm.. the thing to do here would be to look at cat /proc/sys/fs/dentry-state.
The number of dentries in the system should tally with dentry slab,
if it doesn't it might be an RCU issue in which case I would like to
look at /proc/rcu. If not, then we need to do some more digging.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
