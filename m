Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269584AbRHHWMs>; Wed, 8 Aug 2001 18:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269591AbRHHWMh>; Wed, 8 Aug 2001 18:12:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5643 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269584AbRHHWMd>;
	Wed, 8 Aug 2001 18:12:33 -0400
Date: Wed, 8 Aug 2001 23:12:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
Message-ID: <20010808231242.D22093@flint.arm.linux.org.uk>
In-Reply-To: <no.id> <E15UV8M-0005SE-00@the-village.bc.nu> <9ksclk$k45$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9ksclk$k45$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Aug 08, 2001 at 02:58:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 02:58:12PM -0700, H. Peter Anvin wrote:
> IRQ 0 is hardwired to the system timer in PC systems, though, so it
                                         ^^^^^^^^^^^^^

Linux doesn't run on only PC systems though, and other systems use
IRQ0 as the (superio-based) parallel port IRQ.

> Good riddance, all this crap...

Indeed - please check the ARM port for our solution to this.  We've
had the NO_IRQ construct for literally years in include/asm-arm/irq.h:

#define NO_IRQ  ((unsigned int)(-1))

Naturally, a similar NO_DMA is defined in dma.h.  The sooner we can get
rid of the "IRQ0 cannot be used" crap from the kernel the better.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

