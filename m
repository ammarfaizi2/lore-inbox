Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSEQNsD>; Fri, 17 May 2002 09:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316222AbSEQNsB>; Fri, 17 May 2002 09:48:01 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:61639 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316221AbSEQNsA>; Fri, 17 May 2002 09:48:00 -0400
Date: Fri, 17 May 2002 19:21:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: 16-CPU #s for lockfree rtcache (rt_rcu)
Message-ID: <20020517192116.G12631@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, here is the kernprof data from the simulated
test suggested by Dave. The test uses 32 processes and dest
addresses for rtcache lookup are random, changing after every 5 packets.
The measurements were done in a 16 CPU NUMA-Q.

2.5.3 : ip_route_output_key [c01bab8c]: 12166
2.5.3+rt_rcu : ip_route_output_key [c01bb084]: 6027

I have seen moderately significant profile counts
for ip_route_input() in preliminary webserver benchmark runs.
It is not however clear to me that bucket lock cache line
bouncing is the reason behind it. That one needs more investigation.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
