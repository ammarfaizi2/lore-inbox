Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWGHNwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWGHNwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWGHNwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:52:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9705 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964840AbWGHNwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:52:22 -0400
Date: Sat, 8 Jul 2006 15:51:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.18-rc1 broke resume from APM suspend on Latitude CPi
Message-ID: <20060708135156.GA2912@elf.ucw.cz>
References: <200607081338.k68Dcvux007655@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607081338.k68Dcvux007655@harpo.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-07-08 15:38:57, Mikael Pettersson wrote:
> On Fri, 7 Jul 2006 21:47:37 +0000, Pavel Machek wrote:
> >> Kernel 2.6.18-rc1 broke resume from APM suspend (to RAM)
> >> on my old Dell Latitude CPi laptop. At resume the disk
> >> spins up and the screen gets lit, but there is no response
> >> to the keyboard, not even sysrq. All other system activity
> >> also appears to be halted.
> >> 
> >> I did the obvious test of reverting apm.c to the 2.6.17
> >> version and fixing up the fallout from the TIF_POLLING_NRFLAG
> >> changes, but it made no difference. So the problem must be
> >> somewhere else.
> >
> >driver model changes?
> >
> >Can you retry with minimum drivers loaded, init=/bin/bash?
> 
> Did that, no change.

Too bad... Quite a lot of driver model changes were merged in -rc1...

Can you remove device_*() calls from apm.c and see what happens?
(First do it on 2.6.17 to confirm apm still works without driver
model...)

									Pavel-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
