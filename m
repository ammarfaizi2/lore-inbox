Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbUCAItl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUCAItk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:49:40 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:38545 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262283AbUCAIti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:49:38 -0500
Message-ID: <4042F7E6.1050904@cyberone.com.au>
Date: Mon, 01 Mar 2004 19:44:22 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MM VM patches was: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <4042F38B.8020307@matchmail.com>
In-Reply-To: <4042F38B.8020307@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Andrew Morton wrote:
>
>> shrink_slab-for-all-zones.patch
>>   vm: scan slab in response to highmem scanning
>>
>> zone-balancing-fix.patch
>>   vmscan: zone balancing fix
>
>
> On 2.6.3 + [1] + nfsd-lofft.patch running on a 1GB ram file server.   
> I have noticed two related issues.
>
> First, under 2.6.3 it averages about 90MB[2] anon memory, and 30MB 
> with the -mm4 vm (the rest is in swap cache).  This could balance out 
> on the normal non-idle week-day load though...
>
> Second the -mm4 vm, there is a lot more swapping[3] going on during 
> the daily updatedb, and backup runs that are performed on this machine.
> I'd have to call this second issue a regression, but I want to run it 
> a couple more days to see if it gets any better (unless you agree of 
> course).
>

There are a few things backed out now in 2.6.4-rc1-mm1, and quite a
few other changes. I hope we can trouble you to test 2.6.4-rc1-mm1?

Tell me, do you have highmem enabled on this system? If so, swapping
might be explained by the batching patch. With it, a small highmem
zone could possibly place quite a lot more pressure on a large
ZONE_NORMAL.

2.6.4-rc1-mm1 sould do much better here.

