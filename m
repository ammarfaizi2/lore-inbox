Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVHIJ5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVHIJ5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVHIJ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:57:53 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:5560 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932498AbVHIJ5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:57:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=oI6vIuEvQoWD+9qxbudr/itd9JZC6N+vHfNXQUawLo4Rp6uKaUJbiRj3LO5Xou6wttRCYWZHegbziaUAygbUpzdo67enDu2AuJOFsUEJZYvFjq3P1/rq/S41spYLbuTqA6pHUn7GQHw6Ed6CzO1RUuDNPXwB9GONXDN1kFWt88Q=  ;
Message-ID: <42F87E1C.2040300@yahoo.com.au>
Date: Tue, 09 Aug 2005 19:57:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
References: <42F57FCA.9040805@yahoo.com.au>	 <200508090710.00637.phillips@arcor.de>	 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>	 <20050809080853.A25492@flint.arm.linux.org.uk>	 <1123576719.3839.13.camel@laptopd505.fenrus.org>	 <42F877FF.9000803@yahoo.com.au> <1123580985.3839.16.camel@laptopd505.fenrus.org>
In-Reply-To: <1123580985.3839.16.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-08-09 at 19:31 +1000, Nick Piggin wrote:
> 
>>Arjan van de Ven wrote:
>>

>>>and..... can we make a general page_is_ram() function that does what it
>>>says? on x86 it can go via the e820 table, other architectures can do
>>>whatever they need....
>>>
>>
>>That would be very helpful. That should cover the remaining (ab)users
>>of PageReserved.
>>
>>It would probably be fastest to implement this with a page flag,
>>however if swsusp and ioremap are the only users then it shouldn't
>>be a problem to go through slower lookups (and this would remove the
>>need for the PageValidRAM flag that I had worried about earlier).
> 
> 
> if you want I have implementations of this for x86, x86_64 and iirc ia64
> (not 100% sure about the later). None of these use a page flag, but use
> the same information the kernel uses during bootup to find ram.
> 

It seems like a good idea to me, if the arch guys are up for it.
If you have a copy of the patch handy, sure send it over.

Thanks
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
