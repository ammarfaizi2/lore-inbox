Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWFVItq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWFVItq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWFVItq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:49:46 -0400
Received: from www.osadl.org ([213.239.205.134]:42461 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750898AbWFVItp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:49:45 -0400
Subject: Re: [patch 1/2] genirq: allow usage of no_irq_chip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060622083516.GB25212@flint.arm.linux.org.uk>
References: <20060610085428.366868000@cruncher.tec.linutronix.de>
	 <20060610085435.487020000@cruncher.tec.linutronix.de>
	 <20060621161236.e868284d.akpm@osdl.org>
	 <20060622083516.GB25212@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 10:51:17 +0200
Message-Id: <1150966277.25491.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

On Thu, 2006-06-22 at 09:35 +0100, Russell King wrote:
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Some dumb interrupt hardware has no way to ack/mask.... Instead of creating a
> > > seperate chip structure we allow to reuse the already existing no_irq_chip
> > 
> > This is the patch which causes powerpc to crash.  In a quite ugly manner:
> > early oops, falls into xmon, keeps oopsing from within xmon.  No serial
> > port, too early for netconsole.
> > 
> > I'll drop it.
> 
> Note that dropping it makes the genirq stuff buggy on ARM, so this
> needs to be resolved before it can go anywhere near Linus' tree.

I'm aware of that. I'm looking into the problem, which might be resolved
by Bens outstanding patchset anyway.

	tglx


