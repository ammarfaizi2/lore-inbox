Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263943AbRFEJdl>; Tue, 5 Jun 2001 05:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263948AbRFEJda>; Tue, 5 Jun 2001 05:33:30 -0400
Received: from carrot.linuxgrrls.org ([212.18.228.66]:6660 "HELO
	carrot.linuxgrrls.org") by vger.kernel.org with SMTP
	id <S263947AbRFEJdQ>; Tue, 5 Jun 2001 05:33:16 -0400
Date: Tue, 5 Jun 2001 10:29:16 +0100 (BST)
From: kira brown <kira@linuxgrrls.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, Chris Wedgwood <cw@f00f.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <bjornw@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: Missing cache flush. 
In-Reply-To: <25587.991730769@redhat.com>
Message-ID: <Pine.LNX.4.30.0106051028390.10786-100000@carrot.linuxgrrls.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Jun 2001, David Woodhouse wrote:

>
> davem@redhat.com said:
> > Chris Wedgwood writes:
> > > What if the memory is erased underneath the CPU being aware of
> > > this? In such a way ig generates to bus traffic...
>
> > This doesn't happen on x86.  The processor snoops all transactions
> > done by other agents to/from main memory.  The processor caches are
> > always up to date.
>
> No. My original mail presented two situations in which this assumption is
> false.
>
> 1. Bank-switched RAM. You want to force a writeback before switching pages.
>    I _guarantee_ you that the CPU isn't snooping my access to the I/O port
>    which sets the latch that drives the upper few address bits of the RAM
>    chips.
>
> 2. Flash. A few writes of magic data to magic addresses and a whole erase
>    block suddenly contains 0xFF. The CPU doesn't notice that either.

3. Buggy implementations like the Cyrix 486es that don't properly maintain
   cache coherency.

kira.

