Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWE3XEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWE3XEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWE3XEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:04:45 -0400
Received: from www.osadl.org ([213.239.205.134]:25549 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964802AbWE3XEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:04:45 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20060530225808.GA5836@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <adawtc34364.fsf@cisco.com> <20060530154521.d737cc65.akpm@osdl.org>
	 <20060530224955.GA5500@elte.hu> <20060530225254.GA5681@elte.hu>
	 <20060530225808.GA5836@elte.hu>
Content-Type: text/plain
Date: Wed, 31 May 2006 01:05:30 +0200
Message-Id: <1149030330.20582.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ed Ben, who is hacking on msi, IIRC

On Wed, 2006-05-31 at 00:58 +0200, Ingo Molnar wrote:
> > > 
> > > does MSI much with the irq_desc[] separately perhaps, clearing 
> > > handle_irq in the process perhaps?
> > 
> > aha - drivers/pci/msi.c sets msix_irq_type, which has no handle_irq 
> > entry. This needs to be converted to irqchips.
> 
> still ... that doesnt explain how the irq_desc[].irq_handler got NULL. 

It has it's own irq_desc array

static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };

Too tired right now. I look into this tomorrow.

	tglx


