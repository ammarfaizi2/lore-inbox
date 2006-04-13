Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWDMUMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWDMUMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWDMUMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:12:16 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:23003 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932390AbWDMUMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:12:16 -0400
Message-ID: <443EBC1D.1000307@wolfmountaingroup.com>
Date: Thu, 13 Apr 2006 15:01:17 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: K P <kplkml@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com> <443E74C1.5090801@mbligh.org>
In-Reply-To: <443E74C1.5090801@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> K P wrote:
>
>> Sun's recently published SPECjbb_2005 numbers on Linux, Windows and
>> Solaris on their
>> Opteron system, and the Linux result is the lowest of the three by far:
>>
>> Linux: 
>> http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00062.html 
>>
>> Solaris: 
>> http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00063.html 
>>
>> Windows: 
>> http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00064.html 
>>
>>
>> It's not evident if Sun spent any time analyzing and tuning the Linux
>> result. While the
>> majority of the tuning opportunities for SPECjbb_2005 are likely to be
>> in the JVM itself, I was
>> wondering (given the large spread between the OS's) if there were
>> other typical opportunities
>> to tune the Linux kernel for JVM performance and SPECjbb_2005.
>>
>> There are some other results showing excellent scalability with 
>> SPECjbb_2005 on
>> Linux/Itanium (such as SGI's:
>> http://www.spec.org/jbb2005/results/res2006q2/ ), but it's
>> not clear if there are other opportunities for tuning unique to Linux
>> on Opteron, or Linux
>> in general that should be explored
>>
>> Comments?
>>  
>>
>
> SpecJBB is a really frigging stupid benchmark. It's *much* more affected
> by the stupid crap in Java (like their locking model) than anything in 
> the
> OS.
> Best to find another benchmark, oh and preferably somebody vaguely
> objective to run it ;-)
>
> M.
>
Note they ran the benchmark on an Opteron 285 instead of a Xeon with 16 
GB of memory.    Opteron peformance currently **SUCKS** with 2.6 series 
kernels under any kind of heavy I/O due to their cloning of the ancient 
82489DX architecture for I/O interrupt access and performance.  Looks 
like the test was stakced against Linux from the start.  Should have 
used a Xeon system. 

AMD needs to get their crappy I/O performance up to snuff.  Looking at 
the test parameteres leads me to believe there was a lot of swapping on 
a system with already poor I/O performance.

Jeff
