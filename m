Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbUKZWoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUKZWoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUKZWku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:40:50 -0500
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:4481 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262298AbUKZWgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:36:35 -0500
Date: Fri, 26 Nov 2004 23:36:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041126223613.GA1211@elf.ucw.cz>
References: <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <1101455756.4343.106.camel@desktop.cunninghams> <20041126123847.GD1028@elf.ucw.cz> <20041126155443.GA9341@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041126155443.GA9341@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Again, when you're running on limited time, twice as fast is still twice
> > > as fast.
> > 
> > My machine suspends in 7 seconds, and that's swsusp1. According to
> > your numbers, suspend2 should suspend it in 1 second and LZE
> > compressed should be .5 second.
> > 
> > I'd say "who cares". 7 seconds seems like fast enough for me. And I'm
> > *not* going to add 2000 lines of code for 500msec speedup during
> > suspend.
> 
> Yupp.  Premature optimization is the roo of all evil.  swsusp is
> 
>  a) an absolute slowpath compared to any normal kernel operation,
>     and called extremly seldomly
>  b) only usefull for a small subset of all linux instances
> 
> hacking core code (fastpathes) for speedups there is a really bad idea.
> If you can speed it up without beeing intrusive all power to you.

I have to agree here. Swsusp is not really performance critical,
almost every other part of kernel is more important.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
