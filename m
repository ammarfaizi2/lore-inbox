Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVHQSE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVHQSE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVHQSE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:04:59 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:53190 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751184AbVHQSE7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:04:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i64WCcKSFAoiz6xi0ttKnC+4DqERSUIxBl+ERA+yelN+I1xP88cQdyOVbEthE0xr3rt53M7XgkWSoObEtqr+0GZV2wLtOL/UTYw4wDC/Ho5r+DZnu1aIIGeNRdH2Lltef7VsLUXzB/O0QnaFl/gRdcApoj4C8As5XXvgJpp5nO8=
Message-ID: <6bffcb0e0508171104311942ff@mail.gmail.com>
Date: Wed, 17 Aug 2005 20:04:58 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200508171903.43985.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <6bffcb0e05081614498879a72@mail.gmail.com>
	 <4302F0D8.6050409@bigpond.net.au>
	 <200508171903.43985.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here are additional staircase scheduler benchmarks.

(make all -j8)

scheduler:
staircase

sched_compute=1

schedstat:
version 12
timestamp 4294712019
cpu0 1 0 0 31 0 18994 4568 7407 5903 10267 6976 14426
domain0 3 18574 18398 6 3938 193 4 0 18398 335 285 0 1191 175 0 0 285 4753 4508
75 6843 337 1 0 4508 0 0 0 0 0 0 0 0 0 2036 728 0
cpu1 3 0 0 59 0 15696 3324 6699 4661 5123 4628 12372
domain0 3 19445 19289 13 3418 162 1 0 19289 249 200 0 1178 186 0 0 200
3514 3314 37 5559 350 0 0 3314 1 0 1 0 0 0 0 0 0 1504 494 0

ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    49m48.619s
user    77m20.788s
sys     6m7.653s

schedstat:
version 12
timestamp 2734078
cpu0 1 0 0 31 0 356054 31106 152573 125255 2881936 7814746 324948
domain0 3 118014 117779 11 5092 248 5 0 117779 128809 95903 1 1894938
234516 0 0 95903 36014 31037 85 302927 42496 1 0 31037 1 0 1 0 0 0 0 0
0 48347 17439 0
cpu1 3 0 0 59 0 300542 19080 138093 89744 2264854 9434146 281462
domain0 3 644449 644005 45 9298 434 2 0 644005 124611 92742 0 1906903
231495 0 0 92742 25101 19062 56 357145 51607 0 0 19062 2 0 2 0 0 0 0 0
0 27318 10646 0

(make clean, reboot)
---

(make all -j64)

scheduler:
staircase

sched_compute=1

schedstat:
version 12
timestamp 4294716697
cpu0 0 0 0 33 0 19246 4863 7747 6286 9132 6575 14383
domain0 3 21947 21809 84 3054 59 7 0 21809 290 245 4 1171 149 0 0 245 5059 4835
51 6050 291 3 0 4835 1 0 1 0 0 0 0 0 0 1979 673 0
cpu1 2 0 0 63 0 15351 3115 6435 4454 5300 5159 12236
domain0 3 22400 22237 14 3560 164 1 0 22235 259 207 0 1143 192 0 0 207
3267 3109 35 4064 241 1 0 3109 1 0 1 0 0 0 0 0 0 1461 515 0

ng02:/usr/src/linux-2.6.12# time make all -j64
[..]
real    58m25.456s
user    76m23.481s
sys     9m7.176s

schedstat:
version 12
timestamp 3255484
cpu0 0 0 0 33 0 689742 98987 373969 324889 2692229 69800959 590755
domain0 3 612145 609500 141 1273549 124626 7 0 609500 160067 113714 8
24280104 2559138 0 0 113714 109551 98950 77 3340107 387551 3 0 98950 1
0 1 0 0 0 0 0 0 108518 54439 0
cpu1 2 0 0 63 0 405307 27680 215244 106724 2508189 59419042 377627
domain0 3 858505 852898 2074 992349 91546 365 0 852886 138776 92602 62 24895205
2567033 0 0 92602 37703 27593 154 3880340 443218 2 0 27593 360 0 360 0
0 0 0 0 0 49080 20879 0

Regards,
Michal Piotrowski
