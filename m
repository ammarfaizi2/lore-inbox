Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWHIX30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWHIX30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWHIX30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:29:26 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:62733 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751422AbWHIX3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:29:25 -0400
Date: Thu, 10 Aug 2006 00:29:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Arjan Van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Nicolas Pitre <nico@cam.org>
Subject: Re: lockdep: fix smc91x
Message-ID: <20060809232912.GA29587@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Arjan Van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Nicolas Pitre <nico@cam.org>
References: <20060727144420.GB5178@flint.arm.linux.org.uk> <44D95A58.6070706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D95A58.6070706@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 11:45:28PM -0400, Jeff Garzik wrote:
> Russell King wrote:
> >Hi,
> >
> >When booting using root-nfs, I'm seeing (independently) two lockdep dumps
> >in the smc91x driver.  The patch below fixes both.  Both dumps look like
> >real locking issues.
> >
> >Nico - please review and ack if you think the patch is correct.
> 
> Was this ever ACK'd?

Not afaik.

> I would prefer spin_lock_irqsave(), but that's just a quibble.  I would 
> be OK with applying this.

Yes, though I did review all call paths to make sure it was safe first.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
