Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVKKDY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVKKDY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVKKDY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:24:59 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:13283 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932346AbVKKDY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:24:58 -0500
Message-ID: <43740F06.6030504@m1k.net>
Date: Thu, 10 Nov 2005 22:24:54 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junichi Uekawa <dancer@netfort.gr.jp>
CC: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       debian-amd64@lists.debian.org
Subject: Re: [x86_64] 2.6.14-git13 mplayer fails with "v4l2: ioctl queue buffer
 failed: Bad address" (2 Nov 2005, 11 Nov 2005)
References: <87fyqeicge.dancerj%dancer@netfort.gr.jp>	<87wtjg5gh2.dancerj%dancer@netfort.gr.jp>	<4373D087.5050908@linuxtv.org> <87psp859sd.dancerj%dancer@netfort.gr.jp>
In-Reply-To: <87psp859sd.dancerj%dancer@netfort.gr.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junichi Uekawa wrote:

>Hi,
>
>>>I've tried running mplayer v4l2 input on a bt878 card, and it fails.
>>>xawtv works fine, and 2.6.14-rc5 used to work fine.
>>>
>>>On git 3b44f137b9a846c5452d9e6e1271b79b1dbcc942 :
>>>
>>>$ mplayer  tv://1 -tv driver=v4l2
>>>MPlayer dev-CVS--4.0.2 (C) 2000-2005 MPlayer Team
>>>CPU: Advanced Micro Devices Athlon 64 Newcastle,Winchester,San Diego,Venice; Sempron Palermo (Family: 15, Stepping: 0)
>>>Detected cache-line size is 64 bytes
>>>CPUflags:  MMX: 1 MMX2: 1 3DNow: 1 3DNow2: 1 SSE: 1 SSE2: 1
>>>Compiled for x86 CPU with extensions: MMX MMX2 3DNow 3DNowEx SSE SSE2
>>>
>>bttv currently only supports v4l1.  We are still in the process of 
>>porting the bttv driver from v4l1 to v4l2. Nickolay is working on it.
>>
>Thanks for the info. It's strange since this is a regression
>(pre 2.6.14 used to work. New code made it fail).
>Do you mean there was a change that broke v4l2 support in bttv ?
>Ever since Linux Kernel 2.6.3, I used v4l2 for recording (more
>than one and a half years...)
>  
>
v4l2 support could not have been broken, since it was never present.  
You were going through a compat layer.... Maybe that's where the 
regression is.

Anyhow, I will discuss this with the other v4l guys... One of us will 
get back to you, maybe ask you to test a patch or two.

One question -- At exactly what point does this break for you?  The git 
commit key above was from today, but at what point did this LAST work 
for you?  It would be really helpful if you can do a git bisection test, 
so that we can isolate the trouble patch if in fact it is a regression.

You might also like to join us in #v4l on irc.freenode.net ... Sometimes 
it's much quicker to troubleshoot this stuff over irc instead of email.

-Michael Krufky
