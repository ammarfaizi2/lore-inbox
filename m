Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVGFOAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVGFOAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVGFOAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:00:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60864 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262147AbVGFKFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:05:17 -0400
Date: Wed, 6 Jul 2005 12:04:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
Message-ID: <20050706100451.GA7336@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
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


* William Weston <weston@sysex.net> wrote:

> Here's the results of trying out everything from -50-45 through -51-01 on
> the SMT box:

thanks for the extensive testing!

> -51-01 won't boot:
> 
> softirq-timer/1/13[CPU#1]: BUG in ____up_mutex at kernel/rt.c:1302

i have digged out an older HT-box .config of yours and have reproduced 
an assert quite similar to the one above. Found one bug in that area: 
the assert (conditional on RT_DEADLOCK_DETECT) was done a bit too early, 
i have fixed this in my tree and have uploaded -51-02.

> BTW, -50-44 through -50-51 wouldn't compile on the UP Athlon box.  

do the 51-02 (and later) kernels work on the UP Athlon box?

> -50-43 appears to be rock-solid under the UP non-debug config.  After 
> hammering on it all weekend, Maximum wakeup latency was 14us (from 
> running JACK, phasex, burnK7, dd, and switching from X to text console 
> all at once).

great!

	Ingo
