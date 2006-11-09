Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754825AbWKIJwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbWKIJwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbWKIJwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:52:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27789 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754825AbWKIJwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:52:03 -0500
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20061109013645.7bef848d.akpm@osdl.org>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
	 <1163024531.3138.406.camel@laptopd505.fenrus.org>
	 <20061108145150.80ceebf4.akpm@osdl.org>
	 <1163064401.3138.472.camel@laptopd505.fenrus.org>
	 <20061109013645.7bef848d.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 09 Nov 2006 10:52:00 +0100
Message-Id: <1163065920.3138.486.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> 70% hit a bug

this part I consider meaningless personally. If it was "70% hit a
regression" or even x% hit a regression I would be a lot more worried.

> 1/7th think it's deteriorating
> 1/4th think lkml response is inadequate
> 3/5ths think bugzilla response is inadequate
> 2/5ths think we have features-vs-stability wrong
after lots of press. 
> 2/3rds hit a bug.  Of those, 1/3rd remain unfixed
> 1/5th of users are presently impacted by a kernel bug
> 
> Happy with that?

I'm not saying things are perfect. Far from that.
What I care about is if things are getting worse or not. My personal
impression is that while things were flakey on the ABI front during
early 2.6 (before 2.6.12 or so), that got fixed because every single bug
is a major annoyance to a large group of people. (and most bugs in the
survey were from before that).

The counter argument to your "doom" data is that bugrates for acpi for
example have been mostly steady, while the number of users has been
increasing quite a bit. 

I don't have the impression things are getting worse personally. I do
hit bugs, in -mm and in -rc kernels, but that is because I'm testing
kernels intended for testing. (another thing that the 70% figure didn't
separate out)

We've gotten better. Adrian started tracking regressions, and that is
helping to make sure that those don't slip through the cracks as much as
they used to (some are unavoidable, especially performance ones or ones
with really obscure hardware that is showing hard to reproduce things).
The -stable series is working out well to fix security and other
annoying bugs quickly post release (because yes things don't get tested
fully until you release), but even -stable is not nearly getting massive
infloods of serious regressions. Sure they are fixing more stuff now,
but that's more a sign that the process is working, and that they are
now picking up less critical stuff as well, than that it is a sign that
things are getting worse.

I'd love if bug responses were better. At the same time, declaring
"bugfix only kernel" isn't going to improve that much; it just creates a
larger flood of stuff for the kernel after that. Do you have the
impression that high quality bug reports on lkml (with this I mean ones
where there is sufficient information, which are not a request for
support and where the reporter actually answers questions that are asked
him) are not getting reasonable attention? 

 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

