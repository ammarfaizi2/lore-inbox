Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262839AbTCKFi6>; Tue, 11 Mar 2003 00:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTCKFi6>; Tue, 11 Mar 2003 00:38:58 -0500
Received: from holomorphy.com ([66.224.33.161]:33976 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262839AbTCKFi4>;
	Tue, 11 Mar 2003 00:38:56 -0500
Date: Mon, 10 Mar 2003 21:48:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.5.64-[345]
Message-ID: <20030311054826.GF20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030311051511.GM465@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311051511.GM465@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 09:15:11PM -0800, William Lee Irwin III wrote:
> pgcl-2.5.64-3:
[..]
> pgcl-2.5.64-4:
[..]
> pgcl-2.5.64-5:
[..]

>From a 32x/48GB NUMA-Q running pgcl:

AIM7 multitasking w/10000 tasks:
--------------------------------

slabinfo:
---------
pae_pmd                    136400K        137728K      99.04%
size-8192                   96192K         96672K      99.50%
pte_chain                   29127K         29741K      97.94%
task_struct                 18525K         18650K      99.33%
proc_inode_cache            15378K         15655K      98.23%
sighand_cache               15423K         15559K      99.13%
dentry_cache                12253K         12313K      99.52%
names_cache                  5400K         11552K      46.75%
vm_area_struct              10655K         10732K      99.29%
buffer_head                  8084K          8629K      93.67%
files_cache                  5502K          5544K      99.24%
mm_struct                    5158K          5192K      99.34%
size-1024                    2563K          2666K      96.14%
ext2_inode_cache             2236K          2386K      93.70%
size-32768                   2176K          2208K      98.55%
filp                         1263K          1461K      86.43%
size-2048                    1110K          1320K      84.09%
size-4096                     700K           992K      70.56%
signal_cache                  877K           901K      97.34%
fs_cache                      861K           871K      98.80%
biovec-BIO_MAX_PAGES          768K           780K      98.46%
radix_tree_node               687K           749K      91.77%
size-64                       673K           721K      93.41%


meminfo:
--------
MemTotal:     49205952 kB
MemFree:      40632224 kB
Buffers:         97024 kB
Cached:         538144 kB
SwapCached:          0 kB
Active:        6395360 kB
Inactive:       528576 kB
HighTotal:    48429056 kB
HighFree:     40409152 kB
LowTotal:       776896 kB
LowFree:        223072 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:          141312 kB
Writeback:       26016 kB
Mapped:        6304768 kB
Slab:           399840 kB
Committed_AS:  6537460 kB
PageTables:    1071296 kB
ReverseMaps:   2883351
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB


64 simultaneous kernel compiles (-j4) on ramfs (not hardlinked):
----------------------------------------------------------------

slabtop:
--------
inode_cache                357972K        358029K      99.98%
dentry_cache               165646K        168839K      98.11%
radix_tree_node             18421K         18644K      98.80%
buffer_head                  1512K         12752K      11.86%
size-8192                   11352K         12000K      94.60%
pae_pmd                      7644K          7968K      95.93%
pte_chain                     993K          4516K      22.00%
names_cache                  3220K          3552K      90.65%
proc_inode_cache             1982K          2362K      83.92%
task_struct                  2038K          2327K      87.57%
filp                         2110K          2300K      91.71%
mm_struct                    1014K          2158K      47.02%
size-1024                    1928K          2077K      92.83%
sighand_cache                1556K          1660K      93.75%
vm_area_struct                479K          1593K      30.06%
ext2_inode_cache             1302K          1350K      96.46%
size-2048                     934K          1290K      72.40%
files_cache                  1013K          1071K      94.61%
size-256                      781K           781K     100.00%
biovec-BIO_MAX_PAGES          768K           780K      98.46%
size-64                       310K           721K      43.10%
sigqueue                      572K           587K      97.46%
size-512                      502K           535K      93.84%

meminfo:
--------
MemTotal:     49205952 kB
MemFree:      14493312 kB
Buffers:         83936 kB
Cached:       33435808 kB
SwapCached:          0 kB
Active:         765408 kB
Inactive:     33147104 kB
HighTotal:    48429056 kB
HighFree:     14459264 kB
LowTotal:       776896 kB
LowFree:         34048 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             160 kB
Writeback:           0 kB
Mapped:         414688 kB
Slab:           627424 kB
Committed_AS:   114544 kB
PageTables:      26016 kB
ReverseMaps:     71447
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

Now to clean things up so tinyboxen run smooth and tweak performance.
The antifragmentation bits are a wee bit of work, but no worries; this
part can be brought over largely directly from hugh's 2.4.x bits. The
real 2.5-specific challenges (highpte, rmap) are in different areas.


-- wli
