Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSEPNnB>; Thu, 16 May 2002 09:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312991AbSEPNnB>; Thu, 16 May 2002 09:43:01 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:8387 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S312983AbSEPNnA>;
	Thu, 16 May 2002 09:43:00 -0400
Date: Thu, 16 May 2002 23:39:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bart@jukie.net, linux-kernel@vger.kernel.org
Subject: Re: Q: x86 interrupt arrival after cli
Message-Id: <20020516233956.542fcf6d.sfr@canb.auug.org.au>
In-Reply-To: <E178LMh-0004FK-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002 14:32:19 +0100 (BST) Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> > Quick question for the x86 gurus:

Not a real x86 guru :-)

> > If a hardware interrupt arrives within a spin_lock_irqsave &
> > spin_unlock_irqrestore will the interrupt handler associated with said
> > interrupt be called immediately after the spinlock is released? =20
> 
> It will be called as soon as the cpu hardware gets around to it - which 
> should be just after the irq mask flag is cleared.

If memory serves (and Intel hasn't changed things) you get to
at least start the execution of the next instruction which means,
for most instructions, the interrupt will be delivered after the
instruction after the instruction unmasks the irqs.

Actually, this makes no difference at the C level :-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
