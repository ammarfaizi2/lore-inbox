Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVGGTwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVGGTwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVGGTtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:49:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31197 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262228AbVGGTtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:49:31 -0400
Date: Thu, 7 Jul 2005 21:49:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches
Message-ID: <20050707194914.GA1161@elte.hu>
References: <1119299227.20873.113.camel@cmn37.stanford.edu> <20050621105954.GA18765@elte.hu> <1119370868.26957.9.camel@cmn37.stanford.edu> <20050621164622.GA30225@elte.hu> <1119375988.28018.44.camel@cmn37.stanford.edu> <1120256404.22902.46.camel@cmn37.stanford.edu> <20050703133738.GB14260@elte.hu> <1120428465.21398.2.camel@cmn37.stanford.edu> <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Hi all,
> 
> These are one of my latest consolidated results while using (my) 
> jack_test4.2 suite, against a couple of 2.6.12 kernels patched for 
> PREEMPT_RT, on my P4@2.5GHz/UP laptop.
> 
> See anything funny?

hm, you dont seem to have PREEMPT_RT enabled in your .config - it's set 
to PREEMPT_DESKTOP (config-2.6.12-RT-V0.7.51-11.0). OTOH, your 49-01 
config has PREEMPT_RT enabled. So it's not an apples to apples 
comparison. Just to make sure, could you check 51-11 with PREEMPT_RT 
enabled too?

i have just done a jack_test4.1 run, and indeed larger latencies seem to 
have crept in. (But i forgot to chrt the sound IRQ above the network 
IRQ, so i'll retest.)

	Ingo
