Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUAXAAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266799AbUAXAAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:00:43 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:21436 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266798AbUAXAAk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:00:40 -0500
Message-ID: <4011B586.1090101@cyberone.com.au>
Date: Sat, 24 Jan 2004 11:00:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Randy Appleton <rappleto@nmu.edu>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Unneeded Code Found??
References: <3FFF3931.4030202@nmu.edu> <4006B998.5040403@tmr.com> <400B2BCF.7090003@nmu.edu> <400B7100.7090600@cyberone.com.au> <40119EC6.9010803@nmu.edu>
In-Reply-To: <40119EC6.9010803@nmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy Appleton wrote:

> Nick Piggin wrote: 


>
>> Yes it gets used.
>>
>> I think its a lot more common with direct io and when you have lots of
>> processes.
>
>
> I'm not arguing, but how do you know this?  I'm trying to convince 
> myself that the code is used, and at least on my system
> a few days of general use, followed by heavy parallel compiles, 
> doesn't use the code even once.
>
> I have not tested direct I/O.  Otherwise it looks unused.
>

Because I have seen it - I have instrumented it.

Your usage patterns are pretty tame actually. I remember having 100 
processes
randomly reading from the same part of the disk was one of my test cases.
You need direct IO otherwise everything ends up in pagecache.

I haven't seen workloads where it gets used a lot, but that doesn't mean 
they
don't exist, and I've never seen the code cause any problems, so there is no
need to make any trade offs by removing it.


