Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUDMHz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 03:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUDMHz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 03:55:57 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:18657 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262925AbUDMHzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 03:55:55 -0400
Date: Tue, 13 Apr 2004 00:55:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <2720000.1081842944@[10.10.2.4]>
In-Reply-To: <20040413005111.71c7716d.akpm@osdl.org>
References: <1130000.1081841981@[10.10.2.4]> <20040413005111.71c7716d.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Tuesday, April 13, 2004 00:51:11 -0700):

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
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

Look at the cpu percentage though. I presume it's blocked itself on disk IO.
Possibly because the space overhead of pte_chains causes more mem pressure.
 
> Average of five runs, please...

Maybe in the morning ;-). I mean ... a sensible time later this morning ;-)

M.

