Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVKGM0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVKGM0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVKGM0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:26:07 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:61018 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932463AbVKGM0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:26:05 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <buobr0wbrme.fsf@dhapc248.dev.necel.com>
References: <buobr0wbrme.fsf@dhapc248.dev.necel.com>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 12:25:52 +0000
Message-Id: <1131366352.14696.60.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.3.3
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: irq 0?
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 20:54 +0900, Miles Bader wrote:
> I notice that arch/v850/kernel/irq.c has been updated with a
> "show_interrupts" function; in this function it contains the following
> bit of code:
> 
> 
> 	if (i == 0) {
> 		seq_puts(p, "           ");
> 		for (i=0; i < 1 /*smp_num_cpus*/; i++)
> 			seq_printf(p, "CPU%d       ", i);
> 		seq_putc(p, '\n');
> 	}
> 
> 	if (i < NR_IRQS) {
>                 ... show interrupt i ...
> 	} else if (i == NR_IRQS)
> 		seq_printf(p, "ERR: %10lu\n", irq_err_count);
> 
> where "i" is iterated (by procfs) from 0...NR_IRQS.
> 
> On the v850, irq 0 is a real interrupt, so this doesn't really work
> properly -- it doesn't display an entry for irq 0.

What makes you say that? The i==0 code seems to fall through and
therefore should print IRQ0 just fine.

Ian.

-- 
Ian Campbell
Current Noise: Vader - The Final Massacre

Ignore previous fortune.

