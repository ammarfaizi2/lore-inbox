Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129341AbRBURoX>; Wed, 21 Feb 2001 12:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbRBURoN>; Wed, 21 Feb 2001 12:44:13 -0500
Received: from cosmos.ccrs.nrcan.gc.ca ([132.156.47.32]:27872 "EHLO
	cosmos.CCRS.NRCan.gc.ca") by vger.kernel.org with ESMTP
	id <S129245AbRBURn5>; Wed, 21 Feb 2001 12:43:57 -0500
Message-ID: <2951561DB3DDD0118FEC00805FFE98050435E154@s5-ccr-r1>
From: "Desjardins, Kristian" <Kristian.Desjardins@CCRS.NRCan.gc.ca>
To: "'Tigran Aivazian'" <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 128MB lost... where ?
Date: Wed, 21 Feb 2001 12:43:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 21 Feb 2001, Tigran Aivazian wrote:
> 
> > 
> > when you compile your 2.4.x kernel make sure you set the "4G of RAM"
> > option, i.e. CONFIG_HIGHMEM4G. If you chose "up to 1G" then 
> it means "up
> > to 986M" (or something like that) -- the number in Help is 
> just rounded up
>      ~~~
> 
> not 986M but (unsigned 
> long)(-PAGE_OFFSET-VMALLOC_RESERVE)>>20 MB which is
> around 876M or so.
> 

I also have a question about RAM. I am running 2.4.2pre4 on Dell Poweredge
6400 with 6.4GB of RAM (12x512MB + 4x64MB). With 4GB support free reports
3597324 total, and with 64GB support it reports about ~5.9GB.  I also have
another problem, when using 64GB large_mem support, the system will
sometimes oops (I haven't captured one yet) or completely hang when I run
out of physical memory. Swap does not even get touched (8GB swap, 4 x 2GB,
why can I only use 2GB swap partitions?)

/proc/meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  3683659776 510230528 3173429248        0  1044480 458235904
Swap: 4144005120 169009152 3974995968
MemTotal:      3597324 kB
MemFree:       3099052 kB
MemShared:           0 kB
Buffers:          1020 kB
Cached:         447496 kB
Active:           3324 kB
Inact_dirty:    170156 kB
Inact_clean:    275036 kB
Inact_target:        4 kB
HighTotal:     2752504 kB
HighFree:      2351772 kB
LowTotal:       844820 kB
LowFree:        747280 kB
SwapTotal:     8241184 kB
SwapFree:      8076136 kB
