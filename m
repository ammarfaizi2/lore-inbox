Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVAKD0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVAKD0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVAKDZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:25:29 -0500
Received: from gprs215-170.eurotel.cz ([160.218.215.170]:3201 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262543AbVAKDVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:21:36 -0500
Date: Tue, 11 Jan 2005 04:21:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: Shaw <shawv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050111032121.GD4092@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz> <20050110174804.GC4641@blackham.com.au> <20050111001426.GF1444@elf.ucw.cz> <20050111011611.GE4641@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111011611.GE4641@blackham.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If I do cli(); sleep(5 hours); sti();, system should survive that. If
> > you do cli(); sleep(5 hours); sti() but fail to compensate for lost
> > ticks, all sorts of funny things might happen if you are comunicating
> > with someone who did not sleep.
> 
> Then shouldn't it be fixed to compensate?
> 
> By including suspend time in jiffies, there becomes absolutely no
> way for a kernel or userspace thread to measure actual usable system
> time. At least if suspend time is not counted, they can use jiffies
> or xtime depending on what they want to do. Making them one and the
> same gives them no choice.

I do not think anyone should know about "actual usable system
time". If you do cli(); sleep(5hours); sti(), you include that in
jiffies, too. I do not see why swsusp should be handled differently.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
