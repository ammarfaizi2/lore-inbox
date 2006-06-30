Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWF3WXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWF3WXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWF3WXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:23:13 -0400
Received: from www.osadl.org ([213.239.205.134]:9882 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751074AbWF3WXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:23:12 -0400
Subject: Re: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Miller <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060630.133123.84974324.davem@davemloft.net>
References: <20060630184745.GA13429@flint.arm.linux.org.uk>
	 <20060630.132128.26278530.davem@davemloft.net>
	 <1151699247.25491.806.camel@localhost.localdomain>
	 <20060630.133123.84974324.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 00:25:27 +0200
Message-Id: <1151706327.25491.847.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 13:31 -0700, David Miller wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 30 Jun 2006 22:27:27 +0200
> 
> > I'll cook it up tomorrow.
> 
> Thanks a lot Thomas. :)

That's what I came up with:

SA_INTERRUPT		IRQF_IRQS_DISABLED
SA_SAMPLE_RANDOM	IRQF_SAMPLE_RANDOM
SA_SHIRQ		IRQF_SHARE_IRQ
SA_PROBEIRQ		IRQF_PROBE_IRQ
SA_TRIGGER_LOW		IRQF_TRIGGER_LOW
SA_TRIGGER_HIGH		IRQF_TRIGGER_HIGH
SA_TRIGGER_FALLING	IRQF_TRIGGER_FALLING
SA_TRIGGER_RISING	IRQF_TRIGGER_RISING
SA_TRIGGER_MASK		IRQF_TRIGGER_MASK
SA_TIMER		IRQF_TIMER

It affects only 720 files :)

	tglx


