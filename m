Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269055AbUHMKPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269055AbUHMKPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUHMKPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:15:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14772 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269055AbUHMKPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:15:12 -0400
Date: Fri, 13 Aug 2004 12:16:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813101651.GD8135@elte.hu>
References: <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092360317.1304.72.camel@mindpipe> <1092360704.1304.76.camel@mindpipe> <1092364786.877.1.camel@mindpipe> <1092369242.2769.1.camel@mindpipe> <1092370997.2769.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092370997.2769.5.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> +#if defined(CONFIG_MCOUNT)
> +extern void mcount(void);
> +EXPORT_SYMBOL_NOVERS(mcount);
> +#endif

yeah, we need this export. (i've put it into kernel/latency.c and it's
fine to do it as an EXPORT_SYMBOL()). Will show up in -O7.

	Ingo
