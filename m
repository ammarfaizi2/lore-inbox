Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbUJ0WCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUJ0WCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUJ0V7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:59:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:17330 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262946AbUJ0VyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:54:10 -0400
Date: Wed, 27 Oct 2004 14:58:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
Message-Id: <20041027145806.4e7acea3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0410271733440.10927@p500>
References: <Pine.LNX.4.61.0410250645540.9868@p500>
	<417CE49B.4060308@yahoo.com.au>
	<Pine.LNX.4.61.0410271733440.10927@p500>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>
> swapper: page allocation failure. order:0, mode:0x20
>   [<c0139227>] __alloc_pages+0x247/0x3b0
>   [<c02d9471>] add_interrupt_randomness+0x31/0x40
>   [<c01393a8>] __get_free_pages+0x18/0x40
>   [<c013ca2f>] kmem_getpages+0x1f/0xc0
>   [<c013d770>] cache_grow+0xc0/0x1a0
>   [<c013da1b>] cache_alloc_refill+0x1cb/0x210
>   [<c013de81>] __kmalloc+0x71/0x80
>   [<c036f8f3>] alloc_skb+0x53/0x100
>   [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
>   [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
>   [<c031f76b>] e1000_clean+0x5b/0x100
>   [<c0375f7a>] net_rx_action+0x6a/0xf0
>   [<c011daa1>] __do_softirq+0x41/0x90
>   [<c011db17>] do_softirq+0x27/0x30
>   [<c0106ebc>] do_IRQ+0x10c/0x130

This should be harmless - networking will recover.  The TSO fix was
merged a week or so ago.
