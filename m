Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVLNPm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVLNPm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 10:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVLNPm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 10:42:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:21658 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S964796AbVLNPm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 10:42:57 -0500
X-ASG-Debug-ID: 1134574974-26613-92-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 14 Dec 2005 07:48:24 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
X-ASG-Orig-Subj: Re: Fwd: [RFC] IRQ type flags
Subject: Re: Fwd: [RFC] IRQ type flags
In-Reply-To: <20051212114759.GA10243@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0512140739560.1678@montezuma.fsmlabs.com>
References: <20051106084012.GB25134@flint.arm.linux.org.uk>
 <20051212114759.GA10243@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6290
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, 12 Dec 2005, Russell King wrote:

> * Move SA_TRIGGER into linux/signal.h

...

> @@ -705,6 +709,12 @@ int setup_irq(unsigned int irq, struct i
>  		desc->running = 0;
>  		desc->pending = 0;
>  		desc->disable_depth = 1;
> +
> +		if (new->flags & SA_TRIGGER_MASK) {
> +			unsigned int type = new->flags & SA_TRIGGER;

Hmm, where is SA_TRIGGER defined?

> +#define SA_TRIGGER_LOW		0x00000008
> +#define SA_TRIGGER_HIGH		0x00000004
> +#define SA_TRIGGER_FALLING	0x00000002
> +#define SA_TRIGGER_RISING	0x00000001
> +#define SA_TRIGGER_MASK	(SA_TRIGGER_HIGH|SA_TRIGGER_LOW|\
> +				 SA_TRIGGER_RISING|SA_TRIGGER_FALLING)

Thanks
