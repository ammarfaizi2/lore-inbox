Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVCOWLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVCOWLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCOWLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:11:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30179 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261920AbVCOWLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:11:12 -0500
Date: Tue, 15 Mar 2005 23:07:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com
Subject: Re: rtc misses interrupts after resume
Message-ID: <20050315220712.GA20974@elf.ucw.cz>
References: <20050315220031.GD29715@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050315220031.GD29715@wiggy.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 15-03-05 23:00:31, Wichert Akkerman wrote:
> I recently upgraded my laptop to 2.6.11.3 and removed the notsc boot
> option I added a fairly long time ago to see if things worked properly
> without it now. It seems to work, except that after a resume I get
> an awful lot of these messages:
> 
> Mar 15 09:53:04 typhoon kernel: rtc: lost some interrupts at 1024Hz.
> Mar 15 09:53:06 typhoon last message repeated 103 times
> 
> and indeed looking at /proc/interrupts interrupt 8 is not getting hit.

Can you add code to free_irq 8 before suspend and reacquire it after
resume? If it helps then we have some interrupt routing problems...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
