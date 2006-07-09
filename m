Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWGIAdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWGIAdO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWGIAdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:33:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39848 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161001AbWGIAdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:33:13 -0400
Date: Sun, 9 Jul 2006 02:32:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bojan Smojver <bojan@rexursive.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arjan van de Ven <arjan@infradead.org>,
       Sunil Kumar <devsku@gmail.com>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060709003230.GA1753@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com> <1152377434.3120.69.camel@laptopd505.fenrus.org> <200607082125.12819.rjw@sisk.pl> <1152402366.2584.10.camel@coyote.rexursive.com> <20060708235336.GF2546@elf.ucw.cz> <1152404338.2584.14.camel@coyote.rexursive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152404338.2584.14.camel@coyote.rexursive.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-07-09 10:18:58, Bojan Smojver wrote:
> On Sun, 2006-07-09 at 01:53 +0200, Pavel Machek wrote:
> 
> > swsusp/uswsusp share 75% or so of code, and we can't really drop
> > swsusp soon, because that would break existing setups. Warning
> > year-or-so ahead is needed to do such big changes. Plus you are quite
> > right n that "heavy to setup" thing.
> 
> Ah, right. Thanks for clearing that up.
> 
> So, the plan is that in about a year or so there won't be any completely
> in-kernel suspend implementations, only uswsusp?

No, that was not what I tried to say. Just now, swsusp looks pretty
small (~1000 lines), way too many people use it, and it is too handy
for debugging. So I'm not trying to kill it just now. When klibc gets
into mainline, and pretty much everyone switches to uswsusp, yes, it
will be possible to remove swsusp. For now I'm just trying to keep it
stable and not add features to it, so it is as easy to maintain as
possible.

First sign of swsusp going out is going to be /sys/power/resume
disappearing. It is really badly documented/dangerous hack, and if
your distro uses initrd, anyway.. well you should probably just use
swsusp. It would be nice to remove it in year or two.

I wanted to point out that delay between "okay, I want this gone" and
the code disappearing from kernel tarball is about a year.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
