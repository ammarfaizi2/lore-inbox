Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVHCCOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVHCCOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 22:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVHCCOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 22:14:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13046 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261978AbVHCCOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 22:14:49 -0400
Message-ID: <42F0281E.4030001@mvista.com>
Date: Tue, 02 Aug 2005 19:12:46 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
References: <4094.1123033708@kao2.melbourne.sgi.com>
In-Reply-To: <4094.1123033708@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Tue, 02 Aug 2005 18:12:27 -0700, 
> George Anzinger <george@mvista.com> wrote:
> 
>>How about something like:
>>	if (current + THREAD_SIZE/sizeof(long) - (regs + sizeof(pt_regs)) > MAGIC)
> 
> 
> current points to the current struct task, regs points to the kernel
> stack.  Those two data areas can be completely separate, as they are on
> i386.  Also i386 uses a separate kernel stack for interrupts.

Acually I must mean the thread_info and not current.  i386 only uses a 
seperate stack if you use 4K stacks.  I think others use seperate 
interrupt stacks, however :(.  Also, on thinking on it, I think some 
archs don't call the registers pt_regs either.  Oh, well, it was a 
thought...

Waiting for its brother... :)
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
