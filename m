Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264529AbTH2LRn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTH2LRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:17:43 -0400
Received: from dyn-ctb-203-221-73-68.webone.com.au ([203.221.73.68]:267 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264525AbTH2LRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:17:34 -0400
Message-ID: <3F4F3637.9050604@cyberone.com.au>
Date: Fri, 29 Aug 2003 21:17:11 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nico-kernel@schottelius.org>
CC: Ross Clarke <encrypted@geekz.za.net>,
       Linux-Admin <linux-admin@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Crazy load average & unkillable processes
References: <3F4D339A.8010907@geekz.za.net> <20030828085549.GB264@schottelius.org> <3F4DCC65.2010106@cyberone.com.au> <20030829090129.GE690@schottelius.org>
In-Reply-To: <20030829090129.GE690@schottelius.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like you still have quite a lot of free memory left, so its
not that. Maybe you have runaway processes? Look in top. Although
if its only happening with test4, I guess its probably kernel
related. Maybe ACPI? Maybe your video card driver? Try booting with
acpi=off. Post a dmesg too. Thanks.

Nico Schottelius wrote:

>I am attaching /proc/meminfo,slapinfo,uptime from now.
>The system is f*** slow..
>And I am currently just able to write this, moving windows
>in X is more than painful!
>
>Nico
>
>Nick Piggin [Thu, Aug 28, 2003 at 07:33:25PM +1000]:
>
>>Nico Schottelius wrote:
>>
>>
>>>Very interesting..
>>>with the test4 I experiene the same/similar problems on my laptop..
>>>all of sudden yesterday several programs died -> Out of Memory.
>>>I ran
>>> Xfree
>>> dhcpcd
>>> opera 
>>> several xterms (about 6)
>>> qmail
>>> named
>>>
>>>first opera was Out of Memory, then died the whole X system with all
>>>xterms and X beeing Out of Memory.
>>>
>>>MemTotal:       385600 kB
>>>
>>>which should be more than enough!
>>>
>>>
>>You might have a process with a memory leak. How much free memory do
>>you have before everything dies? How much swapping activity is going
>>on? What do /proc/meminfo and /proc/slabinfo say?
>>
>>
>>
>

