Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUDNA0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUDNA0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:26:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59131 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263831AbUDNA0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:26:39 -0400
Date: Tue, 13 Apr 2004 17:38:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <120240000.1081903082@flay>
In-Reply-To: <20040413005111.71c7716d.akpm@osdl.org>
References: <1130000.1081841981@[10.10.2.4]> <20040413005111.71c7716d.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> UP Athlon 2100+ with 512Mb of RAM. Rebooted clean before each test
>> then did "make clean; make vmlinux; make clean". Then I timed a
>> "make -j 256 vmlinux" to get some testing under mem pressure. 
>> 
>> I was trying to test the overhead of objrmap under memory pressure,
>> but it seems it's actually distinctly negative overhead - rather pleasing
>> really ;-) 
>> 
>> 2.6.5
>> 225.18user 30.05system 6:33.72elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
>> 0inputs+0outputs (37590major+2604444minor)pagefaults 0swaps
>> 
>> 2.6.5-anon_mm
>> 224.53user 26.00system 5:29.08elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
>> 0inputs+0outputs (29127major+2577211minor)pagefaults 0swaps
> 
> A four second reduction in system time caused a one minute reduction in
> runtime?  Pull the other one ;)
> 
> Average of five runs, please...

You're right - it's rather variable. Still doesn't look bad though.

2.6.5
Average elapsed = 6:11
224.92user 30.15system 5:44.19elapsed 74%CPU (0avgtext+0avgdata 0maxresident)k
225.04user 30.23system 6:02.49elapsed 70%CPU (0avgtext+0avgdata 0maxresident)k
225.28user 29.60system 5:48.22elapsed 73%CPU (0avgtext+0avgdata 0maxresident)k
225.81user 31.75system 6:42.38elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
225.23user 30.20system 6:40.48elapsed 63%CPU (0avgtext+0avgdata 0maxresident)k

2.6.5-anon_mm
Average elapsed = 5:43
224.34user 25.43system 4:51.23elapsed 85%CPU (0avgtext+0avgdata 0maxresident)k
224.23user 25.93system 5:00.79elapsed 83%CPU (0avgtext+0avgdata 0maxresident)k
224.39user 26.36system 5:37.71elapsed 74%CPU (0avgtext+0avgdata 0maxresident)k
225.65user 27.13system 6:28.00elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
225.14user 27.26system 6:39.61elapsed 63%CPU (0avgtext+0avgdata 0maxresident)k

I've kicked off the -aa tree tests - will post them later tonight.

