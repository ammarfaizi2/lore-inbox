Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUKTKQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUKTKQr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKTKQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:16:46 -0500
Received: from gprs214-41.eurotel.cz ([160.218.214.41]:15488 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261520AbUKTKPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:15:34 -0500
Date: Sat, 20 Nov 2004 11:15:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041120101520.GA1061@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120030340.GA4026@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120030340.GA4026@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >   This patch using pagemap for PageSet2 bitmap, It increase suspend
> > >   speed, In my PowerPC suspend only need 5 secs, cool. 
> > > 
> > >   Test passed in my ppc and x86 laptop.
> > > 
> > >   ppc swsusp patch for 2.6.9
> > >    http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
> > >   Have fun.
> > 
> > BTW here's my curent bigdiff. It already has some rather nice
> > swsusp speedups. Please try it on your machine; if it works for you,
> > try to send your patches relative to this one. I hope to merge these
> > changes during 2.6.11.
> 
> Really big diff, I'll trying.
> 
> Here is my diff.
> 
> Changes:
>   * Change pcs_ to page_cachs_
>   * Hold lru_lock to sure data not modified, I can't sure that full
>    works, but tested passed.

I'd really like to understand why it works (and have it documented
somewhere).

Good test to break swsusp is run kernel compilation in one window and
suspend every 30 seconds from another one.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
