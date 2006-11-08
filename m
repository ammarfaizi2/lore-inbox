Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965335AbWKHKax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbWKHKax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965398AbWKHKax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:30:53 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:13023 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965335AbWKHKaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:30:52 -0500
Date: Wed, 8 Nov 2006 11:30:23 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Brownell <david-b@pacbell.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, andrew@sanpeople.com
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Message-ID: <20061108113023.0281c0f6@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107213604.692421DC800@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	<20061107122715.3022da2f@cad-250-152.norway.atmel.com>
	<20061107213604.692421DC800@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2006 13:36:04 -0800
David Brownell <david-b@pacbell.net> wrote:

> > +#define EXTERNAL_IRQ_BASE	NR_INTERNAL_IRQS
> > +#define NR_EXTERNAL_IRQS	32
> > +#define GPIO_IRQ_BASE		(EXTERNAL_IRQ_BASE +
> > NR_EXTERNAL_IRQS) +#define NR_GPIO_IRQS		(4 * 32)
> > +
> > +#define NR_IRQS			(GPIO_IRQ_BASE +
> > NR_GPIO_IRQS)
> 
> Did I miss something, or are the IRQs starting at GPIO_IRQ_BASE
> not actually implemented?  There's no irq_chip with name "GPIO"
> or anything.  The AT91 code should be almost a drop-in there...

No, you didn't miss anything, but I do want to implement a "GPIO"
irq_chip like at91 does. I suppose I can reduce NR_IRQS a bit until
it happens, but then again it's perhaps better to just implement the
irq_chip thing...

Haavard
