Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSE1QWe>; Tue, 28 May 2002 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSE1QWd>; Tue, 28 May 2002 12:22:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2291 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316837AbSE1QWb>;
	Tue, 28 May 2002 12:22:31 -0400
Date: Tue, 28 May 2002 21:55:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020528215535.A22328@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020528171104.D19734@in.ibm.com> <20020528.042514.92633856.davem@redhat.com> <20020528182806.A21303@in.ibm.com> <1022600998.20317.44.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Tue, May 28, 2002 at 08:49:58AM -0700, Robert Love wrote:
> 
> > Well, the last time RCU was discussed, Linus said that he would
> > like to see someplace where RCU clearly helps.
> 
> I agree the numbers posted are nice, but I remain skeptical like Linus. 
> Sure, the locking overhead is nearly gone in the profiled function where
> RCU is used.  But the overhead has just been _moved_ to wherever the RCU
> work is now done.  Any benchmark needs to include the damage done there,
> too.

Have you looked at the rt_rcu patch ? Where do you think there
is overhead compared to what route cache alread does ? In my
profiles, rcu routines and kernel mechanisms that it uses
don't show high up. If you have any suggestions, then I can
do an investigation.

> 
> I also balk at implicit locking...
> 

I agree that it is better to keep things simple and RCU isn't a
replacement for locking. However the route cache hash table with
refcount is a relatively simpler use of RCU and since it has
benefits, we shouldn't shy away from using it if it is useful.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
