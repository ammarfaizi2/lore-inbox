Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUJTPxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUJTPxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUJTPf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:35:29 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27919 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266663AbUJTPca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:32:30 -0400
Message-ID: <417687BE.5020900@techsource.com>
Date: Wed, 20 Oct 2004 11:43:58 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hugh Dickins wrote:

> 
> Wasn't Andrea worried, a couple of months back, about nested interrupts
> overflowing the 4K interrupt stack?  He was trying to work out how to
> have an 8K interrupt stack even with the 4K task stack, proposed thread
> info at both top and bottom of stack; but his "current" still looked to
> me like it'd be significantly more costly than the present one.

Yeah, one of the driving forces behind going to 4K task stacks is that 
you significantly reduce the amount of kernel memory reserved for user 
processes.  But then, there came the requirement to keep around a 
handful of irq stacks which doesn't hurt.

Given the finite and small number of IRQ stacks required, I see no 
reason not to make them 8K, other than for elegance sake.  You're not 
really wasting much memory by giving IRQ's 8k stacks.

Yes, I know, it does feel icky, though.  :)

