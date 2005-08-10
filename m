Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVHJXtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVHJXtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVHJXtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:49:10 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:41682 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S964821AbVHJXtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:49:09 -0400
Message-ID: <42FA926E.5070901@google.com>
Date: Wed, 10 Aug 2005 16:49:02 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: YhLu <YhLu@tyan.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org,
       "'discuss@x86-64.org'" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB> <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de>
In-Reply-To: <20050810232614.GC27628@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, Aug 10, 2005 at 04:14:19PM -0700, Mike Waychison wrote:
> 
>>YhLu wrote:
>>
>>>andi,
>>>
>>>please refer the patch, it will move cpu_set(, cpu_callin_map) from
>>>smi_callin to start_secondary.
>>
>>
>>This patch fixes an apparent race / lockup on our 2-way dual cores (when 
>>applied against 2.6.12.3).  The machine was locking up after 
>>"Initializing CPU#2".
> 
> 
> The real solution for this issue is the smp_call_function_single patch from Eric
> that I reposted yesterday. Yh's patch just changed the timing slightly.
> 
> 

Indeed.

I had a report here that the smp_call_function_single patch wasn't 
fixing our problem.  I just tried it myself and it appears to also fix 
the problem.

Thanks,

Mike Waychison
