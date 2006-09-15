Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWIOJqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWIOJqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWIOJqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:46:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13007 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750763AbWIOJqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:46:14 -0400
Message-ID: <450A7657.8030108@sgi.com>
Date: Fri, 15 Sep 2006 11:45:59 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC - Patch] Condense output of show_free_areas()
References: <yq0mz92efsd.fsf@jaguar.mkp.net> <20060914230837.e8c53801.akpm@osdl.org>
In-Reply-To: <20060914230837.e8c53801.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090001090600040703070702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090001090600040703070702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On 14 Sep 2006 09:30:58 -0400 Jes Sorensen <jes@sgi.com> wrote:
>> While this is a bigger problem on large NUMA systems, it is also
>> applicable to smaller desktop sized and mid range NUMA systems.
> 
> Could you please send us an example of the new output for review,
> and for me to include in the changelog?  Thanks.

Whoops, should have thought of that. Note the output is formatted for
80 columns, so it may look a little dodgy in 72 columns - attached it
instead.

Sorry it's a bit large, but needed to show the difference, but feel free
to clip out the middle CPUs or something. This is from a 4-node 8-cpu
box.

Cheers,
Jes


--------------090001090600040703070702
Content-Type: text/plain;
 name="format-compare.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="format-compare.txt"

Old format:

Mem-info:
Node 0 DMA per-cpu:
cpu 0 hot: high 42, batch 7 used:24
cpu 0 cold: high 14, batch 3 used:1
cpu 1 hot: high 42, batch 7 used:34
cpu 1 cold: high 14, batch 3 used:0
cpu 2 hot: high 42, batch 7 used:0
cpu 2 cold: high 14, batch 3 used:0
cpu 3 hot: high 42, batch 7 used:0
cpu 3 cold: high 14, batch 3 used:0
cpu 4 hot: high 42, batch 7 used:0
cpu 4 cold: high 14, batch 3 used:0
cpu 5 hot: high 42, batch 7 used:0
cpu 5 cold: high 14, batch 3 used:0
cpu 6 hot: high 42, batch 7 used:0
cpu 6 cold: high 14, batch 3 used:0
cpu 7 hot: high 42, batch 7 used:0
cpu 7 cold: high 14, batch 3 used:0
Node 0 DMA32 per-cpu: empty
Node 0 Normal per-cpu: empty
Node 0 HighMem per-cpu: empty
Node 1 DMA per-cpu:
[snip]
Free pages:     5410688kB (0kB HighMem)
Active:9536 inactive:4261 dirty:6 writeback:0 unstable:0 free:338168 slab:1931 mapped:1900 pagetables:208
Node 0 DMA free:1676304kB min:3264kB low:4080kB high:4896kB active:128048kB inactive:61568kB present:1970880kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 HighMem free:0kB min:512kB low:512kB high:512kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 1 DMA free:1951728kB min:3280kB low:4096kB high:4912kB active:5632kB inactive:1504kB present:1982464kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
....

New format:

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:   42, btch:   7 usd:  41   Cold: hi:   14, btch:   3 usd:   2
CPU    1: Hot: hi:   42, btch:   7 usd:  40   Cold: hi:   14, btch:   3 usd:   1
CPU    2: Hot: hi:   42, btch:   7 usd:   0   Cold: hi:   14, btch:   3 usd:   0
CPU    3: Hot: hi:   42, btch:   7 usd:   0   Cold: hi:   14, btch:   3 usd:   0
CPU    4: Hot: hi:   42, btch:   7 usd:   0   Cold: hi:   14, btch:   3 usd:   0
CPU    5: Hot: hi:   42, btch:   7 usd:   0   Cold: hi:   14, btch:   3 usd:   0
CPU    6: Hot: hi:   42, btch:   7 usd:   0   Cold: hi:   14, btch:   3 usd:   0
CPU    7: Hot: hi:   42, btch:   7 usd:   0   Cold: hi:   14, btch:   3 usd:   0
Node 1 DMA per-cpu:
[snip]
Free pages:     5411088kB (0kB HighMem)
Active:9558 inactive:4233 dirty:6 writeback:0 unstable:0 free:338193 slab:1942 mapped:1918 pagetables:208
Node 0 DMA free:1677648kB min:3264kB low:4080kB high:4896kB active:129296kB inactive:58864kB present:1970880kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 1 DMA free:1948448kB min:3280kB low:4096kB high:4912kB active:6864kB inactive:3536kB present:1982464kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0

--------------090001090600040703070702--
