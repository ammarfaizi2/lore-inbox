Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268546AbTBOHPZ>; Sat, 15 Feb 2003 02:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268545AbTBOHPZ>; Sat, 15 Feb 2003 02:15:25 -0500
Received: from dial-ctb04101.webone.com.au ([210.9.244.101]:46340 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S268546AbTBOHPX>;
	Sat, 15 Feb 2003 02:15:23 -0500
Message-ID: <3E4DEB72.4010405@cyberone.com.au>
Date: Sat, 15 Feb 2003 18:25:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.61-mm1
References: <20030214231356.59e2ef51.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.61/2.5.61-mm1/
>
>. Jens has fixed the request queue aliasing problem and we are no longer
>  able to break the IO scheduler.  This was preventing the OSDL team from
>  running dbt2 against recent kernels, so hopefully that is all fixed up now.
>
>. The anticipatory scheduler is performing well.  I've included that now.
>
And for those interested, if you find unusual IO performance,
please try disabling AS and reporting results. Thanks.

echo 0 > /sys/block/?/iosched/antic_expire

This value defaults to 10 (ms). More than around 20 might do
funny though not harmful stuff due to a fragile bitshift.

Nick


