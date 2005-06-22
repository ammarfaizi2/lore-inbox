Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVFVRgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVFVRgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVFVRge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:36:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19898 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261734AbVFVRf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:35:27 -0400
Date: Wed, 22 Jun 2005 19:34:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: paulmck@us.ibm.com, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622173449.GA22474@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119460803.5825.13.camel@localhost>
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


* Kristian Benoit <kbenoit@opersys.com> wrote:

> Your analysis is correct, but with 600,000 samples, it is possible 
> that we got 2 peeks (perhaps not maximum), one on the logger and one 
> on the target. So in my point of view, the maximum value is probably 
> somewhere between 55us / 2 and 55us - 7us. And probably closer to 55us 
> / 2.

you could try the LPPTEST kernel driver and testlpp utility i integrated 
into the -RT patchset. It avoids target-side latencies almost 
completely. Especially since you had problems with parallel interrupts 
you should give it a go and compare the results.

	Ingo
