Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbUKUUth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUKUUth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKUUtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:49:08 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37314 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261775AbUKUUsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:48:33 -0500
Date: Sun, 21 Nov 2004 22:50:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121215059.GA7571@elte.hu>
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <419D13D3.8020409@stud.feec.vutbr.cz> <20041119100541.GA28243@elte.hu> <1100873472.4051.31.camel@localhost.localdomain> <419E288E.8010408@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419E288E.8010408@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >Looking into this, it is because the e100 uses a shared interrupt.  On
> >setup (see drivers/net/e100.c: e100_up) it disables the irq that it will
> >use, and then calls request_irq which calls setup_irq which zeros out
> >the depth of the irq if it is not shared.  So if the e100 is the first
> >to be loaded, then you get this message. 

> Actually I think it shouldn't call either enable or disable because it
> is shared (or allowed to be shared). After creating a patch myself to
> fix this I realized that it had already been fixed in the newest
> version of the driver on sourceforge. Anyway if you are interested in
> this fix temporarily, here it is.

i've included this in my tree, will drop it once -mm merges the
sourceforge e100 driver.

	Ingo
