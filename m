Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbSLaGPn>; Tue, 31 Dec 2002 01:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbSLaGPn>; Tue, 31 Dec 2002 01:15:43 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:35974 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267160AbSLaGPm> convert rfc822-to-8bit;
	Tue, 31 Dec 2002 01:15:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] vm swappiness with contest
Date: Tue, 31 Dec 2002 17:24:05 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212271646.01487.conman@kolivas.net> <200212311658.53118.conman@kolivas.net> <3E11347B.2C8195D1@digeo.com>
In-Reply-To: <3E11347B.2C8195D1@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212311724.05416.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 Dec 2002 5:08 pm, Andrew Morton wrote:
> Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Saturday 28 Dec 2002 5:16 pm, Con Kolivas wrote:
> > > Is there something about the filesystem layer or elsewhere in the
> > > kernel that could decay or fragment over time that only a reboot can
> > > fix? This would seem to be a bad thing.
> >
> > Ok Linus suggested I check slabinfo before and after.
> >
> > I ran contest for a few days till I recreated the problem and it did
> > recur. I don't know how to interpret the information so I'll just dump it
> > here:
>
> Looks OK.  Could we see /proc/meminfo and /proc/vmstat?

meminfo:
MemTotal:       257296 kB
MemFree:         47468 kB
Buffers:         27028 kB
Cached:           7480 kB
SwapCached:        272 kB
Active:         154968 kB
Inactive:        42756 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       257296 kB
LowFree:         47468 kB
SwapTotal:     4194272 kB
SwapFree:      4193816 kB
Dirty:            1116 kB
Writeback:           0 kB
Mapped:           3740 kB
Slab:             8564 kB
Committed_AS:     6580 kB
PageTables:        196 kB
ReverseMaps:      1381

vmstat:
nr_dirty 240
nr_writeback 0
nr_pagecache 8712
nr_page_table_pages 49
nr_reverse_maps 1383
nr_mapped 937
nr_slab 2140
pgpgin 254170865
pgpgout 637037580
pswpin 5126123
pswpout 25405883
pgalloc 510309571
pgfree 510321474
pgactivate 486194881
pgdeactivate 503024404
pgfault 693111528
pgmajfault 1013600
pgscan 1521783411
pgrefill 939783846
pgsteal 146188093
kswapd_steal 105403604
pageoutrun 377963
allocstall 1408123
pgrotated 45339615

>
> What filesystem are you using?  And what kernel?
ext3 on 2.5.53-mm1

Con
