Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVFMHxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVFMHxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFMHxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:53:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19641 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261416AbVFMHxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:53:15 -0400
Date: Mon, 13 Jun 2005 09:47:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050613074713.GB13878@elte.hu>
References: <20050611191654.GA22301@elte.hu> <Pine.OSF.4.05.10506112123260.2917-100000@da410.phys.au.dk> <20050611200352.GA1477@elte.hu> <1118646527.5729.60.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118646527.5729.60.camel@sdietrich-xp.vilm.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven-Thorsten Dietrich <sdietrich@mvista.com> wrote:

> On Sat, 2005-06-11 at 22:03 +0200, Ingo Molnar wrote:
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> > 
> > > > the jury is still out on the accuracy of those numbers. The test had 
> > > > RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> > > > mostly work with interrupts disabled. The other question is how were 
> > > > interrupt response times measured.
> > > > 
> > > You would accept a patch where I made this stuff optional?
> > 
> > I'm not sure why. The soft-flag based local_irq_disable() should in fact 
> > be a tiny bit faster than the cli based approach, on a fair number of 
> > CPUs. But it should definitely not be slower in any measurable way.
> > 
> 
> Is there any such SMP concept as a local_preempt_disable()  ?

preempt_disable() is always 'local'. (has effect only on the current 
CPU)

	Ingo
