Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751943AbWCOPLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbWCOPLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWCOPLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:11:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:23176 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751943AbWCOPLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:11:48 -0500
Date: Wed, 15 Mar 2006 16:09:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-rt4
Message-ID: <20060315150933.GA28102@elte.hu>
References: <20060314084658.GA28947@elte.hu> <20060315114510.GA32276@elte.hu> <6bffcb0e0603150517k59996ff8j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0603150517k59996ff8j@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> [1.] One line summary of the problem:
> bug while running t2-l2-2rd-deadlock.tst test.

that's expected: t2-l2-2rd-deadlock.tst provokes a real deadlock, that 
the kernel should report.

but we do not seem to recover from the crash gracefully:

> =============================================
> 
> [ turning off deadlock detection.Please report this trace. ]
> 
> BUG at /usr/src/linux-rt/kernel/latency.c:1801!

> EIP is at sub_preempt_count+0x42/0x138

we should handle this better.

	Ingo
