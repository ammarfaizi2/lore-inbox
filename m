Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVFKTRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVFKTRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVFKTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:17:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11165 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261785AbVFKTRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:17:30 -0400
Date: Sat, 11 Jun 2005 21:16:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050611191654.GA22301@elte.hu>
References: <Pine.OSF.4.05.10506111612070.2917-100000@da410.phys.au.dk> <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> > The current soft-irq states only gives us better hard-irq latency but
> > nothing else. I think the overhead runtime and the complication of the
> > code is way too big for gaining only that. 
> 
> Interrupt response is massive, check the adeos vs. RT numbers . They 
> did one test which was just interrupt latency.

the jury is still out on the accuracy of those numbers. The test had 
RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
mostly work with interrupts disabled. The other question is how were 
interrupt response times measured.

	Ingo
