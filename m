Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbSLaGuD>; Tue, 31 Dec 2002 01:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbSLaGuC>; Tue, 31 Dec 2002 01:50:02 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:39814 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267183AbSLaGt3> convert rfc822-to-8bit;
	Tue, 31 Dec 2002 01:49:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] vm swappiness with contest
Date: Tue, 31 Dec 2002 17:57:50 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212271646.01487.conman@kolivas.net> <200212311724.05416.conman@kolivas.net> <3E113B25.534BEBE4@digeo.com>
In-Reply-To: <3E113B25.534BEBE4@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212311757.50916.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 Dec 2002 5:37 pm, Andrew Morton wrote:
> Con Kolivas wrote:
> > On Tuesday 31 Dec 2002 5:08 pm, Andrew Morton wrote:
> > > Con Kolivas wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> > > >
> > > > On Saturday 28 Dec 2002 5:16 pm, Con Kolivas wrote:
> > > > > Is there something about the filesystem layer or elsewhere in the
> > > > > kernel that could decay or fragment over time that only a reboot
> > > > > can fix? This would seem to be a bad thing.
> > > >
> > > > Ok Linus suggested I check slabinfo before and after.
> > > >
> > > > I ran contest for a few days till I recreated the problem and it did
> > > > recur. I don't know how to interpret the information so I'll just
> > > > dump it here:
> > >
> > > Looks OK.  Could we see /proc/meminfo and /proc/vmstat?
> >
> > meminfo:
> > MemTotal:       257296 kB
> > MemFree:         47468 kB
> > Buffers:         27028 kB
> > Cached:           7480 kB
> > SwapCached:        272 kB
> > Active:         154968 kB
> > Inactive:        42756 kB
> > HighTotal:           0 kB
> > HighFree:            0 kB
> > LowTotal:       257296 kB
> > LowFree:         47468 kB
> > SwapTotal:     4194272 kB
> > SwapFree:      4193816 kB
> > Dirty:            1116 kB
> > Writeback:           0 kB
> > Mapped:           3740 kB
> > Slab:             8564 kB
> > Committed_AS:     6580 kB
> > PageTables:        196 kB
> > ReverseMaps:      1381
>
> These numbers _look_ wrong, but ext3 truncate does funny things.
> Could you now run a big usemem/fillmem application to try to allocate and
> use 200 megs of memory, then resend /proc/meminfo?

post usemem:
MemTotal:       257296 kB
MemFree:         86168 kB
Buffers:           392 kB
Cached:           2244 kB
SwapCached:        632 kB
Active:         159484 kB
Inactive:         1380 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       257296 kB
LowFree:         86168 kB
SwapTotal:     4194272 kB
SwapFree:      4192668 kB
Dirty:              60 kB
Writeback:           0 kB
Mapped:           1768 kB
Slab:             6748 kB
Committed_AS:     6588 kB
PageTables:        196 kB
ReverseMaps:       619

Con
