Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSGVNVQ>; Mon, 22 Jul 2002 09:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSGVNVQ>; Mon, 22 Jul 2002 09:21:16 -0400
Received: from verein.lst.de ([212.34.181.86]:60939 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S315178AbSGVNVQ>;
	Mon, 22 Jul 2002 09:21:16 -0400
Date: Mon, 22 Jul 2002 15:24:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722152416.A18677@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20020722014018.A31813@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207221248250.4519-100000@localhost.localdomain> <20020722152056.A18619@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020722152056.A18619@lst.de>; from hch@lst.de on Mon, Jul 22, 2002 at 03:20:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:20:56PM +0200, Christoph Hellwig wrote:
> I'd prefer the following:
> 
> void irq_off(void);
> void irq_on(void);
> 
> flags_t irq_save();		/* the old irq_save_off() */
> void irq_restore(flags_t);
> 
> void __irq_save(void);		/* without saveing */

					^^^^^ stupid ^^^^^

rmk's sanity checker caught this, should be without disabling.

