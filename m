Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVBILbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVBILbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 06:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVBILbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 06:31:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36053 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261808AbVBILbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 06:31:50 -0500
Date: Wed, 9 Feb 2005 12:31:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Sven Dietrich <sdietrich@mvista.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Preempt Real-time for ARM
Message-ID: <20050209113140.GB13274@elte.hu>
References: <1107628604.5065.54.camel@dhcp153.mvista.com> <1107948492.17747.31.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107948492.17747.31.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 2005-02-05 at 10:36 -0800, Daniel Walker wrote:
> 
> > The biggest point of discussion relates to the interrupts in threads
> > implementation. It is largely identical to what is implemented in the
> > generic irq handling. However, ARM doesn't not implement generic irq
> > handling, and will not support it in the near future. I am not in
> > support of two different threaded interrupt implementations. 
> 
> We have done the conversion to the generic irq handling and it works
> fine on a couple of machines. 

great - this would be a much preferred approach indeed.

> I'm just waiting until the new SMP bits are there before I have
> another go and clean up the missing SMP bits.

any chances for (most of) these bits going upstream as well? In any
case, the -RT tree can be a testbed for this.

	Ingo
