Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270822AbTHAQfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 12:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270831AbTHAQfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 12:35:44 -0400
Received: from hardcopy.esd.mun.ca ([134.153.36.129]:48042 "EHLO
	hardcopy.esd.mun.ca") by vger.kernel.org with ESMTP id S270822AbTHAQfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 12:35:43 -0400
From: Stephen Anthony <stephena@cs.mun.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: What's the timeslice size for kernel 2.6.0-test2, IA32?
Date: Fri, 1 Aug 2003 14:04:46 -0230
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011404.46886.stephena@cs.mun.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I haven't been able to find this information anywhere.  I know HZ was
>> increased to 1000, but was the timeslice decreased to 1 ms (from 10 ms)
>> as well?
>
> Depends on nice of the task. Nice 0 tasks get 102ms.

I don't think I asked the right question :)  If I call usleep(x) or 
nanosleep(x) with kernel 2.4.21, and x < 10, the sleep would still last 
10 ms because of the timeslice.  All sleeps would be a multiple of 10 ms.

If I call usleep(x) or nanosleep(x) in 2.6.0-test2, what 'multiple' can I 
expect?  Maybe I mean granularity instead of timeslice.  Basically, I 
want to know how 'soft' of a real-time system the new kernel is.

It would be great if sleeps were 1ms accurate instead of 10ms.  It would 
make synchronization code a lot easier.

Steve
