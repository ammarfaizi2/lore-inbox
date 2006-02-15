Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030617AbWBODxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbWBODxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWBODxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:53:54 -0500
Received: from mailserver.applegatebroadband.net ([207.55.227.3]:47623 "EHLO
	apbb.net") by vger.kernel.org with ESMTP id S1030617AbWBODxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:53:54 -0500
Message-ID: <43F2A59D.6010604@wildturkeyranch.net>
Date: Tue, 14 Feb 2006 19:53:01 -0800
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@wildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH 08/12] hrtimer: completely remove it_real_value
References: <Pine.LNX.4.61.0602141111270.3731@scrub.home> <43F20CCA.6010105@wildturkeyranch.net> <Pine.LNX.4.61.0602141804190.30994@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0602141804190.30994@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Tue, 14 Feb 2006, George Anzinger wrote:
> 
> 
>>>Remove the it_real_value from /proc/*/stat, during 1.2.x was the last
>>>time it returned useful data (as it was directly maintained by the
>>>scheduler), now it's only a waste of time to calculate it.
>>
>>This may be true but this changes the order of items presented making any
>>"code" looking for items after it_real_value in the list look at the wrong
>>thing.  If we are going to change this, I think we need some sort of version
>>in the output.  Something that changes when ever the output format or content
>>is modified in any way.
> 
> 
> I think you missed this:
> 
> 
>>>@@ -413,7 +411,7 @@ static int do_task_stat(struct task_stru
>>> 	start_time = nsec_to_clock_t(start_time);
>>>  	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
>>>-%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu
>>>\
>>>+%lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %lu \
> 
>                                             ^
I think you are right.  Looks ok to me.

-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

