Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWHIB4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWHIB4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHIB4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:56:31 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:46931 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750800AbWHIB4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:56:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=opCWj4ylSSMDjbIVDtcr6pYDEpuc9NthONTPxiAKi4dV8YXAoYpnF3cU0ZjEnaDsYCKSY5YPeV0BD3KmRooU1ziphKPu0jXwjmHhGnTIF3TTDLiwkR+QvUAOGP4SUmIlDU0goHR5Aiz+qXn455hkupebF68YwH38JJtkbaX5cPM=  ;
Message-ID: <44D940CA.9040608@yahoo.com.au>
Date: Wed, 09 Aug 2006 11:56:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain> <200608081808.34708.dada1@cosmosbay.com> <44D8BD29.4010102@yahoo.com.au> <200608081849.28458.dada1@cosmosbay.com>
In-Reply-To: <200608081849.28458.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

>On Tuesday 08 August 2006 18:34, Nick Piggin wrote:
>
>>Eric Dumazet wrote:
>>
>>>We certainly can. But if you insist of using mmap sem at all, then we
>>>have a problem.
>>>
>>>rbtree would not reduce cacheline bouncing, so :
>>>
>>>We could use a hashtable (allocated on demand) of size N, N depending on
>>>NR_CPUS for example. each chain protected by a private spinlock. If N is
>>>well chosen, we might reduce lock cacheline bouncing. (different threads
>>>fighting on different private futexes would have a good chance to get
>>>different cachelines in this hashtable)
>>>
>>See other mail. We already have a hash table ;)
>>
>
>Yes but still you want at FUTEX_WAIT time to tell the kernel the futex is 
>private to this process.
>

Yes, but I'm saying we already have a hash table. The hash table.

I'm *not* saying you *don't* also want a private directive from userspace.
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
