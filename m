Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVHIJcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVHIJcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVHIJcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:32:08 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:14435 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932486AbVHIJcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:32:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zmQDWh16dKWJaA1EhYelMzcDWFKFa3I36RwddrN/BZhyow+vJluONgoZ8oV4mBOrZeiu1nawREDMqMy3qvPkgHkJFIsRMuIh6vMwugJPiaVcd/fqTuwQdofTaVlh1ymDQAl5OVGohy52OBXHOURVTbKQEhwyk5hHII5FqtQTu1I=  ;
Message-ID: <42F877FF.9000803@yahoo.com.au>
Date: Tue, 09 Aug 2005 19:31:43 +1000
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
References: <42F57FCA.9040805@yahoo.com.au>	 <200508090710.00637.phillips@arcor.de>	 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>	 <20050809080853.A25492@flint.arm.linux.org.uk> <1123576719.3839.13.camel@laptopd505.fenrus.org>
In-Reply-To: <1123576719.3839.13.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-08-09 at 08:08 +0100, Russell King wrote:

>>Can we straighten out the terminology so it's less confusing please?
>>
> 
> 
> and..... can we make a general page_is_ram() function that does what it
> says? on x86 it can go via the e820 table, other architectures can do
> whatever they need....
> 

That would be very helpful. That should cover the remaining (ab)users
of PageReserved.

It would probably be fastest to implement this with a page flag,
however if swsusp and ioremap are the only users then it shouldn't
be a problem to go through slower lookups (and this would remove the
need for the PageValidRAM flag that I had worried about earlier).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
