Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUCCXwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUCCXwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:52:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:40694 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261258AbUCCXwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:52:43 -0500
Message-ID: <40466FC4.6000507@mvista.com>
Date: Wed, 03 Mar 2004 15:52:36 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jim.houston@comcast.net
CC: amitkale@emsyssoft.com, linux-kernel@vger.kernel.org
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use	kernel/Kconfig.kgdb
References: <1078354486.1824.363.camel@new.localdomain>
In-Reply-To: <1078354486.1824.363.camel@new.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
>>Meanwhile, I would like to make a change to the gdb "info thread"
>>command to do a better job of displaying the threads.  Here is what
>>I am proposing:
>>
>>Gdb would work as it does now if the following set is not done.
>>
>>A new "set thread_level" command that would take the "bt" level to use
>>on the thread display.
>>A new "set thread_limits command that would take two expressions that
>>would reduce to two memory addresses.
> 
> 
> Hi George,
> 
> I already did a bit of work in this space.  You might give my 
> gdb-thread-skip-frame.patch a try.  
> 
> You can find it archived here:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/gdb/gdb-6.0/gdb-thread-skip-frame.patch

I have been talking with the gdb folks and I think we are real close to having a 
solution that makes very minimal (if any) changes to gdb.  At this point we can 
write a couple of macros that do almost all that we need.  The only problem 
seems to be the number of lines per thread in the report.  So, the only change 
to gdb would be to suppress a carrage return in a couple of places.

It does require that we implement a new command in the stub, or rather, that we 
change the ThreadExtraInfo command to do the same thing with a different command.

I will keep you posted, or better yet, sign up for the gdb@sources.redhat.com 
mailing list and listen in.

-g
> 
> Jim Houston
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

