Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbSK3CzU>; Fri, 29 Nov 2002 21:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSK3CzU>; Fri, 29 Nov 2002 21:55:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:12517 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267209AbSK3CzT>;
	Fri, 29 Nov 2002 21:55:19 -0500
Message-ID: <3DE82A4C.B8332D8E@digeo.com>
Date: Fri, 29 Nov 2002 19:02:36 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: Javier Marcet <jmarcet@pobox.com>, Rik van Riel <riel@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
References: <20021130013832.GF15682@jerry.marcet.dyndns.org> <Pine.LNX.4.50.0211292103200.26051-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2002 03:02:36.0740 (UTC) FILETIME=[EFAD1840:01C2981C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> Hmm i'm using 2.4.19-rmap15

Don't think so.

> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  525332480 522969088  2363392        0 10117120 365477888
> Swap: 2154938368 873652224 1281286144
> MemTotal:       513020 kB
> MemFree:          2308 kB
> MemShared:           0 kB
> Buffers:          9880 kB
> Cached:         282768 kB
> SwapCached:      74144 kB
> Active:         273452 kB
> Inactive:       194068 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       513020 kB
> LowFree:          2308 kB
> SwapTotal:     2104432 kB
> SwapFree:      1251256 kB

That's stock 2.4 meminfo output.

-               "Inactive:     %8u kB\n"
+               "Inact_dirty:  %8u kB\n"
+               "Inact_laundry:%8u kB\n"
+               "Inact_clean:  %8u kB\n"
+               "Inact_target: %8lu kB\n"


You're using an extraordinary amount of swap.  Is something leaking?
