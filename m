Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVGGUBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVGGUBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVGGUBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:01:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20662 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261838AbVGGT7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:59:14 -0400
Date: Thu, 7 Jul 2005 21:59:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches
Message-ID: <20050707195910.GA2014@elte.hu>
References: <1119299227.20873.113.camel@cmn37.stanford.edu> <20050621105954.GA18765@elte.hu> <1119370868.26957.9.camel@cmn37.stanford.edu> <20050621164622.GA30225@elte.hu> <1119375988.28018.44.camel@cmn37.stanford.edu> <1120256404.22902.46.camel@cmn37.stanford.edu> <20050703133738.GB14260@elte.hu> <1120428465.21398.2.camel@cmn37.stanford.edu> <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org> <20050707194914.GA1161@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707194914.GA1161@elte.hu>
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

> i have just done a jack_test4.1 run, and indeed larger latencies seem 
> to have crept in. (But i forgot to chrt the sound IRQ above the 
> network IRQ, so i'll retest.)

with the sound irq chrt-ed to prio 90 the latencies look pretty good:

 ************* SUMMARY RESULT ****************
 Total seconds ran . . . . . . :   300
 Number of clients . . . . . . :    14
 Ports per client  . . . . . . :     4
 Frames per buffer . . . . . . :    64
 Number of runs  . . . . . . . :(    1)
 *********************************************
 Timeout Count . . . . . . . . :(    0)
 XRUN Count  . . . . . . . . . :     0
 Delay Count (>spare time) . . :     0
 Delay Count (>1000 usecs) . . :     0
 Delay Maximum . . . . . . . . :    18   usecs
 Cycle Maximum . . . . . . . . :   637   usecs
 Average DSP Load. . . . . . . :    36.3 %
 Average CPU System Load . . . :    18.8 %
 Average CPU User Load . . . . :    29.3 %
 Average CPU Nice Load . . . . :     0.0 %
 Average CPU I/O Wait Load . . :     0.0 %
 Average CPU IRQ Load  . . . . :     0.0 %
 Average CPU Soft-IRQ Load . . :     0.0 %
 Average Interrupt Rate  . . . :  1680.1 /sec
 Average Context-Switch Rate . : 14361.3 /sec
 *********************************************
 Delta Maximum . . . . . . . . : 0.00000
 *********************************************

and this was with LATENCY_TRACE turned on.

	Ingo
