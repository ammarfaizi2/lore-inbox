Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266827AbUG1IMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUG1IMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 04:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUG1IK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 04:10:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5317 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266836AbUG1IKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 04:10:06 -0400
Date: Wed, 28 Jul 2004 10:10:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: linux-kernel@vger.kernel.org, "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728081005.GA20100@elte.hu>
References: <20040727225040.GA4370@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727225040.GA4370@yoda.timesys>
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


* Scott Wood <scott@timesys.com> wrote:

> I have attached a patch for implementing IRQ handlers in threads, for
> latency-reduction purposes. [...]

i'm wondering about a couple of details. Why were the changes to
note_interrupt() necessary? Also, why the enable_irq() change? What do
you think about the simpler approach in my patch which keeps the irq
masked until the thread runs?

	Ingo
