Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUJTRyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUJTRyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUJTRy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:54:29 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:51465 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268767AbUJTRrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:47:04 -0400
Message-ID: <4176A749.8050306@techsource.com>
Date: Wed, 20 Oct 2004 13:58:33 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@novell.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <593560000.1094826651@[10.10.2.4]>	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>	 <20040910151538.GA24434@devserv.devel.redhat.com>	 <20040910152852.GC15643@x30.random>	 <20040910153421.GD24434@devserv.devel.redhat.com>	 <41768858.8070709@techsource.com>	 <20041020153521.GB21556@devserv.devel.redhat.com> <1098290345.1429.65.camel@krustophenia.net>
In-Reply-To: <1098290345.1429.65.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lee Revell wrote:
> On Wed, 2004-10-20 at 11:35, Arjan van de Ven wrote:
> 
>>On Wed, Oct 20, 2004 at 11:46:32AM -0400, Timothy Miller wrote:
>>
>>>The rules about how long a hard irq would be allowed to run would have 
>>>to be draconian.
>>
>>they already are.
> 
> 
> The IDE I/O completion in hardirq context means that one can run for
> almost 3ms.  Apparently at OLS it was decided that the target for
> desktop responsiveness was 1ms.  So this is a real problem.

What is happening that takes 3ms, and why can't it be broken up?

Are you talking here about PIO?  Is there a limited amount of time you 
have to do the PIO before the data goes away?  It may be acceptable to 
just live with PIO being slow, since high-performance systems will all 
be using DMA anyhow.

> 
> What exactly do you mean by "draconian"?

In this case, I mean extremely harsh and restrictive.  Usually, it means 
"excessively harsh", but in this case, I mean that in a good way.  :)

