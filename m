Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWFCVbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWFCVbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWFCVbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:31:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4074 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751289AbWFCVbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:31:02 -0400
Date: Sat, 3 Jun 2006 23:30:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc5 7/8] Remove some of the kmemleak false positives
Message-ID: <20060603213011.GA20523@elf.ucw.cz>
References: <20060603081054.31915.4038.stgit@localhost.localdomain> <20060603081134.31915.37367.stgit@localhost.localdomain> <20060603204808.GB4629@ucw.cz> <4481F9B3.2020703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4481F9B3.2020703@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>From: Catalin Marinas <catalin.marinas@arm.com>
> >>+		memleak_debug_not_leak(res);
> > 
> > I'd suggest some shorter/more generic name.
> > 
> > 	not_freed(res); ?
> > 
> > 	alloc_forever(res); ?
> 
> It's true that the names are a bit long ("debug" is even superfluous). I
> would, however, keep the memleak_ prefix as I think it makes the code
> clearer (i.e. the function belongs to a certain part of the kernel).

Well, in future some other leak detector may want to use these hooks.

Anyway memleak_not_leak() is already quite good.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
