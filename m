Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVF1LP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVF1LP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVF1LP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:15:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10644 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261305AbVF1LPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:15:52 -0400
Date: Tue, 28 Jun 2005 13:15:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050628111521.GA21767@elte.hu>
References: <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org> <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu> <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu> <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org> <20050627081542.GA15096@elte.hu> <Pine.LNX.4.58.0506272001190.5720@echo.lysdexia.org> <20050628081053.GC7368@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628081053.GC7368@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > Once, with VLC (viewing a 5mbit/s mcast/udp stream) and two burnP6 
> > instances running, I was able to fire up top on the serial console and 
> > found out that the IRQ thread for the ns83820 nic was using 99% of one 
> > CPU.
> 
> aha! that's an important clue. It seems you've got a screaming interrupt 
> or some other loop in ns83820 irq handling. [...]

i just found and fixed a bug in -RT that could cause screaming 
interrupts. Could you try the -50-28 (or any later) kernel, does it fix 
the problem?

	Ingo
