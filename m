Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267129AbUBSJjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267132AbUBSJjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:39:31 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:22788 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267129AbUBSJj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:39:29 -0500
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Arne Ahrend <aahrend@web.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <4034016C.5070307@pobox.com>
References: <20040122210501.40800ea7.aahrend@web.de>
	 <20040122213757.H23535@flint.arm.linux.org.uk>
	 <20040123232025.4a128ead.aahrend@web.de>
	 <20040124004530.B25466@flint.arm.linux.org.uk> <4034016C.5070307@pobox.com>
Content-Type: text/plain
Message-Id: <1077183550.802.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 19 Feb 2004 10:39:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-19 at 01:21, Jeff Garzik wrote:
> Russell King wrote:
> > On Fri, Jan 23, 2004 at 11:20:25PM +0100, Arne Ahrend wrote:
> > 
> >>>It works for me - with pcnet_cs.  Do you have ipv6 configured into the
> >>>kernel?
> >>
> >>No.
> > 
> > 
> > Argh, it seems that several patches which were in the netdrv experimental
> > tree never got merged.
> > 
> > Jeff - what's the situation with the net driver experimental tree?
> > Could the DEV_STALE_CONFIG patches from around December time be
> > merged please?

I've been experiencing hangs with -mm kernels and my CardBus 3Com NIC
when resuming from APM suspend to disk which seem to be caused by the
3c59x driver. The hang just gets resolved by unplugging, then plugging
the CardBus NIC. This doesn't happen with vanilla tree, however.

I've found that reverting 3c9x-enable_wol.patch fixes this situation for
me.

