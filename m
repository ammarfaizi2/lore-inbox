Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWAYRub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWAYRub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWAYRub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:50:31 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:37780 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1751038AbWAYRua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:50:30 -0500
Message-ID: <43D7BA0F.5010907@nortel.com>
Date: Wed, 25 Jan 2006 11:49:03 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hancockr@shaw.ca
Subject: Re: sched_yield() makes OpenLDAP slow
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>
In-Reply-To: <43D78262.2050809@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2006 17:49:05.0728 (UTC) FILETIME=[A2A89400:01C621D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> 
> Robert Hancock wrote:

>  > This says nothing about requiring a reschedule. The "scheduling policy"
>  > can well decide that the thread which just released the mutex can
>  > re-acquire it.
> 
> No, because the thread that just released the mutex is obviously not one 
> of  the threads blocked on the mutex. When a mutex is unlocked, one of 
> the *waiting* threads at the time of the unlock must acquire it, and the 
> scheduling policy can determine that. But the thread the released the 
> mutex is not one of the waiting threads, and is not eligible for 
> consideration.

Is it *required* that the new owner of the mutex is determined at the 
time of mutex release?

If the kernel doesn't actually determine the new owner of the mutex 
until the currently running thread swaps out, it would be possible for 
the currently running thread to re-aquire the mutex.

Chris
