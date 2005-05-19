Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVESQY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVESQY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVESQYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:24:33 -0400
Received: from smtp004.bizmail.sc5.yahoo.com ([66.163.175.81]:7331 "HELO
	smtp004.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261154AbVESQXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:23:11 -0400
Message-ID: <428CBD63.8020704@metricsystems.com>
Date: Thu, 19 May 2005 09:22:59 -0700
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GDB, pthreads, and kernel threads
References: <45k9a-7DD-11@gated-at.bofh.it> <45xIX-2bR-31@gated-at.bofh.it> <45zKO-3RV-45@gated-at.bofh.it> <428BDA56.5030502@shaw.ca>
In-Reply-To: <428BDA56.5030502@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> John Clark wrote:
>
>> I built the latest GDB-6.3, as well as rebuilt glibc-2.3.5, and now 
>> when I step through the
>> main code line, which creates the tasks (I'm using the pthreads.c 
>> from the GDB testsuite), I do
>> not getany output from:
>>
>> info threads
>>
>> When I set a break point on the entry point of one of the 
>> soon-to-be-created threads,
>> I get a diagnostic message:
>>
>> Program terminated with signal SIGTRAP, Trace/Breakpoint trap.
>> The program no longer exists.
>
>
> Are you sure your glibc and gdb were both configured to support 
> threads when they were compiled?


The application that I'm working with 'works', in the sense that when I 
do a 'ps' there are several processes
listed under the app name, corresponding to the created threads.

When I run gdb with the app, it does load /lib/libthread_db.so.1, so my 
presumption here is that gdb has
been thread enabled.

Since the app is pretty portable, and I've been using NetBSD to develop 
co-develop it, I can run gdb
on the NetBSD side, and 'things' seem to work better. There are still 
some wyrd operational issues
on the NetBSD, but at least when I set a break point in a thread, it 
works, and when I do a
'info threads' command to gdb, it gives a reasonable out put of the list 
of threads. Since the NetBSD
implementation of threads is 'new' to the kernel, I do expect some problems.

Now, because the thread implementation is different between NetBSD and 
Linux, and it seems that Linux
creates distinct 'processes' for the threads, I'm wondering if I have 
not correctly configured my kernel,
or if there is something special one has to do to allow gdb to write to 
one of the created thread processes.

Also, I do believe I'm using the NPTL package for threads. Is there a 
way to absolutely tell without
question?

Thanks
John Clark



