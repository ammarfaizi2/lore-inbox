Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbUJ0WCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbUJ0WCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbUJ0V6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:58:32 -0400
Received: from lucidpixels.com ([66.45.37.187]:39364 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262951AbUJ0Vz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:55:27 -0400
Date: Wed, 27 Oct 2004 17:55:25 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
In-Reply-To: <20041027145806.4e7acea3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410271754280.10927@p500>
References: <Pine.LNX.4.61.0410250645540.9868@p500> <417CE49B.4060308@yahoo.com.au>
 <Pine.LNX.4.61.0410271733440.10927@p500> <20041027145806.4e7acea3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks, one last question,

I do not explicitly set ethtool* tso, however I use dhcpcd on this 
interface, does that set TSO on the interface? I have never used TSO (that 
I am aware of) and I am wondering if it is something else?

On Wed, 27 Oct 2004, Andrew Morton wrote:

> Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>>
>> swapper: page allocation failure. order:0, mode:0x20
>>   [<c0139227>] __alloc_pages+0x247/0x3b0
>>   [<c02d9471>] add_interrupt_randomness+0x31/0x40
>>   [<c01393a8>] __get_free_pages+0x18/0x40
>>   [<c013ca2f>] kmem_getpages+0x1f/0xc0
>>   [<c013d770>] cache_grow+0xc0/0x1a0
>>   [<c013da1b>] cache_alloc_refill+0x1cb/0x210
>>   [<c013de81>] __kmalloc+0x71/0x80
>>   [<c036f8f3>] alloc_skb+0x53/0x100
>>   [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
>>   [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
>>   [<c031f76b>] e1000_clean+0x5b/0x100
>>   [<c0375f7a>] net_rx_action+0x6a/0xf0
>>   [<c011daa1>] __do_softirq+0x41/0x90
>>   [<c011db17>] do_softirq+0x27/0x30
>>   [<c0106ebc>] do_IRQ+0x10c/0x130
>
> This should be harmless - networking will recover.  The TSO fix was
> merged a week or so ago.
>
