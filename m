Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268590AbUI3Cla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268590AbUI3Cla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 22:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUI3Cl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 22:41:29 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:54433 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268590AbUI3ClO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 22:41:14 -0400
Message-ID: <415B71D0.3020100@yahoo.com.au>
Date: Thu, 30 Sep 2004 12:39:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@novell.com>,
       Ankit Jain <ankitjain1580@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: processor affinity
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com>	 <41596F7F.1000905@drdos.com>	 <1096387088.4911.4.camel@betsy.boston.ximian.com>	 <41598B23.50702@drdos.com> <1096408318.13983.47.camel@localhost.localdomain> <415AE953.3070105@drdos.com>
In-Reply-To: <415AE953.3070105@drdos.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Alan Cox wrote:
> 
>> On Maw, 2004-09-28 at 17:02, Jeff V. Merkey wrote:
>>  
>>
>>>>> http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=2&f=G&l=50&co1=AND&d=ptxt&s1=merkey.INZZ.&OS=IN/merkey&RS=IN/merkey 
>>>>>
>>>>>       
>>>>
>>>> Wow, I never knew about that.
>>>>
>>>> But guess who wrote the affinity system calls? :)
>>>>     
>>
>>
>>  
>>
>>> I wrote them first, and coined the term.   
>>
>>
>> Cute but GCOS3 had affinity syscalls for batch processing in the 1970's
>> and I don't believe it was original even then.
>>  
>>
> 
> Using them for Intel Cache affinity was new at the time.  Intel SMP 
> hardware was not readily available at the time and was in
> its infancy in 1993 when this was developed.

That is amazingly specific - I suppose using it for cache affinity on
earlier processors wouldn't count :)

Joking aside, this doesn't seem like it would apply to Linux's scheduler.
We don't use a global queue, and we don't implement hard affinities with
local queues, but with a specific bitmask of cpus.

Of course, I don't really have any idea how to interpret patents...
