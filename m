Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUKFHfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUKFHfW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 02:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbUKFHfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 02:35:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37859 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261333AbUKFHfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 02:35:10 -0500
Date: Sat, 6 Nov 2004 08:36:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Michael J. Cohen" <mjc@unre.st>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
Message-ID: <20041106073604.GC8285@elte.hu>
References: <1099567061.7911.4.camel@localhost> <20041104114545.GA3722@elte.hu> <1099573171.7876.0.camel@optie.uni.325i.org> <1099575262.8110.1.camel@optie.uni.325i.org> <20041104140528.GA16604@elte.hu> <1099577631.8090.4.camel@optie.uni.325i.org> <20041104142317.GA19476@elte.hu> <1099593117.7982.14.camel@optie.uni.325i.org> <20041104193819.GB10107@elte.hu> <1099684431.7964.6.camel@optie.uni.325i.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099684431.7964.6.camel@optie.uni.325i.org>
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


* Michael J. Cohen <mjc@unre.st> wrote:

> > hm, have you chrt-ed the soundcard IRQ to a fifo priority higher than
> > 50?

> on my x86-64, there doesn't seem to be an irq for snd-intel8x0.
> 
> optie ~ # cat /proc/interrupts 

> 185:     286001   IO-APIC-level  libata, ehci_hcd, ohci_hcd, ohci_hcd
> 193:      37964   IO-APIC-level  AMD AMD8111

perhaps this IRQ 193 one? Stupid question: there is sound coming out of 
the speakers, right?

> ps ax doesn't seem to show anything sound-related except jackd so I
> tried chrt -f 75 jackd -R -d alsa -P -HMm -z s -o 6
> 
> result during an emerge metadata on V0.7.13:
> 
> **** alsa_pcm: xrun of at least 133.973 msecs
> **** alsa_pcm: xrun of at least 78.544 msecs
> **** alsa_pcm: xrun of at least 245.494 msecs
> 
> *much* better but we're shooting for 0 xruns, no?

yeah, we are.

	Ingo
