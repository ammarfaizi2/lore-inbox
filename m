Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUJTPyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUJTPyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUJTPxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:53:35 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:50703 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268028AbUJTPfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:35:09 -0400
Message-ID: <41768858.8070709@techsource.com>
Date: Wed, 20 Oct 2004 11:46:32 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com>
In-Reply-To: <20040910153421.GD24434@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Arjan van de Ven wrote:
> On Fri, Sep 10, 2004 at 05:28:52PM +0200, Andrea Arcangeli wrote:
> 
>>On Fri, Sep 10, 2004 at 05:15:38PM +0200, Arjan van de Ven wrote:
>>
>>>because it gives people a reason to do sloppy coding.
>>
>>it's not about bad drivers, it's about the number of nested interrupts
>>not being limited by software right now.
>>
>>
>>>What we should consider regardless is disable the nesting of irqs for
>>>performance reasons but that's an independent matter
>>
>>disabling nesting completely sounds a bit too aggressive, but limiting
>>the nesting is probably a good idea.
> 
> 
> disabling is actually not a bad idea; hard irq handlers run for a very short
> time, but when they nest you effectively have like a semi context switch in
> the middle of the work so performance suffers...
> 


The rules about how long a hard irq would be allowed to run would have 
to be draconian.

... not that that would be a problem.


