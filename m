Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261961AbSI3H4Y>; Mon, 30 Sep 2002 03:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbSI3H4X>; Mon, 30 Sep 2002 03:56:23 -0400
Received: from packet.digeo.com ([12.110.80.53]:20913 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261961AbSI3H4W>;
	Mon, 30 Sep 2002 03:56:22 -0400
Message-ID: <3D9804E1.76C9D4AE@digeo.com>
Date: Mon, 30 Sep 2002 01:01:37 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: 2.5.39-mm1
References: <3D976206.B2C6A5B8@digeo.com> <735786955.1033347097@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 08:01:39.0186 (UTC) FILETIME=[9B025520:01C26857]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > I must say that based on a small amount of performance testing the
> > benefits of the cache warmness thing are disappointing. Maybe 1% if
> > you squint.  Martin, could you please do a before-and-after on the
> > NUMAQ's, double check that it is actually doing the right thing?
> 
> Seems to work just fine:
> 
> 2.5.38-mm1 + my original hot/cold code.
> Elapsed: 19.798s User: 191.61s System: 43.322s CPU: 1186.4%
> 
> 2.5.39-mm1
> Elapsed: 19.532s User: 192.25s System: 42.642s CPU: 1203.2%
> 
> And it's a lot more than 1% for me ;-) About 12% of systime
> on kernel compile, IIRC.

Well that's still a 1% bottom line.  But we don't have a
comparison which shows the effects of this patch alone.

Can you patch -R the five patches and retest sometime?

I just get the feeling that it should be doing better.
