Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTLXRe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTLXRez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:34:55 -0500
Received: from h24-109-7-102.ed.shawcable.net ([24.109.7.102]:3766 "HELO
	alpha.home") by vger.kernel.org with SMTP id S263723AbTLXRet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:34:49 -0500
From: "Gordon Larsen" <glarsen@alpha.homedns.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: IDE performance drop between 2.4.23 and 2.6.0
Date: Wed, 24 Dec 2003 10:24:31 -0700
Message-ID: <IBEJLCACHGEIBMFJACBEOEPLELAA.glarsen@alpha.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200312241017.09844.gene.heskett@verizon.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me too...using a Promise Fastrack 133 TX2 card and a three 80GB Barracuda
drives in a md RAID5 array, throughput dropped from about 40MB/S on the
array to about 30-33MB/S.  Readahead buffer setting make little or no
difference.

...Gord

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Gene Heskett
>Sent: December 24, 2003 8:17 AM
>To: Vid Strpic; Jean-Luc Fontaine
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
>
>
>On Wednesday 24 December 2003 04:27, Vid Strpic wrote:
>>On Tue, Dec 23, 2003 at 01:42:22PM +0100, Jean-Luc Fontaine wrote:
>>> on 2.4:
>>>   Timing buffer-cache reads:   168 MB in  2.01 seconds =  83.58
>>> MB/sec Timing buffered disk reads:   44 MB in  3.12 seconds =
>>> 14.10 MB/sec on 2.6:
>>>   Timing buffer-cache reads:   172 MB in  2.02 seconds =  84.95
>>> MB/sec Timing buffered disk reads:   34 MB in  3.08 seconds =
>>> 11.04 MB/sec
>>>
>>> Note the big drop of of 3 MB/sec on disk reads.
>>
>>Consider yourself lucky :o)
>>
>>I had a drop from 55Mb/s to around 35, 2.4.22->2.6.0-test&final.
>>Promise 20265, Seagate Barracuda 7.7200 80Gb, so nice ;)
>
>I think the question should be, what are you fellows doing wrong?
>From onboard 2 year old via chipset, athlon at 1450mhz real:
>
>[root@coyote root]# hdparm -tT /dev/hda
>
>/dev/hda:
> Timing buffer-cache reads:   128 MB in  0.69 seconds =185.80 MB/sec
> Timing buffered disk reads:  64 MB in  1.15 seconds = 55.42 MB/sec
>[root@coyote root]# hdparm -tT /dev/hdb
>
>/dev/hdb:
> Timing buffer-cache reads:   128 MB in  0.69 seconds =185.00 MB/sec
> Timing buffered disk reads:  64 MB in  2.07 seconds = 30.89 MB/sec
>[root@coyote root]# hdparm -tT /dev/hdd
>
>/dev/hdd:
> Timing buffer-cache reads:   128 MB in  0.71 seconds =181.07 MB/sec
> Timing buffered disk reads:  64 MB in  1.40 seconds = 45.62 MB/sec
>
>--
>Cheers, Gene
>AMD K6-III@500mhz 320M
>Athlon1600XP@1400mhz  512M
>99.22% setiathome rank, not too shabby for a WV hillbilly
>Yahoo.com attornies please note, additions to this message
>by Gene Heskett are:
>Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


