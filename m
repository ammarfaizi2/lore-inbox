Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVGWWOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVGWWOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVGWWMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:12:15 -0400
Received: from cfa.harvard.edu ([131.142.10.1]:6363 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S261318AbVGWWJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:09:42 -0400
Date: Sat, 23 Jul 2005 18:09:37 -0400 (EDT)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel page size explanation
In-Reply-To: <9a87484905072118207a85970e@mail.gmail.com>
Message-ID: <Pine.SOL.4.58.0507231753210.945@titan.cfa.harvard.edu>
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
 <9a87484905072118207a85970e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jesper,

RE:
> > 2. how can one tune it (for 2.6.*)?
>
> For some archs the page size can be set at compile-time with
> CONFIG_PAGE_SIZE_4KB, CONFIG_PAGE_SIZE_8KB etc - mips is an example of
> such an arch (also take a look at CONFIG_HUGETLB_PAGE and friends).

OK, now i figured it out. On AMD opteron 64 bit processors the only
option is the default: 4Kb. For itanium and mips, indeed, there are
multiple options. My CPUs are opteron 64 bit ones; that is why i was
not able to find this feature (of tuning it).

> > How can i figure out the page size of the kernel i am currently using?
> >
> You can
>  A) look in the .config file for your current kernel (if your arch
> supports different page sizes at all).

Not there.

>  C) You can look at /proc/cpuinfo or /proc/meminfo , IIRC some archs
> report page size there - not quite sure, can't remember...

Probably not in meminfo, but possibly in cpuinfo:

cat /proc/cpuinfo
...
TLB size        : 1024 4K pages
...

cat /proc/meminfo
MemTotal:      4010956 kB
MemFree:       3848060 kB
Buffers:             0 kB
Cached:          45696 kB
SwapCached:          0 kB
Active:          90432 kB
Inactive:         4820 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      4010956 kB
LowFree:       3848060 kB
SwapTotal:     7823576 kB
SwapFree:      7823352 kB
Dirty:              20 kB
Writeback:           0 kB
Mapped:          78668 kB
Slab:            46216 kB
CommitLimit:   9829052 kB
Committed_AS:   142036 kB
PageTables:       3252 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      5724 kB
VmallocChunk: 34359732179 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

Cheers
Gaspar
