Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263614AbSIQFJM>; Tue, 17 Sep 2002 01:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263625AbSIQFJM>; Tue, 17 Sep 2002 01:09:12 -0400
Received: from packet.digeo.com ([12.110.80.53]:26300 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263614AbSIQFJL>;
	Tue, 17 Sep 2002 01:09:11 -0400
Message-ID: <3D86BA1B.84873680@digeo.com>
Date: Mon, 16 Sep 2002 22:14:03 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-mm@kvack.org,
       akpm@zip.com.au, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
References: <3D86B683.8101C1D1@digeo.com> <210772234.1032213704@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 05:14:03.0598 (UTC) FILETIME=[0A0A9EE0:01C25E09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> ...
> >> MemTotal:     32107256 kB
> >> MemFree:      27564648 kB
> >
> > I'd be suspecting that your node fallback is bust.
> >
> > Suggest you add a call to show_free_areas() somewhere; consider
> > exposing the full per-zone status via /proc with a proper patch.
> 
> Won't /proc/meminfo.numa show that? Or do you mean something
> else by "full per-zone status"?

meminfo.what?   Remember when I suggested that you put
a testing mode into the numa code so that mortals could
run numa builds on non-numa boxes?


> Looks to me like it's just out of low memory:
> 
> > LowFree:          1424 kB
> 
> There is no low memory on anything but node 0 ...
> 

It was a GFP_HIGH allocation - just pagecache.
