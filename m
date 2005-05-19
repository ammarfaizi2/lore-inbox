Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVESR1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVESR1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVESR1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:27:49 -0400
Received: from smtp001.bizmail.yahoo.com ([216.136.172.125]:15025 "HELO
	smtp001.bizmail.yahoo.com") by vger.kernel.org with SMTP
	id S261177AbVESR1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:27:33 -0400
Message-ID: <428CCC80.1010908@metricsystems.com>
Date: Thu, 19 May 2005 10:27:28 -0700
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Douglas McNaught <doug@mcnaught.org>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, patela@gmail.com
Subject: Re: GDB, pthreads, and kernel threads
References: <45k9a-7DD-11@gated-at.bofh.it> <45xIX-2bR-31@gated-at.bofh.it>	<45zKO-3RV-45@gated-at.bofh.it> <428BDA56.5030502@shaw.ca>	<428CBD63.8020704@metricsystems.com> <m21x839n0b.fsf@Douglas-McNaughts-Powerbook.local>
In-Reply-To: <m21x839n0b.fsf@Douglas-McNaughts-Powerbook.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas McNaught wrote:

>John Clark <jclark@metricsystems.com> writes:
>
>  
>
>>Also, I do believe I'm using the NPTL package for threads. Is there a
>>way to absolutely tell without
>>question?
>>    
>>
>
>If you see multiple 'ps' entries for threads (without using any
>special flags to ps) you are not using NPTL.  NPTL is in 2.6 and in
>some vendor 2.4 kernels, but not in kernel.org 2.4.X.
>  
>

I used the hint from Ajay Patel and found that in my 'installed' glibc 
on my host 'linuxthreads' was being
used. However, I did compile glibc-2.3.5 for the host and results from 
that indicate that the nptl threads
version is begin used.

I will see if 1) the Gentoo distribution which was installed on the host 
machine I'm using has an updated
version of everything to the nptl threads, or 2) compile gdb against the 
glibc-2.3.5 which has the
ntpl threads.

Also, I'm using a 2.6.5 kernel in my host development environment, and 
using a 2.6.11.6 kernel
in my target. The target is actually using uClibc, and so I will check 
for the type of threads package
that is being supported there as well.

Thanks
John Clark

