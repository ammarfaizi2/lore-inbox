Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUAOCHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266398AbUAOCHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:07:38 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:34728 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266397AbUAOCHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:07:35 -0500
Message-ID: <4005F4CC.2070104@cyberone.com.au>
Date: Thu, 15 Jan 2004 13:02:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [patch] 2.6.1-mm3 quiet down SMP boot messages
References: <16389.21138.564775.207535@gargle.gargle.HOWL>
In-Reply-To: <16389.21138.564775.207535@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jes Sorensen wrote:

>Hi,
>
>I'd like to propose the following for 2.6.1-mm/2.6.2. On systems with a
>large number of CPUs the number of printk's flowing by for each CPU
>booting starts becoming a real console hog.
>
>The following patch eliminates a couple of them (already sent a patch to
>David for the ia64 specific ones) as well as changes the 
>"Building zonelist : X" in "Built Y zonelists". IMHO it doesn't make any
>sense to print for each zonelist since it's run in a for loop running
>from 0 to Y-1 anyway.
>
>The patch nukes a few new printk's that were introduced with the
>scheduler changes to the NUMA code in -mm3, if these are still needed
>then I won't fight for that part of the patch.
>

Thanks, I forgot to remove those printks because I don't have a NUMA
handy I guess. They're just to make sure the sched domains where being
initialized properly. They can go.

I like the rest of the patch too.


