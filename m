Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVBBNcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVBBNcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVBBNcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:32:15 -0500
Received: from gprs214-27.eurotel.cz ([160.218.214.27]:43654 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262299AbVBBNcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:32:05 -0500
Date: Wed, 2 Feb 2005 14:31:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Message-ID: <20050202133153.GD29579@elf.ucw.cz>
References: <200502021428.12134.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502021428.12134.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have noticed that the condition (cur_freq != cpu_policy->cur), which is
> unlikely() according to cpufreq.c:cpufreq_resume(), occurs on every resume
> on my box (Athlon64-based Asus).  Every time the box resumes, I get a message
> like that:
> 
> Warning: CPU frequency out of sync: cpufreq and timing core thinks of 1600000, is 1800000 kHz.
> 
> (the numbers vary: there may be 800000 vs 1600000 or even 800000 vs 1800000).
> 
> Also, when the box is suspended on AC power and resumed on batteries, it often
> reboots.
> 
> Please let me know if there's anything (relatively simple :-)) that I can do
> about it.

Introduce _suspend() routine to cpufreq, and force cpu to 800MHz
during suspend(). Put it back to right frequency during resume().

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
