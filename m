Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbUKVNpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUKVNpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUKVNnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:43:55 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17068 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262103AbUKVNk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:40:59 -0500
Date: Mon, 22 Nov 2004 15:42:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122144248.GB28211@elte.hu>
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <41A1A6E6.5090807@mrv.com> <20041122100140.GD6817@elte.hu> <41A1EAE0.9080504@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41A1EAE0.9080504@mrv.com>
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

> >>I´m seeing latencies of up to ~2000 microseconds. see attached traces
> >>file for a small sample. I think I´m missing something obvious
> >>config-wise but I don´t know what...
> ...
> 
> >this seems to imply IDE DMA related hardware overhead. Apparently what
> >happens is that with certain motherboards/chipsets, if IDE DMA happens
> >then that DMA transfer _completely locks up_ the system bus. Nothing 
> >happens, and the CPU is stalled in essence until the end of the DMA 
> >request.

> Right on.
> After hdparm -d0 I see maximum latency of 35 us after a full kernel 
> build with a few GUI apps in the background. I´ll try to find a 
> reasonable compromise.

it might make sense to report this to the hw vendor as well, as these
latencies dont occur at _every_ IDE DMA, it might be some sort of
chipset (or BIOS) bug they might want to see resolved as well (if this
isnt a ship-and-forget vendor). 2 msec stalls are not nice to a fair
number of applications.

	Ingo
