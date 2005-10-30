Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932815AbVJ3E0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbVJ3E0L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 00:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbVJ3E0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 00:26:11 -0400
Received: from pippin.dreamhost.com ([66.33.211.27]:1195 "EHLO
	pippin.dreamhost.com") by vger.kernel.org with ESMTP
	id S932815AbVJ3E0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 00:26:10 -0400
Message-ID: <43644B56.5070100@jstenback.com>
Date: Sat, 29 Oct 2005 21:25:58 -0700
From: Johnny Stenback <jst@jstenback.com>
User-Agent: Mail/News 1.6a1 (X11/20051025)
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc coredump with 2.6.12+ kernels
References: <4319DC91.4020406@jstenback.com> <20050903174030.GA5406@localhost.localdomain>
In-Reply-To: <20050903174030.GA5406@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, this issue was resolved in 2.6.14. I don't know off hand which 
patch did it, but I don't see this problem now after upgrading to 2.6.14.

Thanks to whoever figured this out :)

Alexander Nyberg wrote:
> On Sat, Sep 03, 2005 at 10:25:37AM -0700 Johnny Stenback wrote:
> 
>> Hey all,
>>
>> I just attempted to upgrade my kernel to 2.6.13. The kernel appears to 
>> boot and run just fine, but when I try to build any larger projects like 
>> Mozilla or the Linux kernel I constantly get segfaults from gcc. All 
>> other apps *seem* to work fine. I remember seeing this with 2.6.12 too 
>> when I tried to upgrade to it too but I didn't have the time to 
>> investigate at all then, but now I see the same problem with 2.6.13. The 
>> last version I've used that didn't show this problem is 2.6.11.3, and 
>> that's running with no problems here.
>>
>> When gcc segfaults I get the following messages in the messages log:
>>
>> cc1[16775]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>> 00007fffffaaf0a0 error 4
>> cc1[17086]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>> 00007fffffc4dfc0 error 4
>> cc1[17788]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>> 00007fffffd777e0 error 4
>> cc1[17823]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>> 00007fffffc4d630 error 4
>> cc1[17895]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>> 00007ffffffd2330 error 4
>>
>> I'm on a dual AMD Opteron system, running x86_64 code. Using Fedora Core 
>> 2 (yeah, old, I know...) and gcc 3.3.3 20040412.
> 
> Does it still happen if you run:
> 
> echo 0 > /proc/sys/kernel/randomize_va_space
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
jst
