Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVHUBev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVHUBev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 21:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVHUBev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 21:34:51 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:41854 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750759AbVHUBeu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 21:34:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ASYnHL3uv6EkosAfpploMKHYJmbdVAdPo5lHPh9AgDdERNKOBrYGy5x07DF4cL6yM+hwJRKkQsdVm2UHB9Vu2RvY/+OHGoG9q7VO/78Co/vPfp3IwPgDA6fj2elEt3tXWhRTuFAKzEfEmwNdTgHC6ebqcB5UDhp8rxkaGAo9RpA=
Message-ID: <6bffcb0e05082018346f073ca4@mail.gmail.com>
Date: Sun, 21 Aug 2005 03:34:46 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
In-Reply-To: <6bffcb0e05081614498879a72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <6bffcb0e05081614498879a72@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here are kernbench results:

cpusched=ingosched

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 365,4
User Time 620,8
System Time 64,6
Percent CPU 187,2
Context Switches 38296,8
Sleeps 37867

(reboot)

-------------------------------------------------------------------------------

cpusched=staircase

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 611,6
User Time 616,4
System Time 81
Percent CPU 114,8
Context Switches 96470,2
Sleeps 122413

(reboot)

---

sched_compute=1

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 354,6
User Time 615,2
System Time 61
Percent CPU 190
Context Switches 9876,4
Sleeps 18510,4

(reboot)

-------------------------------------------------------------------------------

cpusched=spa_no_frills

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 352
User Time 624
System Time 60
Percent CPU 193,8
Context Switches 19185,4
Sleeps 18205,8

(reboot)

-------------------------------------------------------------------------------

cpusched=zaphod

max_ia_bonus=default
max_tpt_bonus=default

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 389,4
User Time 607,8
System Time 58,8
Percent CPU 170,8
Context Switches 44965,2
Sleeps 27352,8

(reboot)

---

max_ia_bonus=0
max_tpt_bonus=default

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 351,4
User Time 623,4
System Time 59,8
Percent CPU 194
Context Switches 21264,6
Sleeps 20284,6

(reboot)

---

max_ia_bonus=default
max_tpt_bonus=0

./kernbench -M -o 128
[..]
Elapsed Time 387,6
User Time 608
System Time 57,6
Percent CPU 171,6
Context Switches 43684,8
Sleeps 26757,4

(reboot)

---

max_ia_bonus=0
max_tpt_bonus=0

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 351
User Time 623,4
System Time 60,4
Percent CPU 194,2
Context Switches 21241,8
Sleeps 19751,6

(reboot)

-------------------------------------------------------------------------------

cpusched=nicksched

./kernbench -M -o 128
[..]
Average Optimal -j 128 Load Run:
Elapsed Time 776,4
User Time 590,8
System Time 85,4
Percent CPU 95,4
Context Switches 99664,8
Sleeps 147169

Regards,
Michal Piotrowski
