Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUHNN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUHNN4A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUHNN4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 09:56:00 -0400
Received: from [195.23.16.24] ([195.23.16.24]:64412 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262406AbUHNNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 09:55:58 -0400
Message-ID: <411E150B.4000301@grupopie.com>
Date: Sat, 14 Aug 2004 14:35:07 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <2nrJd-7Dx-19@gated-at.bofh.it> <2ouFe-2vz-63@gated-at.bofh.it>	 <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it>	 <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it>	 <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org>	 <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de>	 <20040813135109.GA20638@elte.hu>  <411D9A2A.1000202@grupopie.com> <1092459662.803.66.camel@krustophenia.net>
In-Reply-To: <1092459662.803.66.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.10; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2004-08-14 at 00:50, Paulo Marques wrote:
> 
>>Ingo Molnar wrote:
>>
>>>...
>>>
>>>
>>>>With binary search you would need to backward search to find the stem
>>>>for the stem compression. It's probably doable, but would be a bit
>>>>ugly I guess.
>>>
>>>
>>>yeah. Maybe someone will find the time to improve the algorithm. But
>>>it's not a highprio thing.
>>
>>Well, I found some time and decided to give it a go :)
>>
> 
> 
> I get a few warnings:
> 
>   CC      kernel/kallsyms.o
> kernel/kallsyms.c: In function `kallsyms_lookup':
> kernel/kallsyms.c:99: warning: `last_0idx' might be used uninitialized in this function
> kernel/kallsyms.c:101: warning: `last_0prefix' might be used uninitialized in this function
> 
> rlrevell@mindpipe:~/cvs/alsa/alsa-driver$ gcc --version
> gcc (GCC) 3.3.4 (Debian 1:3.3.4-7)
> Copyright (C) 2003 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

My original email explained this problem. These warning are harmless 
(although not pretty, for sure), and Ingo corrected them for the O8 
patch (this was only 2 hours after your email :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
