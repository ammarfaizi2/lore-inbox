Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUHJMjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUHJMjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUHJMjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:39:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23690 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264726AbUHJMjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:39:18 -0400
Date: Tue, 10 Aug 2004 14:40:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810124020.GA18904@elte.hu>
References: <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <20040810085849.GC26081@elte.hu> <20040810092249.GA29875@elte.hu> <1092137588.16885.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092137588.16885.4.camel@localhost.localdomain>
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


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > another (more remote) possibility is that the timestamp counter gets
> > somehow messed up during MMX ops. Does the ALSA detector use the
> > timestamp counter, or does it only use jiffies? (if it only used jiffies
> > that would give us some robustness since it's an independent
> > time-source.) I suspect 'music indeed skips' isnt a good enough test for
> > this case, given that jackd starts up ...
> 
> The standard VIA EPIA boards are 133Mhz SDRAM or 266Mhz DDR, which is
> shared with video and the graphics engine. Could the MMX copier simply
> be eating all the remaining memory bandwidth so that its in fact
> memory not latency ?

it's a 10 msec latency that got measured, for a single page copy (!) -
if it's memory latency then it must be something really bad...

	Ingo
