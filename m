Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTJQDZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 23:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTJQDZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 23:25:38 -0400
Received: from dyn-ctb-210-9-243-144.webone.com.au ([210.9.243.144]:61188 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263298AbTJQDZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 23:25:37 -0400
Message-ID: <3F8F6020.2040206@cyberone.com.au>
Date: Fri, 17 Oct 2003 13:21:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: decaying average for %CPU
References: <1066358155.15931.145.camel@cube>	 <3F8F5A53.50209@cyberone.com.au> <1066359629.15920.161.camel@cube>
In-Reply-To: <1066359629.15920.161.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Albert Cahalan wrote:

>On Thu, 2003-10-16 at 22:56, Nick Piggin wrote:
>
>>Albert Cahalan wrote:
>>
>>
>>>The UNIX standard requires that Linux provide
>>>some measure of a process's "recent" CPU usage.
>>>Right now, it isn't provided. You might run a
>>>CPU hog for a year, stop it ("kill -STOP 42")
>>>for a few hours, and see that "ps" is still
>>>reporting 99.9% CPU usage. This is because the
>>>kernel does not provide a decaying average.
>>>
>>I think the kernel provides enough info for userspace to do
>>the job, doesn't it?
>>
>
>I'm pretty sure not. Linux provides:
>
>per-process start time
>current time
>per-process total (lifetime) CPU usage
>units of time measurement (awkwardly)
>boot time
>

But your userspace program can calculate deltas in the total
CPU statistics. Yep, its in /proc/stat.

>
>>From that you can compute %CPU over the whole
>life of the process. This does not meet the
>requirements of the UNIX standard.
>
>What we do for load average is about right,
>except that per-process values can't all get
>updated at the same time. So the algorithm
>needs to be adjusted a bit to allow for that
>

load average is not CPU load though


