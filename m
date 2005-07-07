Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVGGRyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVGGRyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVGGRwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:52:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11163 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261525AbVGGRvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:51:51 -0400
Date: Thu, 7 Jul 2005 19:51:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
Message-ID: <20050707175115.GA28772@elte.hu>
References: <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain> <20050707153103.GA22782@elte.hu> <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain> <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > > is PCI_MSI enabled by any chance? That is known to break level-triggered
> > > IOAPIC irqs and devices.
> >
> > As a matter of fact it is...   I'll turn it off now and try it out.
> > If the commit is still going, I'll get you a response about the result.
> 
> It did the trick.  I got a network. [...]

ok, i found the PCI_MSI irq handling bug - the fix is in -51-12.

	Ingo
