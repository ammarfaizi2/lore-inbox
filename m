Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbSIXXML>; Tue, 24 Sep 2002 19:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSIXXML>; Tue, 24 Sep 2002 19:12:11 -0400
Received: from smtpout.mac.com ([204.179.120.97]:34255 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261841AbSIXXMK>;
	Tue, 24 Sep 2002 19:12:10 -0400
Date: Wed, 25 Sep 2002 01:16:58 +0200
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: <linux-kernel@vger.kernel.org>
To: David Schwartz <davids@webmaster.com>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <20020924201908.AAA16336@shell.webmaster.com@whenever>
Message-Id: <B9100B20-D013-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag den, 24. September 2002, um 22:19, schrieb David Schwartz:

>
>> The effect of M:N on UP systems should be even more clear. Your
>> multithreaded apps can't profit of parallelism but they do not
>> add load to the system scheduler. The drawback: more syscalls
>> (I think about removing the need for
>> flags=fcntl(GETFLAGS);fcntl(fd,NONBLOCK);write(fd);fcntl(fd,flags))
>
> 	The main reason I write multithreaded apps for single CPU systems 
> is to
> protect against ambush. Consider, for example, a web server. Someone 
> sends it
> an obscure request that triggers some code that's never run before and 
> has to
> fault in. If my application were single-threaded, no work could be done 
> until
> that page faulted in from disk. This is why select-loop and poll-loop 
> type
> servers are bursty.

With the current NGPT design your threads would be blocked (all that are 
scheduled
one this kernel vehicle).

With Scheduler Activations this could also be avoided.
The thread scheduler could get an upcall - but this will stay theory for 
a long
time on Linux.
But this is a somewhat far fetched example (for arguing for 1:1), isn't 
it?

There are other means of DoS..



