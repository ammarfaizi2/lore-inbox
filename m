Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266210AbUGJLTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUGJLTB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 07:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUGJLTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 07:19:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54432 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266210AbUGJLS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 07:18:59 -0400
Date: Sat, 10 Jul 2004 13:19:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Elladan <elladan@eskimo.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
Message-ID: <20040710111918.GB22265@elte.hu>
References: <40EE6CC2.8070001@kolivas.org> <40EF2FF2.6000001@bigpond.net.au> <20040710035737.GA7552@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710035737.GA7552@eskimo.com>
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


* Elladan <elladan@eskimo.com> wrote:

> Average wall speed of RT task wakeup isn't really an issue - the issue
> is deterministic worst-case latency.  Adding a hundred cycles every time
> won't cause someone to miss a deadline. [...]

we are dealing here with about half a cycle or so overhead. (an extra
jump back to the 'likely' section) Often the BTB can even totally
eliminate the overhead. Worst-case we've got a slightly larger icache
footprint. But all in one it's not really an issue, and if you compile
for embedded it wont be done by the compiler anyway.

	Ingo
