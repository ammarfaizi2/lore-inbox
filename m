Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTAEATw>; Sat, 4 Jan 2003 19:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAEATw>; Sat, 4 Jan 2003 19:19:52 -0500
Received: from dp.samba.org ([66.70.73.150]:6838 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262190AbTAEAST>;
	Sat, 4 Jan 2003 19:18:19 -0500
Date: Sun, 5 Jan 2003 11:25:34 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] irq handling code consolidation, second try (ppc part)
Message-ID: <20030105002534.GA4217@krispykreme>
References: <20030104115910.GF10477@pazke> <1041685293.641.17.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041685293.641.17.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The "easy" way here to implement that is to make the irq_desc array
> larger than NR_IRQs (or rather split NR_IRQs into NR_SYS_IRQS +
> NR_DYNAMIC_IRQS). The additional "slots" could then easily be
> allocated/freed. 

On ppc64 irqs are sparse and can be very large (> 1000) so we have a
mapping between them and slots in irq_desc[NR_IRQS]. I wonder how
hard it would be to kill irq_desc and just dynamically allocate
irq_desc stuff. That would solve my problem.

Anton
