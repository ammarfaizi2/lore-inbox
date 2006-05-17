Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWEQUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWEQUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 16:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWEQUr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 16:47:59 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:54874 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751105AbWEQUr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 16:47:58 -0400
Subject: Re: [patch 04/50] genirq: cleanup: misc code cleanups
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20060517001524.GE12877@elte.hu>
References: <20060517001524.GE12877@elte.hu>
Content-Type: text/plain
Date: Wed, 17 May 2006 13:47:56 -0700
Message-Id: <1147898876.13483.32.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 02:15 +0200, Ingo Molnar wrote:
> ++ linux-genirq.q/kernel/irq/spurious.c
> @@ -16,22 +16,18 @@ static int irqfixup;
>  /*
>   * Recovery handler for misrouted interrupts.
>   */
> -
>  static int misrouted_irq(int irq, struct pt_regs *regs)
>  {
> -       int i;
> -       irq_desc_t *desc;
> -       int ok = 0;
> -       int work = 0;   /* Did we do work for a real IRQ */
> +       int i, ok = 0, work = 0;

I've seen Andrew do the reverse of this in clean up patches, maybe it's
a case by case type change ..  

Daniel

