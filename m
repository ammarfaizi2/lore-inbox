Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUK2M4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUK2M4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUK2Myq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:54:46 -0500
Received: from gprs214-59.eurotel.cz ([160.218.214.59]:22152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261718AbUK2Mxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:53:31 -0500
Date: Mon, 29 Nov 2004 13:53:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1 broke apmd
Message-ID: <20041129125313.GB3291@elf.ucw.cz>
References: <200411291138.iATBcBiR007342@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411291138.iATBcBiR007342@harpo.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Starting with 2.6.10-rc1, date and time on my old APM-based
> laptop is messed up after a resume. Specifically, Emacs and
> xclock both make a huge forward leap and then stop updating
> their current time displays.
> 
> The cause is the "jiffies += sleep_length * HZ;" addition
> to arch/i386/kernel/time.c:time_resume() which is in conflict
> with the hwlock --hctosys that the APM daemon normally does
> at resume.

I do not understand why they interfere... time_resume should fix
system time, then userland sets it to the right value, again. Unless
these two happen in paralel (they should not), nothing bad should happen.

Can you try to suspend, wait, launch hwclock --hctosys manually?
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
