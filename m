Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265696AbUF2LKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbUF2LKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUF2LKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:10:37 -0400
Received: from gprs214-172.eurotel.cz ([160.218.214.172]:61315 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265696AbUF2LKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:10:36 -0400
Date: Tue, 29 Jun 2004 13:10:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-ID: <20040629111017.GB15414@elf.ucw.cz>
References: <200406070139.38433.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406070139.38433.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is an update of the scheduler policy mechanism rewrite using the 
> infrastructure of the current O(1) scheduler. Slight changes from the 
> original design require a detailed description. The change to the original 
> design has enabled all known corner cases to be abolished and cpu 
> distribution to be much better maintained. It has proven to be stable in my 
> testing and is ready for more widespread public testing now.
> 
> 
> Aims:
>  - Interactive by design rather than have interactivity bolted on.
>  - Good scalability.
>  - Simple predictable design.
>  - Maintain appropriate cpu distribution and fairness.
>  - Low scheduling latency for normal policy tasks.
>  - Low overhead.
>  - Making renicing processes actually matter for CPU distribution (nice 0 gets 
> 20 times what nice +20 gets)
>  - Resistant to priority inversion

How do you solve priority inversion?

Can you do "true idle threads" now? (I.e. nice +infinity?)
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
