Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTLXPRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 10:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTLXPRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 10:17:14 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:58046 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S263639AbTLXPRM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 10:17:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Vid Strpic <vms@bofhlet.net>, Jean-Luc Fontaine <jfontain@free.fr>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
Date: Wed, 24 Dec 2003 10:17:09 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20031224092700.GA1406@home.bofhlet.net>
In-Reply-To: <20031224092700.GA1406@home.bofhlet.net>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312241017.09844.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.56.244] at Wed, 24 Dec 2003 09:17:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 December 2003 04:27, Vid Strpic wrote:
>On Tue, Dec 23, 2003 at 01:42:22PM +0100, Jean-Luc Fontaine wrote:
>> on 2.4:
>>   Timing buffer-cache reads:   168 MB in  2.01 seconds =  83.58
>> MB/sec Timing buffered disk reads:   44 MB in  3.12 seconds = 
>> 14.10 MB/sec on 2.6:
>>   Timing buffer-cache reads:   172 MB in  2.02 seconds =  84.95
>> MB/sec Timing buffered disk reads:   34 MB in  3.08 seconds = 
>> 11.04 MB/sec
>>
>> Note the big drop of of 3 MB/sec on disk reads.
>
>Consider yourself lucky :o)
>
>I had a drop from 55Mb/s to around 35, 2.4.22->2.6.0-test&final.
>Promise 20265, Seagate Barracuda 7.7200 80Gb, so nice ;)

I think the question should be, what are you fellows doing wrong?
>From onboard 2 year old via chipset, athlon at 1450mhz real:

[root@coyote root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.69 seconds =185.80 MB/sec
 Timing buffered disk reads:  64 MB in  1.15 seconds = 55.42 MB/sec
[root@coyote root]# hdparm -tT /dev/hdb

/dev/hdb:
 Timing buffer-cache reads:   128 MB in  0.69 seconds =185.00 MB/sec
 Timing buffered disk reads:  64 MB in  2.07 seconds = 30.89 MB/sec
[root@coyote root]# hdparm -tT /dev/hdd

/dev/hdd:
 Timing buffer-cache reads:   128 MB in  0.71 seconds =181.07 MB/sec
 Timing buffered disk reads:  64 MB in  1.40 seconds = 45.62 MB/sec

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

