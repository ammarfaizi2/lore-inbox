Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbSLaHAJ>; Tue, 31 Dec 2002 02:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267177AbSLaHAJ>; Tue, 31 Dec 2002 02:00:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:34454 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267173AbSLaHAI>;
	Tue, 31 Dec 2002 02:00:08 -0500
Message-ID: <3E11426A.4ABE66B5@digeo.com>
Date: Mon, 30 Dec 2002 23:08:26 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] vm swappiness with contest
References: <200212271646.01487.conman@kolivas.net> <200212311724.05416.conman@kolivas.net> <3E113B25.534BEBE4@digeo.com> <200212311757.50916.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 07:08:27.0387 (UTC) FILETIME=[6A8D74B0:01C2B09B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> post usemem:
> MemTotal:       257296 kB
> MemFree:         86168 kB
> Buffers:           392 kB
> Cached:           2244 kB
> SwapCached:        632 kB
> Active:         159484 kB
> Inactive:         1380 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       257296 kB
> LowFree:         86168 kB
> SwapTotal:     4194272 kB
> SwapFree:      4192668 kB
> Dirty:              60 kB
> Writeback:           0 kB
> Mapped:           1768 kB
> Slab:             6748 kB
> Committed_AS:     6588 kB
> PageTables:        196 kB
> ReverseMaps:       619

OK, thanks.   It's a memory leak.

Could you please send me a detailed description of how to
set about reproducing this?

When you say "I ran contest for a few days till I recreated the problem
and it did recur.", does this imply that the leak was really slowly
increasing, or does it imply that everything was fine for a few days
uptime and then it sudddenly leaked a large amount of memory?
