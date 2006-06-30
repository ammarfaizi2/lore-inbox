Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933137AbWF3TVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbWF3TVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWF3TVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:21:10 -0400
Received: from www.osadl.org ([213.239.205.134]:53911 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S933140AbWF3TVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:21:07 -0400
Subject: Re: [PATCH] IRQ: Use SA_PERCPU_IRQ, not IRQ_PER_CPU, for
	irqaction.flags
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200606301255.37638.bjorn.helgaas@hp.com>
References: <200606301255.37638.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 21:23:21 +0200
Message-Id: <1151695401.25491.759.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 12:55 -0600, Bjorn Helgaas wrote:
> IRQ_PER_CPU is a bit in the struct irq_desc "status" field, not
> in the struct irqaction "flags", so the previous code checked the
> wrong bit.
> 
> SA_PERCPU_IRQ is only used by drivers/char/mmtimer.c for SGI ia64 boxes.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Doh, good catch.

Acked-by: Thomas Gleixner <tglx@linutronix.de>


