Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135520AbRBEUjU>; Mon, 5 Feb 2001 15:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135748AbRBEUjK>; Mon, 5 Feb 2001 15:39:10 -0500
Received: from host217-32-121-81.hg.mdip.bt.net ([217.32.121.81]:63752 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S135520AbRBEUjG>;
	Mon, 5 Feb 2001 15:39:06 -0500
Date: Mon, 5 Feb 2001 20:41:51 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Q. on marking __initdata
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFFC@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.21.0102052039470.1997-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and, while you are at it, you should (probably) also mark pin_2_irq() and 
IO_APIC_get_PCI_irq_vector() functions as __init as well, for exactly the
same reason as what you noticed.

Regards,
Tigran

On Mon, 5 Feb 2001, Dunlap, Randy wrote:

> Hi,
> 
> Just a question (not a patch proposal):
> 
> Could
> +/* # of MP IRQ source entries */
> +struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
> 
> in arch/i386/kernel/mpparse.c (in 2.4.1-ac3; or in
> arch/i386/kernel/io_apic.c in 2.4.1) be marked as
> __initdata ?  If not, why not?  Or is __initdata
> not needed on it for some reason (and if so, what
> reason)?
> 
> Thanks,
> ~Randy_________________________________________
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
