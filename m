Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSGVOYp>; Mon, 22 Jul 2002 10:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGVOYp>; Mon, 22 Jul 2002 10:24:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28435 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317405AbSGVOYo>; Mon, 22 Jul 2002 10:24:44 -0400
Date: Mon, 22 Jul 2002 15:27:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: martin@dalecki.de, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722152750.G2838@flint.arm.linux.org.uk>
References: <3D3C0F49.4070707@evision.ag> <Pine.LNX.4.44.0207221602560.9963-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207221602560.9963-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 04:05:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 04:05:00PM +0200, Ingo Molnar wrote:
> there are some more IRQ subsystem cleanups for which i have patches: such
> as the removal of the pt_regs parameter from the irq handler function,
> it's unused in 99% of the drivers - and the remaining 1% can get at it via
> other means.

If "other means" means knowing that its located in a certain place on the
stack, that's actually bogus.  Any user space task started via exec from
a kernel thread has extra junk on the kernel stack.  Been there already.
;(

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

