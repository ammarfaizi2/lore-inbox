Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUKQLGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUKQLGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUKQLE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:04:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44674 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262175AbUKQLEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:04:35 -0500
Date: Wed, 17 Nov 2004 13:05:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Amit Shah <amit.shah@codito.com>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: BUG with 0.7.27-11, with KGDB
Message-ID: <20041117120540.GA19321@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <419A5A53.6050100@cybsft.com> <20041116212401.GA16845@elte.hu> <200411171329.41209.amit.shah@codito.com> <20041117082620.GA23226@nietzsche.lynx.com> <20041117091902.GA31039@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117091902.GA31039@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> +	if (irqflags & SA_NODELAYFORCED) {
> +		irqflags &= ~SA_NODELAYFORCED;
> +		irqflags |= SA_NODELAY;

i've removed the SA_NODELAY-clearing hack from manage.c, that makes
things much cleaner.

	Ingo
