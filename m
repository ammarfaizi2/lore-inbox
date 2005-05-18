Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVERQCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVERQCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVERQCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:02:17 -0400
Received: from smtp006.bizmail.sc5.yahoo.com ([66.163.175.83]:43966 "HELO
	smtp006.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262307AbVERPxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:53:52 -0400
Message-ID: <428B650A.1060204@metricsystems.com>
Date: Wed, 18 May 2005 08:53:46 -0700
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GDB, pthreads, and kernel threads
References: <428A8034.801@metricsystems.com> <8764xg63ar.fsf@amaterasu.srvr.nix>
In-Reply-To: <8764xg63ar.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:

>On 18 May 2005, John Clark announced authoritatively:
>  
>
>>Most of my work has been in the kernel and I had not paid attention to
>>user 'threads'. However, I have at the moment to a need to debug a
>>user 'pthread' based applicaiton, that I may want to move into the kernel.
>>
>>However, I can't seem to figure out how to get GDB to debug my user
>>pthreads app. What is the correct setup to debug pthreads based applications
>>now that it seems that pthreads implementation generates processes/threads
>>in the kernel.
>>    
>>
>
>Use a recent GDB (>=6.2) and things should just work. (At least, they do
>for me.)
>  
>

I built the latest GDB-6.3, as well as rebuilt glibc-2.3.5, and now when 
I step through the
main code line, which creates the tasks (I'm using the pthreads.c from 
the GDB testsuite), I do
not getany output from:

info threads

When I set a break point on the entry point of one of the 
soon-to-be-created threads,
I get a diagnostic message:

Program terminated with signal SIGTRAP, Trace/Breakpoint trap.
The program no longer exists.


On the machine being used to debug the kernel is: 2.6.5.

Is there any problems with that kernel, or should I upgrade to a more 
recent vintage
version?

Thanks
John Clark

