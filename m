Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbTCKJAD>; Tue, 11 Mar 2003 04:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262870AbTCKJAD>; Tue, 11 Mar 2003 04:00:03 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:10370 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262868AbTCKJAC>; Tue, 11 Mar 2003 04:00:02 -0500
Date: Tue, 11 Mar 2003 09:10:40 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@quaratino
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM / OOM troubles in 2.4.20-ck4 (-aa VM)
In-Reply-To: <200303051127.33140.kernel@kolivas.org>
Message-ID: <Pine.GSO.4.50.0303110904211.3993-100000@quaratino>
References: <Pine.GSO.4.50.0303041249251.5801-100000@quaratino>
 <200303051127.33140.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Our dual Athlon server with 512Mb RAM / 1.2Gb swap, and not particularly
> > heavily loaded, lasted 81 days with 2.4.20-ck1 under RH8.0, and then
> > succumbed with these errors:
> >
> >   VM error: killing process wineserver
> >    _alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>
> I'm not aware of any memory leak / vm problems with -ck although that may be
> possible. However ck4 does not have the OOM killer enabled so it's not that
> in action; you simply have run out of memory and it can't allocate any more.
> Have you tried without the aa vm addons in ck? Does this happen with vanilla
> 2.4.20? -ck is a very different branch.

FWIW - these problems don't appear to be happening with stock
2.4.21-pre5. Of course I can't say for sure, since the circumstances
will never be te same twice, but the machine survived the same sort of
hammering as the other day (with memory and swap almost full), but is
now happily relaxing again:

        total:    used:    free:  shared: buffers:  cached:
Mem:  528072704 410812416 117260288        0 113184768 66420736
Swap: 1258426368 23404544 1235021824
MemTotal:       515696 kB
MemFree:        114512 kB
MemShared:           0 kB
Buffers:        110532 kB
Cached:          56848 kB
SwapCached:       8016 kB
Active:         131172 kB
Inactive:        86036 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515696 kB
LowFree:        114512 kB
SwapTotal:     1228932 kB
SwapFree:      1206076 kB

So this time, WINE does _not_ appear to have been leaking like a sieve!
Stranger and stranger....

Regards
Alastair

