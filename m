Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270995AbTGPRSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTGPRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:17:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6338 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270966AbTGPRQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:16:28 -0400
Date: Wed, 16 Jul 2003 19:31:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716173122.GQ833@suse.de>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de> <20030716172531.GP833@suse.de> <20030716172823.GE21896@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716172823.GE21896@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, Dave Jones wrote:
>  > >  > Also Dave, can you try
>  > >  > and do a vmstat 1 while ripping and PS2 dropping out?
>  > > Ok, I just fired that up in another window.
>  > > When it happens next, I'll mail off a snapshot..
>  > Thanks.
> 
> Well, that didn't take long..
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  2  0 109376   9632   2576  44368    0    0   136    28 1636  1304  1  4 90  4
>  0  0 109376   8036   2588  45852    0    0  1492     0 2166 15874  2 11 82  5
>  1  0 109376   8036   2588  45852    0    0     0     0 1089  1230  1  1 99  0
>  1  0 109376   8004   2612  45896    0    0     8   144 2660  1088  1 11 85  4
>  1  0 109376   5880   2616  46436    0    0     0     0 1338  1263  2 24 74  0
>  2  0 109376   5512   2576  45320    0    0     0    72 2108  1434  4 35 61  0
>  2  0 109376   5816   2520  45252   56    0    60   940 1852  2340  6 33 59  2
>  1  0 109376   4880   2448  45800    0    0     0   520 1940  2930  6 33 60  2
>  0  0 109376   5468   2412  45300    0    0    16  1672 2504  3077  9 42 44  7
>  1  0 109376   5532   2396  45792    0    0     0   344 2172  3504  4 33 61  2
>  1  0 109376   4132   2416  46452    0    0     8     4 2727  3483  5 39 54  1
>  0  0 109376   4864   2384  45484    0    0     4  1324 2186  3448  5 34 59  4
>  1  0 109376   5024   2384  46436    0    0     0   600 2484  3533  4 36 58  2
> 
> Lost sync here. Mouse dancing. vmstat output stopped for a few seconds.

Doesn't look really bogged down by interrupt load, still half idle. So
that looks like a PS2 bug. Unless the irq latencies are really bad, I
guess that could be it too. Vojtech knows a hell of a lot more about
that than me :)

-- 
Jens Axboe

