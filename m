Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTA1HFN>; Tue, 28 Jan 2003 02:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTA1HFN>; Tue, 28 Jan 2003 02:05:13 -0500
Received: from holomorphy.com ([66.224.33.161]:27048 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263544AbTA1HFM>;
	Tue, 28 Jan 2003 02:05:12 -0500
Date: Mon, 27 Jan 2003 23:13:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
Message-ID: <20030128071313.GH780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <3.0.6.32.20030127224726.00806c20@boo.net> <884740000.1043737132@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884740000.1043737132@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Jason P. wrote:
>> This is yet another holding action, a port of my page coloring patch
>> to the 2.5 kernel. This is a minimal port (x86 only) intended to get
>> some testing done; once again the algorithm used is the same as in 
>> previous patches. There are several cleanups and removed 2.4-isms that
>> make the code somewhat more compact, though.
>> I'll be experimenting with other coloring schemes later this week.
>> www.boo.net/~jasonp/page_color-2.5.59-20030127.patch
>> Feedback of any sort welcome.

On Mon, Jan 27, 2003 at 10:58:53PM -0800, Martin J. Bligh wrote:
> I took a 16-way NUMA-Q (700MHz P3 Xeon's w/2MB L2 cache) and ran some 
> cpu-intensive benchmarks (kernel compile on warm cache with -j32 and
> -j 256, SDET 1 - 128 users, and numaschedbench with 1 to 64 processes, 
> which is a memory thrasher to test node affinity of memory operations), 
> and compared to virgin 2.5.59 - no measurable difference on any test. 

I think this one really needs to be done with the userspace cache
thrashing microbenchmarks. I also have rather serious reservations
about the interaction of the qlists with the per-cpu lists.


-- wli
