Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTDOJNp (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 05:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTDOJNp (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 05:13:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14579 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264411AbTDOJNo (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 05:13:44 -0400
Message-ID: <3E9BCFF8.3050703@mvista.com>
Date: Tue, 15 Apr 2003 02:25:12 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Andrew Morton <akpm@zip.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix jiffies_to_time[spec | val] and converse to use actual
 jiffies increment rather than 1/HZ
References: <3E9BC49E.7010903@mvista.com> <20030415095528.B32468@flint.arm.linux.org.uk>
In-Reply-To: <20030415095528.B32468@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Apr 15, 2003 at 01:36:46AM -0700, george anzinger wrote:
> 
>>In the current system (2.5.67) time_spec to jiffies, time_val to 
>>jiffies and the converse (jiffies to time_val and jiffies to 
>>time_spec) all use 1/HZ as the measure of a jiffie.  Because of the 
>>inability of the PIT to actually generate an accurate 1/HZ interrupt, 
>>the wall clock is updated with a more accurate value (999848 
>>nanoseconds per jiffie for HZ = 1000).
> 
> 
> There's an increasing amount of 64-bit math appearing here, which gcc
> has been historically bad with.  Is there any chance that all this
> extra complexity can vanish for architectures which do not have this
> problem?

I suppose that is possible.  On the other hand, the only 64-bit things 
we leave to C are the "+" and shift.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

