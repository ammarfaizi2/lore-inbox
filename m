Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbSLaHMb>; Tue, 31 Dec 2002 02:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbSLaHMb>; Tue, 31 Dec 2002 02:12:31 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:41862 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267178AbSLaHMa> convert rfc822-to-8bit;
	Tue, 31 Dec 2002 02:12:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] vm swappiness with contest
Date: Tue, 31 Dec 2002 18:20:53 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212271646.01487.conman@kolivas.net> <200212311757.50916.conman@kolivas.net> <3E11426A.4ABE66B5@digeo.com>
In-Reply-To: <3E11426A.4ABE66B5@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212311820.53437.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 Dec 2002 6:08 pm, Andrew Morton wrote:
> Con Kolivas wrote:
> > ...
> > post usemem:
> > MemTotal:       257296 kB
> > MemFree:         86168 kB
> > Buffers:           392 kB
> > Cached:           2244 kB
> > SwapCached:        632 kB
> > Active:         159484 kB
> > Inactive:         1380 kB
> > HighTotal:           0 kB
> > HighFree:            0 kB
> > LowTotal:       257296 kB
> > LowFree:         86168 kB
> > SwapTotal:     4194272 kB
> > SwapFree:      4192668 kB
> > Dirty:              60 kB
> > Writeback:           0 kB
> > Mapped:           1768 kB
> > Slab:             6748 kB
> > Committed_AS:     6588 kB
> > PageTables:        196 kB
> > ReverseMaps:       619
>
> OK, thanks.   It's a memory leak.
>
> Could you please send me a detailed description of how to
> set about reproducing this?
>
> When you say "I ran contest for a few days till I recreated the problem
> and it did recur.", does this imply that the leak was really slowly
> increasing, or does it imply that everything was fine for a few days
> uptime and then it sudddenly leaked a large amount of memory?

I ran contest -n 100 -l all

which should run all loads 100 times. The dbench_load results remained pretty 
much static until about the 60th run and then it started increasing fairly 
rapidly.

dbench_load doesnt exist in contest 0.51, but running dbench_load by itself 
did NOT reproduce the problem - I tried this first. Dbench_load just seemed 
to notice it the most, so it's one of the other loads in contest exposing the 
leak which are all in v 0.51. Unfortunately I cant say for certain which of 
the loads it is.

Con
