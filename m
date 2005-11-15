Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVKOTe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVKOTe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVKOTe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:34:27 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:24558 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S965018AbVKOTe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:34:26 -0500
Message-ID: <437A3842.6000403@mvista.com>
Date: Tue, 15 Nov 2005 11:34:26 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: evan@coolrunningconcepts.com, linux-kernel@vger.kernel.org
Subject: Re: Timer idea
References: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com> <Pine.LNX.4.61.0511151401400.6145@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511151401400.6145@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Tue, 15 Nov 2005 evan@coolrunningconcepts.com wrote:
> 
> 
>>I was thinking about benchmarking, profiling, and various other applications
>>that might need frequent access to the current time.  Polling timers or
>>frequent timer signal delivery both seem like there would be a lot of
>>overhead.
>>I was thinking it would be nice if you could just read the time information
>>without making an OS call.
>>
>>I figure the kernel keeps accurate records of current time information and the
>>values of various timers.  I then had the idea that one could have a /dev or
>>maybe a /proc entry that would allow you to mmap() the kernel records (read
>>only) and then you could read this information right from the kernel without
>>any overhead.
> 
> 
> Great invention, read some timer without any overhead! I guess if
> you can figure it out you are up for a Nobel Prize, certainly a new
> breakthrough.
> 
> FYI, even if you put some kernel spinning count in shared-memory,
> it would have overhead. In fact, users might even be able DOS the
> machine by spinning on that count. Putting time in /proc or /dev
> also has great overhead. Have you ever looked at how these
> file-systems work?
> 
> On ix86 machines, basic time comes from chip(s), read from ports.
> That's just another tiny little problem.

Its not just shared memory, but a protected very low overhead extension of the kernel code space 
into the user map.  Mostly what is saved is the system call overhead.
> 
> The time-keeping in Linux certainly has a few problems and they
> don't seem to be getting resolved, just exchanging one set of
> problems for another as the timer code has been rewritten many
> times. It would helpful if somebody did take a fresh new look
> at timekeeping, but reading something from shared memory just
> isn't relevant.

Possibly you would like to review what John is doing and make relevent comments.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
