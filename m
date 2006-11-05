Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965394AbWKEUsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965394AbWKEUsG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965840AbWKEUsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:48:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35512 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965394AbWKEUsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:48:03 -0500
Date: Sun, 5 Nov 2006 21:47:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jonathan Lemon <jlemon@flugsvamp.com>
Cc: linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061105204741.GA1847@elf.ucw.cz>
References: <20061103163012.GA84707@cave.trolltruffles.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103163012.GA84707@cave.trolltruffles.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri 2006-11-03 10:30:12, Jonathan Lemon wrote:
> In article <local.mail.linux-kernel/20061103084240.GB1184@2ka.mipt.ru>,
> Evgeniy Polyakov  <johnpol@2ka.mipt.ru> wrote:
> >On Thu, Nov 02, 2006 at 11:40:43AM -0800, Nate Diller
> >kqueue just can not be used as is in Linux (_maybe_ *bsd has different
> >types, not those which I found in /usr/include in my FC5 and Debian
> >distro). It will not work on x86_64 for example. Some kind of a pointer
> >or unsigned long in structures which are transferred between kernelspace
> >and userspace is so much questionable, than it is much better even do
> >not see there... (if I would not have so political correctness, I would
> >describe it in a much different words actually).
> >So, kqueue API and structures can not be usd in Linux.
> 
> Let me be a little blunt here: that is just so much bullshit.
> 
> Yes, I understand the problem that 32-bit userspace on a 64-bit kernel has.
> Mea culpa - I didn't forsee this years ago, and none of my many reviewers
> caught it either.  It was designed for 32/32 and 64/64, not 32/64.
> 
> However, this is trivially fixed by adding a union to the structure, as
> pointed out earlier on this list.  Code would still be source compatible
> with any kqueue apps, which is what counts.  Even NetBSD and FreeBSD have
> differing definitions of the kq constants, and nobody notices.

It has been show in this thread that kevent is too different to kqueue
as is... but what are the advantages of kevent? Perhaps we should use
kqueue on Linux, too (even if it means one more rewrite for you...?)

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
