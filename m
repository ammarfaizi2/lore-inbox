Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUJ3Ldl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUJ3Ldl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbUJ3Ldl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:33:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15780 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263702AbUJ3Ldc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:33:32 -0400
Date: Sat, 30 Oct 2004 13:34:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030113441.GA27046@elte.hu>
References: <20041029211112.GA9836@elte.hu> <200410300106.i9U16fXJ010366@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410300106.i9U16fXJ010366@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> IIRC, Rui was running with -p128, which at 48000kHz is 2600usecs (and
> longer at 44100kHz). If the maximum process cycle was on the order of
> 1500usecs, that leaves nearly 1ms until the next interrupt is due.
> Unless jackd was held up between computing the process cycle time and
> entering poll, it doesn't seem that the process cycle ever gets close
> to the interrupt interval duration.

yeah, i'd agree with this, there must be something else going on.

> So I don't think that delays caused *during* jackd's processing cycle
> are involved here. However, I agree that your suggestion to check for
> this before computing max_delay is probably wise in general.

yep.

	Ingo
