Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVCaPXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVCaPXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCaPXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:23:47 -0500
Received: from mx1.elte.hu ([157.181.1.137]:28119 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261469AbVCaPXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:23:37 -0500
Date: Thu, 31 Mar 2005 17:22:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Message-ID: <20050331152240.GA7509@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231D2@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231D2@MAILIT.keba.co.at>
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


* kus Kusche Klaus <kus@keba.com> wrote:

> The following tests are made with 'IRQ 8' at 95, rtc_wakeup at 89(99):
> * Heavy mmap load, no oom: max jitter:     42.1% (   51 usec)
> * Heavy mmap load, oom:    max jitter:  11989.2% (14635 usec)
>   (but still "missed irqs: 0", so IRQ 8 was also blocked for 14 ms)

did you get any kernel messages in that time? (about missed irqs, etc.)  
Please do a 'dmesg -n 0' to minimize the effect of kernel messages.

	Ingo
