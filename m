Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUCDTcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbUCDTcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:32:20 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:15238 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262106AbUCDTcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:32:13 -0500
Date: Thu, 04 Mar 2004 11:31:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Peter Zaitsev <peter@mysql.com>,
       riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <11020000.1078428705@flay>
In-Reply-To: <20040304181657.GS4922@dualathlon.random>
References: <20040303200704.17d81bda.akpm@osdl.org> <132310000.1078421713@flay> <20040304181657.GS4922@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Mar 04, 2004 at 09:35:13AM -0800, Martin J. Bligh wrote:
>> designed for bigboxen, so 4/4 vs 2/2 would be better, IMHO. People have
>> said before that DB performance can increase linearly with shared area
>> sizes (for some workloads), so that'd bring you a 100% or so increase
>> in performance for 4/4 to counter the loss.
> 
> that's a nice theory with the benchmarks that runs with a 64G working
> set, but if your working set is smaller than 32G  99% of the time and
> you install the 64G to handle the peak load happening 1% of the time
> faster, you'll run 30% slower 99% of the time even if the benchmark
> only stressing the 64G working set runs a lot faster than with 32G only.

The amount of ram in the system, and the amount consumed by mem_map can,
I think, be taken as static for the purposes of this argument. So I don't
see why the total working set of the machine matters.

What does matter is the per-process user address space set - if the same
argument applied to that (ie most of the time, processes only use 1GB
of shmem each), then I'd agree with you. I don't know whether that's
true or not though ... I'll let the DB people argue that one out. 

Much though people hate benchmarks, it's also important to be able to
prove that Linux can run as fast as RandomOtherOS in order to ensure
total world domination for Linux ;-) So it would be nice to ensure the
benchmarks at least have an option to be able to run as fast as possible.

M.

