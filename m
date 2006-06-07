Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWFGIde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWFGIde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWFGIde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:33:34 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47031 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750895AbWFGIdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:33:33 -0400
Date: Wed, 7 Jun 2006 10:33:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: genirq: fasteoi change for retrigger
Message-ID: <20060607083304.GA31202@elte.hu>
References: <1149660616.27572.138.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149660616.27572.138.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5568]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hi Ingo, Thomas.
> 
> Would you be ok with a small change to the fasteoi handler that
> 
>  - If the interrupt happens while disabled, rather than just doing goto
> out, also mark it pending
>  - In the normal handling code path, clear pending.
> 
> That would allow some sort of soft-disable to work with fasteoi.
> 
> My issue here is on Cell. I have a very strange interrupt controller 
> that can't mask interrupts.

sure, it looks reasonable to me. Thomas?

	Ingo
