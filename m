Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSE1Myj>; Tue, 28 May 2002 08:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314448AbSE1Myi>; Tue, 28 May 2002 08:54:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24252 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314446AbSE1Myi>; Tue, 28 May 2002 08:54:38 -0400
Date: Tue, 28 May 2002 18:28:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Paul McKenney <paul.mckenney@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020528182806.A21303@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020528171104.D19734@in.ibm.com> <20020528.042514.92633856.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 04:25:14AM -0700, David S. Miller wrote:
>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    Date: Tue, 28 May 2002 17:11:04 +0530
>    
>    Here are the results in terms of profile counts in
>    ip_route_output_key() - gc stands for neighbor table garbage
>    collection adjustment and u2000 stands for 2ms packet
>    rate delay. All measurements where done based on  2.5.3 kernel.
> 
> Thanks, I am convinced RCU is the way to go.
> 
> Once the generic RCU bits are in the 2.5.x tree, feel free to
> send me your ipv4 routing cache changes.

Well, the last time RCU was discussed, Linus said that he would
like to see someplace where RCU clearly helps.

Linus, would you consider this to be such a case and consider
including the rcu_poll patch from aa series of kernels ? It
has been a part of aa kernels for quite a while now. The latest
RCU patches support preemption and AFAICS, new module unloading
and cpu hotplug frameworks can use the RCU synchronize_kernel() 
interface.

Or atleast, we can perhaps discuss RCU and see if there are
potential issues that have not been disected so far.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
