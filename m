Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757674AbWKYNCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbWKYNCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 08:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757645AbWKYNCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 08:02:48 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:36105 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1757522AbWKYNCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 08:02:48 -0500
Date: Sat, 25 Nov 2006 13:02:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Kernel-discuss] RFC - platform device, IRQs and SoC devices
Message-ID: <20061125130240.GA13089@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
References: <4563242D.9050901@f2s.com> <45682B0E.4060202@f2s.com> <20061125122910.GA12104@flint.arm.linux.org.uk> <45683C45.8020904@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45683C45.8020904@f2s.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 12:51:17PM +0000, Ian Molton wrote:
> Russell King wrote:
> >It's quite possible to have:
> >
> >IRQ	chip
> >0	irqchip_0
> >1	irqchip_0
> >2	irqchip_1
> >3	irqchip_0
> >4	irqchip_0
> >5	irqchip_1
> >6	irqchip_2
> >7	irqchip_2
> >8	irqchip_2
> >9	irqchip_1
> >
> >Where do you start '0' for each irqchip?  How do you split the irq_desc
> >array between the irqchips?
> 
> I see no reason why this couldnt continue to work 'as is' with the new 
> behaviour only applying to irqchips with their own non-NULL irq_desc array.

That creates a multi-class system.  Not nice from the maintainability
aspect.

Nevertheless, please produce patches to demonstrate this idea in detail.

> The other problem is integration with /proc, specifically the irq usage 
> counter.

There's interrupt numbers elsewhere in procfs other than /proc/interrupts -
eg, the /proc/stat "intr" line is just one example.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
