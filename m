Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVAJJqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVAJJqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVAJJqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:46:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60938 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262167AbVAJJq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:46:28 -0500
Date: Mon, 10 Jan 2005 09:46:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3] Resend
Message-ID: <20050110094624.A24919@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050110013508.1.patchmail@tglx> <1105318406.17853.2.camel@tglx.tec.linutronix.de> <20050110010613.A5825@flint.arm.linux.org.uk> <1105319915.17853.8.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1105319915.17853.8.camel@tglx.tec.linutronix.de>; from tglx@linutronix.de on Mon, Jan 10, 2005 at 02:18:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 02:18:35AM +0100, Thomas Gleixner wrote:
> On Mon, 2005-01-10 at 01:06 +0000, Russell King wrote:
> > On Mon, Jan 10, 2005 at 01:53:26AM +0100, Thomas Gleixner wrote:
> > > This patch adjusts the ARM entry code to use the fixed up
> > > preempt_schedule() handling in 2.6.10-mm2
> > 
> > Looks PPCish to me.
> 
> Sorry I messed that up. Call me the idiot of today.
> 
> This patch adjusts the ARM entry code to use the fixed up
> preempt_schedule() handling in 2.6.10-mm2

Are you sure ARM suffers from this race condition?  It sets preempt count
before enabling IRQs and doesn't use preempt_schedule().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
