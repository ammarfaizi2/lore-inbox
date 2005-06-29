Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVF2Hr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVF2Hr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVF2HpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:45:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35465 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262472AbVF2Hnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:43:53 -0400
Date: Wed, 29 Jun 2005 09:43:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PREEMPT_RT & threading IRQ 0
Message-ID: <20050629074339.GA19129@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <1119460661.491.31.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119460661.491.31.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Ingo, what's the status of putting irq 0 back in a thread with 
> PREEMPT_RT?  IIRC this had some adverse (maybe unfixable?) effects so 
> it was disabled a few months ago.

the jury is still out on that one - but right now it seems it's too much 
complexity for a handful of usecs of latency improvement. Especially 
with things like high-resolution timer support, the threading IRQ0 
doesnt seem to be worth it.

	Ingo
