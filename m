Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbULAIyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbULAIyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbULAIyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:54:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7641 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261335AbULAIyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:54:18 -0500
Date: Wed, 1 Dec 2004 09:53:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041201085337.GB15928@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41ACB846.40400@free.fr> <20041130081548.GA8707@elte.hu> <41AD8122.4070108@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AD8122.4070108@mrv.com>
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


* Eran Mann <emann@mrv.com> wrote:

> Seems to be fixed by the patch below:
> 
> --- kernel/latency.c.orig       2004-12-01 10:21:45.000000000 +0200
> +++ kernel/latency.c    2004-12-01 10:11:37.000000000 +0200
> @@ -762,7 +762,9 @@
>         tr->critical_sequence = max_sequence;
>         tr->preempt_timestamp = cycles();
>         tr->early_warning = 0;
> +#ifdef CONFIG_LATENCY_TRACE
>         __trace(CALLER_ADDR0, parent_eip);
> +#endif

thanks, applied it and uploaded -V0.7.31-16.

	Ingo
