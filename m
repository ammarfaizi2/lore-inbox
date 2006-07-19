Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWGSXKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWGSXKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWGSXKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:10:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20615 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932563AbWGSXKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:10:21 -0400
Date: Thu, 20 Jul 2006 01:04:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: scheduling while atomic: events/0/0x00000001/10
Message-ID: <20060719230437.GA16785@elte.hu>
References: <5bdc1c8b0607191242v6c94a346s65febc8a0a27fbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0607191242v6c94a346s65febc8a0a27fbe@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> Hi Ingo,
>   I brought up the -rt kernel on my son's SIS-based machine and got 
> this bug report in dmesg this morning. I've not seen this on previous 
> standard kernels so I thought I might be of interest to you. Let me 
> know what other sort of info you might want to have (if any) and I'll 
> post it along.

> [<d792d629>] sendpacket_done+0x79/0x160 [ndiswrapper] (28)
> [<d79220ae>] NdisMSendComplete+0x1e/0x40 [ndiswrapper] (40)

ndiswrapper ... is it inevitable on that box? Has it been recompiled for 
-rt? Maybe it does things like disable_preempt() that are not rt-safe.

	Ingo
