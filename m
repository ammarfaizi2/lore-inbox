Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268438AbTCCQUF>; Mon, 3 Mar 2003 11:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268439AbTCCQUF>; Mon, 3 Mar 2003 11:20:05 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:26297 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S268438AbTCCQTy>; Mon, 3 Mar 2003 11:19:54 -0500
Message-ID: <3E6385B0.1010706@kegel.com>
Date: Mon, 03 Mar 2003 08:41:20 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Protecting processes from the OOM killer
References: <3E5EB9A8.3010807@kegel.com> <1046439618.16599.22.camel@irongate.swansea.linux.org.uk> <3E5F8985.60606@kegel.com> <200303030845.00097.pollard@admin.navo.hpc.mil>
In-Reply-To: <200303030845.00097.pollard@admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> On Friday 28 February 2003 10:08 am, Dan Kegel wrote:
> 
>>Alan Cox wrote:
> 
> snip
> 
>>>Everything else is armwaving "works half the time" stuff. By the time
>>>the OOM kicks in the game is already over.
>>
>>Even with overcommit disallowed, the OOM killer is going to run
>>when my users try to run too big a job, so I would still like
>>the OOM killer to behave "well".
> 
> 
> Shouldn't - the process the user tries to run will not be started since
> it must reserve the space first. malloc will fail immediately, allowing the
> process to handle the even gracefully and exit.

I thought of that about five minutes after I hit 'send'.

I have a feeling that there might still be a few cases
not perfectly covered by the strict overcommit patch.
Say, memory allocations due to incoming network traffic.
I guess if memory runs out during incoming traffic, the kernel
should simply drop the traffic.  Until all those situations
are nicely ironed out, there's still some chance the OOM killer
might run even on a strict overcommit system.

But enough talking; I need to go try it.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

