Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbUJZLXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUJZLXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbUJZLXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:23:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17053 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262236AbUJZLXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:23:09 -0400
Date: Tue, 26 Oct 2004 13:24:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Michael Geithe <warpy@gmx.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-bk4 and kernel/futex.c:542
Message-ID: <20041026112415.GA21015@elte.hu>
References: <200410261135.51035.warpy@gmx.de> <20041026133126.1b44fb38@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026133126.1b44fb38@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Tue, 26 Oct 2004 11:35:50 +0200
> Michael Geithe <warpy@gmx.de> wrote:
> 
> > hi,
> > here are some error messages after reboot in my logs.
> > 
> > Badness in futex_wait at kernel/futex.c:542
> 
> Hey Ingo,
> 
> this futex.c:542 looks familiar to me (see the BUG logs for RP-V0.2). Dunno
> if it's coincidence though. Just guessing they might be correlated.

yeah, it definitely looks like there is some futex race that the
PREEMPT_REALTIME kernel triggers in no time. (this is because the
locking in the PREEMPT_REALTIME kernel is equivalent to an SMP system
with an infinite number of CPUs and will trigger the same races.)

	Ingo
