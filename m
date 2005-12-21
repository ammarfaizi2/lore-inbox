Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVLUCMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVLUCMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 21:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVLUCMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 21:12:30 -0500
Received: from smtp106.plus.mail.mud.yahoo.com ([68.142.206.239]:415 "HELO
	smtp106.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932255AbVLUCM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 21:12:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zQyIXKrHux0O2fNOaoNW1AYF/SDvbRP5cZNSY1PiX8lWiysrF7sVKSI4pPqyu2F7Iri15v4J8+g070nhWH3sSp/j14zTyLggjK/GRL1nPJksdN9iu+3KTa2GrvGxxrizIxSZdQ8O+SEDfRHxyfpD4zmw/PTczSHY+nlsSqRxQ6U=  ;
Message-ID: <43A8BA07.4000804@yahoo.com.au>
Date: Wed, 21 Dec 2005 13:12:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au> <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain> <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org> <20051220193423.GC24199@flint.arm.linux.org.uk> <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org> <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> On Tue, 20 Dec 2005, Linus Torvalds wrote:

>>IOW, why don't you just do
>>
>>	ldr  lr,[%0]
>>	subs lr, lr, %1
>>	str  lr,[%0]
>>	blmi failure
>>
>>as the _base_ timings, since that should be the common case. That's the 
>>drop-dead fastest UP case.
> 
> 
> The above is 5 cycles.  About the same as the preemption-safe swp-based 
> mutex implementation on non-Intel ARM.  It is broken wrt interrupts when 
> the swp is not.

How it is broken WRT interrupts? (sorry, I haven't had it explained to me
in words of two syllables or less)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
