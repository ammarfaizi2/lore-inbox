Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270983AbTGPRQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270990AbTGPRPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:15:20 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:48018 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270966AbTGPROK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:14:10 -0400
Date: Wed, 16 Jul 2003 18:28:23 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716172823.GE21896@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	vojtech@suse.cz,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de> <20030716172531.GP833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716172531.GP833@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:25:31PM +0200, Jens Axboe wrote:
 > > I've not booted a 2.4 kernel since 2.4.20..
 > You should try 2.4.21, basically any 2.4 with the newer ide stuff.
 > Would be interesting to hear how they compare.

Ok, I'll take a look later this evening if time permits..

 > >  > Also Dave, can you try
 > >  > and do a vmstat 1 while ripping and PS2 dropping out?
 > > Ok, I just fired that up in another window.
 > > When it happens next, I'll mail off a snapshot..
 > Thanks.

Well, that didn't take long..

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0 109376   9632   2576  44368    0    0   136    28 1636  1304  1  4 90  4
 0  0 109376   8036   2588  45852    0    0  1492     0 2166 15874  2 11 82  5
 1  0 109376   8036   2588  45852    0    0     0     0 1089  1230  1  1 99  0
 1  0 109376   8004   2612  45896    0    0     8   144 2660  1088  1 11 85  4
 1  0 109376   5880   2616  46436    0    0     0     0 1338  1263  2 24 74  0
 2  0 109376   5512   2576  45320    0    0     0    72 2108  1434  4 35 61  0
 2  0 109376   5816   2520  45252   56    0    60   940 1852  2340  6 33 59  2
 1  0 109376   4880   2448  45800    0    0     0   520 1940  2930  6 33 60  2
 0  0 109376   5468   2412  45300    0    0    16  1672 2504  3077  9 42 44  7
 1  0 109376   5532   2396  45792    0    0     0   344 2172  3504  4 33 61  2
 1  0 109376   4132   2416  46452    0    0     8     4 2727  3483  5 39 54  1
 0  0 109376   4864   2384  45484    0    0     4  1324 2186  3448  5 34 59  4
 1  0 109376   5024   2384  46436    0    0     0   600 2484  3533  4 36 58  2

Lost sync here. Mouse dancing. vmstat output stopped for a few seconds.

 1  3 109376   5480   2404  45396   88    0   136  1760 2371  3391  6 41 44 10
 2  2 109376   4924   2200  43200  340    0  1688   312 2272  5477 19 49  2 29
 1  1 109376   4660   2224  45056  568    0  1524     0 2835  3675 15 45  9 31
 3  1 109376  17964   2224  31028  720    0  1232  1468 2095  2518 12 43 24 22
 2  4 109376  19148   2232  29060  532    0   864     4 2307  5684 22 57  6 15
 4  0 109376  18716   2240  29732   68    0    68  1728 2037  6512 26 49 20  6
 3  0 109376  18264   2240  29228  164    0   164     0 2078  7674 31 52 11  6
 1  0 109376  17208   2452  29816  220    0   416    40 2455  9701 36 61  4  0
cprocs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 5  1 109376  15384   2476  31404   20    0   856    96 1929 10534 29 52 17  2
 6  1 109376  17084   2408  28828   28    0  4416  2280 2162  7640 25 60  2 14
 1  4 109376   3872   2388  27416    8    0  7864   740 2078  7232 20 53  1 26
 7  3 109376  19380   2280  27876  124    0  2560   108 2247  4298 19 52  0 30
 2  1 109376  17444   2184  28692  104    0  2412     0 2117  6171 24 52  1 24
 8  1 109376   5052   2148  26460   24    0  2848   668 2007  5297 31 61  0  8
 4  0 109376  20208   2152  27260  216    0  2520   336 2126  5398 23 55  5 17
 2  0 109376  20284   2164  25956    0    0     4  2688 1890  4921 30 47 17  5
 3  0 109376   4332   2164  26772    0    0    16     0 2201  6067 39 56  6  0

regained control of mouse here.

 2  0 109376  20896   2160  26052   44    0    44     4 2032  5131 37 53  9  0
 2  1 109376   4424   2236  26796  200    0   328     0 2160  5662 41 51  7  2
 3  0 109376  18596   2264  27616  172    0   428  2824 2067  7553 29 60  4  6
 4  2 109376  12576   2280  28540  624    0   832  1136 1956  7002 28 53  4 14
 1  1 109376   8768   2288  29660  708    0  1084     0 2278  2027  7 36 15 43
 1  1 109376   6308   2400  31004  108    0   836   140 2206  2868 12 37 19 33
 3  1 109376   4488   2424  31728    0    0    40  2840 2277  1720 10 42  7 42
 1  0 109376  12124   2460  31216    0    0    96   596 1578  1805  7 38 42 12

		Dave

