Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWCUVS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWCUVS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCUVS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:18:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63957 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750818AbWCUVS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:18:58 -0500
Date: Tue, 21 Mar 2006 22:16:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
Message-ID: <20060321211653.GA3090@elte.hu>
References: <20060320085137.GA29554@elte.hu> <441F8017.4040302@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441F8017.4040302@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> I haven't had a chance to look into it yet but this combination brings 
> with it a significant latency regression, at least as measured by the 
> rtc histogram stuff.

can you also measure it via rtc_wakeup, a'ka:

 chrt -f -p 98 `pidof 'IRQ 8'`
 ./rtc_wakeup -f 8192 -t 100000

? I have just tried it, and -rt4 looks pretty good on the latency front 
(with all debugging disabled).

	Ingo
