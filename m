Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWGLIJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWGLIJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWGLIJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:09:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26792 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750776AbWGLIJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:09:24 -0400
Date: Wed, 12 Jul 2006 10:08:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, roubert@df.lth.se,
       stern@rowland.harvard.edu, dmitry.torokhov@gmail.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-ID: <20060712080846.GA1898@elf.ucw.cz>
References: <Pine.LNX.4.64.0607102356460.17704@scrub.home> <20060711124105.GA2474@elf.ucw.cz> <Pine.LNX.4.64.0607120016490.12900@scrub.home> <20060711224225.GC1732@elf.ucw.cz> <Pine.LNX.4.64.0607120132440.12900@scrub.home> <20060711165003.25265bb7.akpm@osdl.org> <Pine.LNX.4.64.0607120213060.12900@scrub.home> <20060711173735.43e9af94.akpm@osdl.org> <Pine.LNX.4.64.0607120248050.12900@scrub.home> <20060711183647.5c5c0204.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711183647.5c5c0204.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > IOW, someone needs to find a way to make the new code work like the old
> > > code without re-breaking Pavel's keyboard.  But the bitchin-to-patchin
> > > ratio here seems to exclude that outcome.
> > 
> > Traditionally that responsibility is in the hands of whose who break it in 
> > the first place
> 
> If that person cannot reproduce the problem but another skilled kernel
> developer can then it would make sense for he-who-can-reproduce-it to do
> some work.
> 
> Still, I doubt if that's the case here.
> 
> 
> Is the below correct?
> 
> Old behaviour:
> 
> 	a) press alt
> 	b) press sysrq
> 	c) release alt
> 	d) press T
> 	e) release T
> 	f) release sysrq
> 
> New behaviour:
> 
> 	a) press alt
> 	b) press sysrq
> 	c) release sysrq
> 	d) press T
> 	e) release T
> 	f) release alt

Plus there was "very old" behaviour:

a) press alt
b) press sysrq
c) press T
d) release T
e) release sysrq
f) release alt

...that worked along with "old" behaviour....

> If so, then the old behaviour was weird and the new behaviour is sensible. 
> What, actually, is the problem?

I'd agree. ...and was _real_ weird.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
